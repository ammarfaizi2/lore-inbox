Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312486AbSEQLdQ>; Fri, 17 May 2002 07:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEQLdP>; Fri, 17 May 2002 07:33:15 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:27639 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S312486AbSEQLdO>; Fri, 17 May 2002 07:33:14 -0400
Date: Fri, 17 May 2002 13:33:10 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.15: pdc202xx.c compile failure?
In-Reply-To: <20020517103744.GA19298@merlin.emma.line.org>
Message-ID: <Pine.NEB.4.44.0205171330220.18435-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 May 2002, Matthias Andree wrote:

> Hello,

Hi Matthias,

> I used linux-2.5.7 and applied all patches up to 2.5.15 with
> scripts/patch-kernel.
>
> I did make oldconfig ; make dep clean bzImage and compiling the promise
> IDE driver gives this:
>
> make[3]: Entering directory `/suse/kernel/linux-2.5.15/drivers/ide'
> gcc -D__KERNEL__ -I/suse/kernel/linux-2.5.15/include -Wall
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
> -march=i686 -malign-functions=4    -DKBUILD_BASENAME=pdc202xx  -c -o
> pdc202xx.o pdc202xx.c
> pdc202xx.c:1453: unknown field `exnablebits' specified in initializer
>...

this is a known typo.

The fix is simple:

--- linux-2.5.15/drivers/ide/pdc202xx.c	Thu May  9 23:25:39 2002
+++ linux-2.5/drivers/ide/pdc202xx.c	Sun May 12 21:08:10 2002
@@ -1450,7 +1450,7 @@
 		init_chipset: pdc202xx_init_chipset,
 		ata66_check: ata66_pdc202xx,
 		init_channel: ide_init_pdc202xx,
-		exnablebits: {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
+		enablebits: {{0x50,0x02,0x02}, {0x50,0x04,0x04}},
 		bootable: OFF_BOARD,
 		extra: 48,
 		flags: ATA_F_IRQ  | ATA_F_DMA

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

