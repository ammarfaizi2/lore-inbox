Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278951AbRJ2CIl>; Sun, 28 Oct 2001 21:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278954AbRJ2CIc>; Sun, 28 Oct 2001 21:08:32 -0500
Received: from mail.courier-mta.com ([66.92.103.29]:52406 "EHLO
	mail.courier-mta.com") by vger.kernel.org with ESMTP
	id <S278951AbRJ2CIU>; Sun, 28 Oct 2001 21:08:20 -0500
In-Reply-To: <fa.e6tgf0v.g6kp2s@ifi.uio.no>
            <fa.dja9fnv.cka9g7@ifi.uio.no>
In-Reply-To: <fa.dja9fnv.cka9g7@ifi.uio.no> 
From: "Sam Varshavchik" <mrsam@courier-mta.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Deadlock with linux kernel
Date: Mon, 29 Oct 2001 02:08:55 GMT
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.3BDCBA37.00004670@ny.email-scan.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika Liljeberg writes: 

> Hi Jeff, 
> 
> I have the exact same symptoms on my PII SMP, 440BX chipset machine, and
> I believe it started around version 2.4.6 as you say. Prior to that, my
> machine would reboot randomly without warning. The latest kernel that
> neither reboots nor locks up is 2.4.0-test9. Sometimes it takes two
> hours, sometimes it takes two days, sometimes it takes longer.

A small SMP bug did indeed slip through in 2.4.6 that nails some SMP 
hardware dead cold.  It should be fixed in the -ac tree know.  Have no idea 
about the spontaneous reboots you were seeing with the earlier kernels. 

> The machine just freezes solid, nothing appears on the console, sysrq
> won't work, leds won't blink, and I suspect the CPUs are spinning (I can
> hear the CPU fans pick up speed, when it happens).

Yup.  If you have the right combination of hardware, in 2.4.6+ you could 
sometimes end up in an infinite loop while holding a spinlock.  I was able 
to hit the jackpot with dual P-IIIs on a 440GX with two aic7xxx HBAs. 

This wouldn't explain your spontaneous reboots, but try booting with 
"noapic". 

-- 
Sam 

