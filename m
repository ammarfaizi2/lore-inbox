Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVBPPl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVBPPl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 10:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbVBPPlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 10:41:25 -0500
Received: from upco.es ([130.206.70.227]:32713 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262052AbVBPPkJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 10:40:09 -0500
Date: Wed, 16 Feb 2005 16:40:07 +0100
From: Romano Giannetti <romanol@upco.es>
To: Stelian Pop <stelian@popies.net>, Vojtech Pavlik <vojtech@suse.cz>,
       Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-ID: <20050216154007.GA2142@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romanol@upco.es>,
	Stelian Pop <stelian@popies.net>, Vojtech Pavlik <vojtech@suse.cz>,
	Matthew Garrett <mgarrett@chiark.greenend.org.uk>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <20050210161809.GK3493@crusoe.alcove-fr> <E1D0dqo-00041G-00@chiark.greenend.org.uk> <20050214105837.GE3233@crusoe.alcove-fr> <20050214203211.GA8007@ucw.cz> <20050215161412.GC20951@pern.dea.icai.upco.es> <20050216144156.GA4372@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050216144156.GA4372@crusoe.alcove-fr>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2005 at 03:41:59PM +0100, Stelian Pop wrote:
> On Tue, Feb 15, 2005 at 05:14:12PM +0100, Romano Giannetti wrote:

> > http://bugme.osdl.org/show_bug.cgi?id=4124
> 
> Strange indeed.
> 
> First thing to test is to disable sonypi (either rebuild a kernel
> without it or rename the module so it will not get loaded again),
> then reboot and see if you still have problems.
>

I have it compiled in, but it is not loaded: on a freshly booted kernel, 
dmesg | grep sonypi results in nothing, and if I try to load it manually:

# modprobe sonypi
FATAL: Error inserting sonypi (/lib/modules/2.6.11-rc1/kernel/drivers/char/sonypi.ko): No such device

and in syslog:

sonypi: request_region failed

which is correct, because this laptop doesn't have a sonypi devive, it is
a PCG-FX701. I will nuke the module and try to reboot, but I do not think it
will make any difference.

> If you do, the problem is ACPI/input related.
> 
> If you don't, the strangeness comes from some interraction with
> sonypi.

It's happened between 2.6.7 and 2.6.9; the only differences I can see in the
.config are the following: 

+CONFIG_ACPI_BLACKLIST_YEAR=0
+CONFIG_SERIO_RAW=m

... but I do not think they could make any difference. I will compile a
2.6.11-rc4 and try, but... 

Anyway, I have put the dsdt from cat /proc/acpi/dsdt in

http://www.dea.icai.upco.es/romano/linux/mydsdt.bin

Thank you for the help. 

          Romano
          
-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
