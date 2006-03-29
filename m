Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWC2SIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWC2SIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 13:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWC2SIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 13:08:35 -0500
Received: from mx0.towertech.it ([213.215.222.73]:64647 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1750952AbWC2SIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 13:08:34 -0500
Date: Wed, 29 Mar 2006 20:07:58 +0200
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: bryanh@giraffe-data.com (Bryan Henderson)
Cc: mpm@selenic.com, benh@kernel.crashing.org, ak@muc.de, akpm@osdl.org,
       torvalds@osdl.org, davem@davemloft.net, kkojima@rr.iij4u.or.jp,
       lethal@linux-sh.org, paulus@samba.org, ralf@linux-mips.org,
       rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, smurf@debian.org,
       stenn@whimsy.udel.edu, bunk@stusta.de, lamont@debian.org
Subject: Re: 11 minute RTC update (was Re: Remove RTC UIP)
Message-ID: <20060329200758.2281149b@inspiron>
In-Reply-To: <52304.bryanh@giraffe-data.com>
References: <200603270920.k2R9KYYx007214@shell0.pdx.osdl.net>
	<20060327111836.GA79131@muc.de>
	<20060327163218.GD3642@waste.org>
	<20060327190037.GB27030@muc.de>
	<20060327211143.55ef7c4e@inspiron>
	<1143512075.2284.2.camel@localhost.localdomain>
	<20060329000215.683eb2d5@inspiron>
	<20060329000345.GZ3642@waste.org>
	<20060329031102.0e056d85@inspiron>
	<20060329012137.GB3642@waste.org>
	<20060329034555.11785044@inspiron>
	<52304.bryanh@giraffe-data.com>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Mar 2006 16:49:41 +0000
bryanh@giraffe-data.com (Bryan Henderson) wrote:

> Concerning migration: ntpd presently tells the kernel to go into 11
> minute mode (I think technically, it tells the kernel that it is
> keeping the system time accurate and based on that information, the
> kernel takes the opportunity to keep the hardware clock accurate as
> well, but I think it's practically equivalent).  So that suggests a
> migration path: Step 1: ntpd stops using that flag; Step 2: kernel
> issues warning if someone uses the flag; Step 3: kernel ignores the
> flag.  For 1), ntpd issues a warning that nobody's minding the
> hardware clock unless you pass an option telling it to do hwclock
> --systohc or that you're handling the issue and ntpd needn't warn you
> about it.  I like the latter better.

 I agree with the latter option. I can write a patch for the kernel
 to issue the warning.
 
> BTW, I am the maintainer of hwclock.  This is the first I've heard of
> this discussion, but I have always been a supporter of the kernel
> getting out of the hardware clock maintenance business.  What's this
> about multiple RTC's?

 with the new subsystem that has recently been introduced you can
 have more than one clock. the first one is /dev/rtc0 . udev
 will make a link from /dev/rtc to /dev/rtc0, but it would be
 fine if hwclock can check /dev/rtc0 itself in no device is specified
 on the cmd line.

 One can have a mix of I2C clocks, x86 and maybe external radio
 syncronized clocks all in the same subsystem.
 
 But there's a problem. hwclock waits for the second
 to change before setting the time. It may happen, with some i2c clocks,
 that the oscillator is disabled and that it is started when the
 time is set. Some other devices simply hang and may be restarted only by setting
 the time.

 It would be fine if hwclock can wait for the second to change only
 for a definite amount of time and then always try to set the time.

 It may also happen that reading the time from the device returns
 a failure due to a stopped clock. hwclock should ignore the error.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

