Return-Path: <linux-kernel-owner+w=401wt.eu-S1752802AbWLSGl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752802AbWLSGl2 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 01:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWLSGl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 01:41:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:11311 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbWLSGl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 01:41:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:reply-to:x-priority:message-id:to:cc:subject:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=EKAEmRxbLZoZjHN0bUf945LRnwXhcBT3yq7k8Jqrzi2FoAUh7Xcth5I2xk8vb7XKunYJDjTkOBgslCv3JwUgfMiP8Ldo0gRqhWBqNRP26in2u8fIaV8TtWesS1H31XZqth/Lef3Td7hThWeFshdne6eVpCcgVk6Jfsjtolec7To=
Date: Tue, 19 Dec 2006 08:41:24 +0200
From: Paul Sokolovsky <pmiscml@gmail.com>
Reply-To: Paul Sokolovsky <pmiscml@gmail.com>
X-Priority: 3 (Normal)
Message-ID: <1619959760.20061219084124@gmail.com>
To: David Brownell <david-b@pacbell.net>
CC: kernel-discuss@handhelds.org, linux-kernel@vger.kernel.org,
       <linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [PATCH] RTC classdev: Add sysfs support for wakeup alarm (r/w)
In-Reply-To: <200612181659.11473.david-b@pacbell.net>
References: <1866913935.20061217213036@gmail.com> <256202025.20061219015824@gmail.com> <200612181654.30864.david-b@pacbell.net> <200612181659.11473.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

Tuesday, December 19, 2006, 2:59:11 AM, you wrote:

> On Monday 18 December 2006 4:54 pm, David Brownell wrote:

>> > http://handhelds.org/cgi-bin/cvsweb.cgi/linux/kernel26/drivers/rtc/rtc-sa1100.c.diff?r1=1.5&r2=1.6&f=h
>> 
>> That patch you applied looks right to me -- why don't you forward it
>> to Alessandro as a bugfix for 2.6.20-rc2, and save me the effort?

> Actually, correction:  it'd be correct if you ripped out the buggy
> calls to manage the irq wake mechanism.  A later message will show
> how those need to work.  (The IRQ framework will give one helpful
> hint when it warns about mismatched enable/disable calls ...)

  Do you mean enable_irq_wake()/disable_irq_wake() calls? In what way
they are buggy? The only "bug" with them I see is that they are not
implemented for PXA, which just once again reminds that mach-pxa is
real misfit in ARM family (own DMA API instead of fitting with generic
ARM one, no cpufreq support in mainline, and few other not implemented
APIs). That's of course pretty sad, as apparently PXA was/still is
the most popular CPU for consumer market (well, at least in "something
like real computer" caregory) ;-(.

  But those calls are apparently still needed, even if you say that
wakeup stuff should be handled in generic manner, as PM feature, and
on device level. After all, what drivers will do to actually enable
wakeup for a given device? I hope we don't speak about using
CPU-specific registers in reusable device drivers for that.

  This is pretty interesting topic for us, and so far in handhelds.org
ports we don't handle dynamic wakeup configuration at all, so I would
eagerly expect your samples. In the meantime, I went and hacked
.set_wake methods for PXA's irq_chips. And that's when I got idea why
it might haven't been implemented at all - PXA27x's model of wakeup
sources is a bit weird comparing with nice and clean PXA25x's ;-).
It's still not the reason to give up on those calls at all - after
all, even "least common denominator" implementation will give good
value. I yet need to test what I've put together, though.


> - Dave


-- 
Best regards,
 Paul                            mailto:pmiscml@gmail.com

