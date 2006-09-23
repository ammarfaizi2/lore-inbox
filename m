Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbWIWR5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbWIWR5e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 13:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbWIWR5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 13:57:33 -0400
Received: from nwd2mail10.analog.com ([137.71.25.55]:35129 "EHLO
	nwd2mail10.analog.com") by vger.kernel.org with ESMTP
	id S1751378AbWIWR5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 13:57:33 -0400
X-IronPort-AV: i="4.09,208,1157342400"; 
   d="scan'208"; a="11938937:sNHT21492408"
Message-Id: <6.1.1.1.0.20060923135128.01ecd0d0@ptg1.spd.analog.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.1.1
Date: Sat, 23 Sep 2006 13:57:50 -0400
To: Matthieu CASTET <castet.matthieu@free.fr>
From: Robin Getz <rgetz@blackfin.uclinux.org>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu wrote:
>On Sat, 23 Sep 2006 02:50:02 -0400, Mike Frysinger wrote:
> >> It would be nice if you could use a generic way to pass this
> >> partition data to the kernel from the mtd medium, instead of 
> hardcoding it here.
> >
> > i often wish for such things myself :)
> >
> > unfortunately, the boot loader we utilize (u-boot) isnt exactly
> > friendly to the idea of managing flash partitions like redboot, and
> > what we have here is the current standard method for defining flash
> > partitions with mtd
> >
>
>humm you could use cmdlinepart [1] and pass the partition as a kernel 
>string with uboot.
>
>That's what we are doing and it works perfectly.

Thanks for the pointer - we will have a look.

> >> > +/* Clock and System Control (0xFFC0 0400-0xFFC0 07FF) */
> >> > +#define bfin_read_PLL_CTL()                  bfin_read16(PLL_CTL)
> >> > +#define bfin_write_PLL_CTL(val)              bfin_write16(PLL_CTL,val)
> >> > +#define bfin_read_PLL_STAT()                 bfin_read16(PLL_STAT)
> >> (and 700 more of these)
> >>
> >> What's the point, are you getting paid by lines of code? Just use the
> >> registers directly!
> >
> > in our last submission we were doing exactly that ... and we were told
> > to switch to a function style method of reading/writing memory mapped
> > registers
>hum, IRRC in your last submission you used volatile to read/write register.
>Some people told you that volatile are evil and you should use a function 
>to read them.
>
>But there no need to these defines. Just use bfin_read16(register_name) in 
>your code.

But then all the driver developers need to remember if a register is 16 or 
32 bits. Blackfin peripherals mix and match, depending on what the silicon 
designer decided what good at the time. (which means if it fits in 16 bits, 
it is a 16-bit register).

I guess we are all lazy, and don't want to have to go through the 
complexity of looking up each register when we use it in a driver.

calling bfin_read_PLL_CTL() which is defined and typecast properly as short 
bfin_read16(PLL_CTL), ensure we resolve issues like this at compile time, 
without having to keep the manual in front of us.

-Robin 
