Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268182AbRHJOGT>; Fri, 10 Aug 2001 10:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268402AbRHJOGH>; Fri, 10 Aug 2001 10:06:07 -0400
Received: from web11803.mail.yahoo.com ([216.136.172.157]:33803 "HELO
	web11803.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S268182AbRHJOFx>; Fri, 10 Aug 2001 10:05:53 -0400
Message-ID: <20010810140605.10175.qmail@web11803.mail.yahoo.com>
Date: Fri, 10 Aug 2001 16:06:05 +0200 (CEST)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [ANNOUNCE] Gujin graphical bootloader 0.4
To: cate@dplanet.ch
Cc: linux-kernel@vger.kernel.org, Gujin-devel@lists.sourceforge.net
In-Reply-To: <3B73DB6C.BEE29C03@math.ethz.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Giacomo Catenazzi <cate@math.ethz.ch> a écrit :
> Etienne Lorrain wrote:
> >  These two files in memory have also to be at fixed linear
> >  addresses in real mode - and if you have a memory manager
> >  (himem.sys) loaded, these address may not be free. Usually
> >  you will find at the bottom of the himem memory the smartdrv
> >  (disk cache) data. It is then impossible to load a file at a random
> >  memory address and stay in real mode to do futher processing.
> >  In this case, Gujin is just malloc'ing the memory (using himem.sys),
> >  loading and decompressing this file (checking its CRC32), and
> >  only then disable interrupts, switch to protected mode, copy
> >  the file at its intended linear address and jump to the kernel
> >  code.
> > 
> 
> hmm.
> 
> You say: BIOS/hardware can be broken, let use DOS do load Linux!

  There are ISA/PCI cards which are initialised before the first sector
 of the HD/FD is loaded (SCSI, network boot ROM or special devices), but
 it is true that they are not usually using memory at 0x100000.
  I have just done this relocation thinking that it may be nice to be
 able to load a kernel over the 16 Mbytes limit - to free a maximum
 of space to the 16 Mb DMA-able area (if DMA is 16 Mb only) - but that
 is stuff for the future because the kernel would be linked at another
 address. I applied this late-relocation in case of himem.

> IMHO using DOS (himem.sys and letting DOS to setting our
> hardware in ibmbio.com and ibmdos.com) give us more problem
> that solution!

  I am not able to open the A20 gate in all the ways himem.sys can,
 objdump will be your friend here. Note that Linux has never booted
 on such a special machine - using I/O ports 0x329 or 0x320 to open A20 -
 I just leave the door open to run from DOS/win, even for beginner
 who do not know what is himem/emm386 - or people wanting to remote
 boot Linux from a DOS/win machine getting vmlinuz from the network.

> We should have complete control to hardware, not letting DOS
> to hide/modify the BIOS segment 0040:0000 and some other
> hardware setting.

  So Gujin will boot from an IDE HD not supported by the BIOS,
 on a VGA card without BIOS (or nearly: see VGA_MEMORY compile switch).
 It can also do what loadlin does - I do not want to maintain two
 identical software.

> Thus we should (if possible) use only BIOS call (or directly hardware),
> but forget DOS. (BTW you know what DOS makes before himem.sys ?
> Do we have the sources?)

  Forget DOS/Win - what a dream... Can I join your dream?

  Etienne.

___________________________________________________________
Do You Yahoo!? -- Vos albums photos en ligne, 
Yahoo! Photos : http://fr.photos.yahoo.com
