Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316113AbSHKSMW>; Sun, 11 Aug 2002 14:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316997AbSHKSMW>; Sun, 11 Aug 2002 14:12:22 -0400
Received: from zooty.lancs.ac.uk ([148.88.16.231]:65508 "EHLO
	zooty.lancs.ac.uk") by vger.kernel.org with ESMTP
	id <S316113AbSHKSMV>; Sun, 11 Aug 2002 14:12:21 -0400
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: steveb@unix.lancs.ac.uk
Date: Sun, 11 Aug 2002 19:16:08 +0100
Subject: Re: 2.4.19 IDE Partition Check issue (again)
To: linux-kernel@vger.kernel.org
Message-Id: <E17dxG4-0008LS-00@wing0.lancs.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some more on this...
at http://www.netzerver.com/downloads/software/firmware/readme320.txt
there's a reference to an issue with Maxtor drives.

They say:
>- Maxtor ATA/66 Disk Compatibility -
>  An ATA/66 disk compatibility issue has been identified and published
>  by Maxtor, which has provided a utility to correct it. The problem
>  manifests itself in one of two ways:
>
>     The system can hang during a power up,
>                   or
>     The system can hang during the first attempt to write to the
>     Maxtor IDE disk.
>
>  According to Maxtor, the incompatibility exists with, but is not
>  limited to, the following chipsets:
>
>     Intel 440TX, 440LX, 440BX
>     VIA 586A, 586B, 596, 686
>     SiS 5598, 5591, 5600, 530, 620
>     ALi 1543C, 1533A-J, 1543A-F
>
>  The host chipset and the Maxtor drives do not negotiate to the same
>  operating mode. It is necessary to force the drive to DMA/33 or
>  DMA/66 mode if using the DMA/66 channels.

Maxtor technical note 21006 (at http://www.maxtor.com/products/diamondmax/techsupport/technicalprocedures/21006.html)
seems to refer to this. There's a tool called UDMAUPDT that (presumably)
pokes the flash on the HDD to say what flavour of UDMA to claim support for.
I guess that you're meant to try all the values until you find one that
works.
I've just all the DMA modes on my drive, the tool seems to work (the
corresponding DMA mode is reported in the boot messages), but it still
fails in the same way - as soon as you try to do anything to the drive with
DMA enabled it goes into a big sulk.

My mobo is an ASUS A7A266, with the latest BIOS (v1011).

I've rejigged my server now - I've put the two drives that work with DMA enabled on to ide0, and the Maxtor and CDROM onto ide1. I'm booting 2.4.19-ac4 with ide=nodma (so that the thing will start) and then manually enabling DMA on hda and hdb with hdparm. Manually enabling DMA on the Maxtor still makes the IDE channel freeze (as does booting without ide=nodma), but it doesn't kill the machine outright now, so it's a bit easier to play with things.

I really do want to get DMA working on this drive (without DMA the performance is ~3.5MB/s as opposed to 40MB/s on the drives with DMA working). If anyone can suggest other things to prod I'd be extremely grateful...


Steve.
