Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbTIPHix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTIPHix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 03:38:53 -0400
Received: from wildsau.idv.uni.linz.at ([213.157.128.253]:40902 "EHLO
	wildsau.idv.uni.linz.at") by vger.kernel.org with ESMTP
	id S261802AbTIPHit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 03:38:49 -0400
From: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Message-Id: <200309160736.h8G7a4o3019484@wildsau.idv.uni.linz.at>
Subject: Re: sig11 is back: old troubles with new hardware
In-Reply-To: <20030916083046.A16807@bitwizard.nl>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Date: Tue, 16 Sep 2003 09:36:04 +0200 (MET DST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Have you (recently) read 
> 	http://www.bitwizard.nl/sig11/
> ?

I've read it once again this night ... looking for updates.
 
> Anyway, My guess is that your CPU is overheating. The better your
> RAM-performance, the hotter it gets....

I don't know ... the CPU is at 166x12,5 = 2075Mhz. (xp 2600+). I'm
using the "optimal" bios-settings (conservative memory timings), which
are expected to give a stable system (ha!).

I can trigger the crash pretty fast:

    #!/bin/bash
    mount -r /dec/hdc3 /mnt
    while [ 1 ]; do
      echo 'cp /mnt/home/herp/RedHat/RH73/val*iso /root/tmp'
      cp /mnt/home/herp/RedHat/RH73/val*iso /root/tmp
    done

this resuls in a kernel panic usually within < 5 minutes, (2 minutes this try),
even if this is the only job the machine is doing, even after having
been powered off for the some hours (should be cold then, and summer is
alrady over, the temperature in the morning also shouldn't be a problem :)

the "val*iso" are all the iso-images from redhat-7.3. it usually crashes
within <= 3rd time in the loop. oh - and last time, it just froze, no
crash, but keyboard locked, softcursor (framebuffer) not blinking anymore.

regards,
herber rosmanith

 
> 			Roger. 
> 
> 
> On Tue, Sep 16, 2003 at 01:46:47AM +0200, H.Rosmanith (Kernel Mailing List) wrote:
> > 
> > hi,
> > 
> > word of warning: this is more hardware-related, and not much kernel-related. however,
> > I think this article could probably be helpful to others (and to me ;-) ???
> > 
> > some of you surely remember sig11 when compiling kernels? I feel uncomfortably reminded
> > of the "old days". sig11 is back :-( but first to some "kernel panics"...
> > 
> > recently, I bought a new machine:
> > 
> > board: asus a7n8x deluxe (the non-deluxe doesnt have fireware).
> >        the board has 3 memory slots.
> >        this thing has an nfroce chipset (is that bad?)
> > cpu: amd 2600+
> > ram: 2x512MB DDRAM@400Mhz
> > 
> > First, I tried to copy my old disk to the new one, so I had to format the
> > new partion. The annoying thing here was that I saw 7 out of 10 kernel
> > panics when trying to "mke2fs /dev/hdc3" (a 60Gb partition). I was tempted
> > to send a report to this list, but then I noticed, that the crash occured
> > in various places each kernel-panic. One time it was in ide-dma ("kernel bug
> > in ide-dma line 289), then it was "kernel bug in highmem.c:151", then it was
> > in an interrupt-handler, another time the register dump looked impossible
> > (all register values 00000000 ?) and so on. It appeared rather random as to where
> > it would crash.
> > 
> > Then I exchanged the DDRAM (I had some spare 333Mhz DDRAM home) and suddenly I
> > didn't have any panics anymore. So I went to the dealer and asked to exchange
> > the DDRAMs, but it turned out that all of his DDRAMs failed (he buys from one
> > manufacturer only). So later he exchanged them to 400Mhz DDRAMs, which *seemed*
> > to work. However, back at home, the 2nd or 3rd "mke2fs /dev/hdc3" resulted in
> > a "kernel panic" again. I experimented with the hardware.... and noticed, that,
> > when setting the speed for the DDRAM to 333 instead of 400, it wouldn't crash.
> > Then I began wondering what "Single channel mode" means when the computer
> > boots....and, thanks to a friend on irc, plugged one piece DDRAM into the 3rd
> > slot, leaving the 2nd slot unplugged. so, I have 512MB in slot1, slot2 is empty,
> > and the other 512MB in slot3. now, when booting, the machine said
> > "Dual channel mode" and now even at 400Mhz memory frequency, I saw no kernel-panics
> > anymore ... or so I thought! (ha!)
> > 
> > For one, does anyone know why I get this panics (which are result of hardware
> > problems, and not kernel-problems, of course) when in "single channel mode"?
> > 
> > Next, I tried some stress-testing: I did "cp /mnt/RedHat/RH73/valhal*iso ~/temp" about
> > 20 times. /mnt is another hd, not the cdrom. So, the system started copying all these
> > iso-images ... first image, 2nd image, 3rd image and so on ... it looked pretty okay, but
> > then again after about ... 10 times copying(?), *booouum* ... kernel panic.
> > 
> > 
> > I also wanted to check out the speed of the machine. Most of the time it was
> > pretty okay, but then ... I got something like "cpp pipe has closed unexpectedly,
> > gcc got signal11". "Oh no!", I screamed out in thought, "NOT AGAIN! This has last
> > happened 1995 !"
> > 
> > Of course, this is defintely a hardware-bug. But I wonder what to do about it.
> > to sum it up:
> > 
> > some 333Mhz DDRAM give kernel panics when operating at 333Mhz.
> > some 400Mhz DDRAM give lot of kernel panics when operating at 400Mhz in "single channel mode"
> > some 400Mhz DDRAM give few kernel panics when operating at 400Mhz in "dual channel mode"
> > the same 400Mhz DDRAM (seems!!) works well when operated at 333Mhz, but then, why
> > should I buy a expensive 400Mhz DDRAM when I can use it only at 333Mhz.
> > (I know that this are not all combinations)
> > 
> > what do you think, where is the problem? I doubt that all the RAMs I have tried
> > are broken. To me, the next suspect is the board.... it seems that the number
> > of panics increase when the DRAMS are in slot 1 & 2 (single channel mode).
> > I havent tried if the 400Mhz DDRAM@333Mhz causes crashes in "single channel mode".
> > 
> > well.
> > I'm curious...do any of you experience problems of that kind with the
> > nforce chip or the asus a7n8x board?
> > 
> > best regards,
> > h.rosmanith
> > 
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> -- 
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
> *-- BitWizard writes Linux device drivers for any device you may have! --*
> **** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
> 
