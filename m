Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263241AbTDWVOG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 17:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTDWVOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 17:14:06 -0400
Received: from customer204.globaltap.com ([206.104.238.204]:59045 "HELO
	annexa.net") by vger.kernel.org with SMTP id S263241AbTDWVOF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 17:14:05 -0400
Subject: Re: Need help with lockups on tyan s2460 motherboard in SMP mode
From: James Strandboge <jamie@tpptraining.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1051018709.3235.55.camel@sirius.strandboge.cxm>
References: <1051018709.3235.55.camel@sirius.strandboge.cxm>
Content-Type: text/plain
Organization: Targeted Performance Partners, LLC
Message-Id: <1051133171.1589.32.camel@sirius.strandboge.cxm>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Apr 2003 17:26:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-22 at 09:38, James Strandboge wrote:
> I have a dual AMD 1600+ (MP processors) system with tyan s2460
> motherboard that freezes with no error messages in syslog.  

First off, thank you to everyone who responded-- your input helped me
figure this out.  I wanted to send this to the lists so others might
benefit.

As it turns out, the problem appears to have been solely heat related. 
I ended up installing a vanilla 2.4.20 kernel with smp for 386 (ie no
pentium or athlon optimizations), without acpi, but with apm as a
module.  I disabled power management in the BIOS, and boot with only
apm=power-off for kernel command line arguments.  Notice I did NOT use
noapic.  The kernel boots fine and has no APIC errors (though there is
that errata #22 message).  I then installed lm_sensors 2.7.0 and
i2c-2.7.0 so I could read the temperature.

The temperature readings for the 3904 transistor are the ones to use,
since they are closest to those in the BIOS.  I called tyan and spoke
with someone on the phone, and he said that the system will lock up
around 60C (not the advertised 80-90C, because the sensor is reading air
temperature).  With the case all closed up I ran two kernel compiles,
and two 'top -d .01' instances all at once.  Then I ran 'sensors' every
30 seconds, and sure enough, the computer got near 60C and crashed.  I
took the sides off the case, and used an oscillating fan to blow air
into the computer and rebooted.  'sensors' now shows the temperature
between 39-43C and has been running the above stress test for several
hours (it has never run it for that long).

So now I will be buying some additional fans and making sure the air
flow is good in the case.  I also whole heartedly recommend using
lm_sensors.  It REALLY helped with debugging this issue.

Jamie

-- 
James Strandboge
Targeted Performance Partners, LLC
Web: http://www.tpptraining.com
E-mail: jamie@tpptraining.com
Tel: (585) 271-8370
Fax: (585) 271-8373

