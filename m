Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWIWGuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIWGuE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 02:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWIWGuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 02:50:04 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:48275 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751149AbWIWGuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 02:50:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TVlzWBSHbjwR5yWQyBnEBYQNv4V6WqJI2pSwDCKzEFaHUUk71q3Y89RKX7+OwhEkDu/GazOPXdPYGgxDFSJjAIRkEL0Q6xRzx+0QisvtV/Lx9psNNgyP2oy4PrmIJZjdfvT4VgLbEl5hsGLEsfa2X1I4LziIc1yt9BE/FjvOz38=
Message-ID: <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
Date: Sat, 23 Sep 2006 02:50:02 -0400
From: "Mike Frysinger" <vapier.adi@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Luke Yang" <luke.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200609230218.36894.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/06, Arnd Bergmann <arnd@arndb.de> wrote:
> Use pr_debug here instead of making up your own macros

done

> static inline void

done

> It would be nice if you could use a generic way to pass this partition data
> to the kernel from the mtd medium, instead of hardcoding it here.

i often wish for such things myself :)

unfortunately, the boot loader we utilize (u-boot) isnt exactly
friendly to the idea of managing flash partitions like redboot, and
what we have here is the current standard method for defining flash
partitions with mtd

> Use C99 initializers here, like

done

> There is not much point in trying to use the same numbers as an existing
> architecture if that means that you have to leave holes like setup().
> I don't know if you still have the choice of completely changing the
> syscall numbers, but it would make it nicer in the future.

we do, fortunately, have this luxury ... so we can look forward to a
nice cleaning of our syscall interface

> What's th point of these files, can't you just remove them all?

punted

> > +#define BUG() do { \
> > +     dump_stack(); \
> > +     printk("\nkernel BUG at %s:%d!\n", __FILE__, __LINE__); \
> > +     panic("BUG!"); \
> > +} while (0)
>
> This is probably better done as an external function:

*shrug* i just did it the same way everyone else does ... i'm a sheep like that

> > diff -urN linux-2.6.18/include/asm-blackfin/mach-bf533/anomaly.h
> linux-2.6.18.patch1/include/asm-blackfin/mach-bf533/anomaly.h
> > --- linux-2.6.18/include/asm-blackfin/mach-bf533/anomaly.h    1970-01-01
> 08:00:00.000000000 +0800
> > +++ linux-2.6.18.patch1/include/asm-blackfin/mach-bf533/anomaly.h     2006-09-21
> 09:29:49.000000000 +0800
> > @@ -0,0 +1,172 @@
> > +/*
> > + * File:         include/asm-blackfin/mach-bf533/anomaly.h
>
> You seem to have lots of these machine specfic header files in include/asm.
> Please move them to the respective machine implementation directory
> if they are only used from there

these are arch specific, not machine (aka board)

this is what the blackfin family looks like (first entry is the architecture):
 - BF535
 - BF533 / BF532 / BF531
 - BF537 / BF536 / BF534
 - BF561

which is why you find the anomaly definitions in the architecture
specific header dir

> > +/* Clock and System Control (0xFFC0 0400-0xFFC0 07FF) */
> > +#define bfin_read_PLL_CTL()                  bfin_read16(PLL_CTL)
> > +#define bfin_write_PLL_CTL(val)              bfin_write16(PLL_CTL,val)
> > +#define bfin_read_PLL_STAT()                 bfin_read16(PLL_STAT)
> (and 700 more of these)
>
> What's the point, are you getting paid by lines of code? Just use
> the registers directly!

in our last submission we were doing exactly that ... and we were told
to switch to a function style method of reading/writing memory mapped
registers

> One more thing about the headers: please add a Kbuild file in there so
> 'make headers_install' works

will do

thanks for reading through that monster :)
-mike
