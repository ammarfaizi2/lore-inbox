Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315166AbSESU0H>; Sun, 19 May 2002 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315168AbSESU0G>; Sun, 19 May 2002 16:26:06 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:38372 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S315166AbSESU0F>;
	Sun, 19 May 2002 16:26:05 -0400
Date: Sun, 19 May 2002 22:26:00 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200205192026.WAA27881@harpo.it.uu.se>
To: kevin@labsysgrp.com
Subject: Re: lost interrupt hell - Plea for Help
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 May 2002 11:43:09 -0700, Kevin P. Fleming wrote:
>I have just switched motherboards in my file server, which previously had no
>problems ripping audio from my Creative 52X drives. The new motherboard has
>the KT266A chipset, but the CD drives are _not_ connected to that chipset's
>IDE ports. I am getting "lost interrupt" messages when I try to rip audio
>from the drives, or even mount ISO9660 discs (which do eventually succeed,
>they just take over a minute to mount). So far I have done the following:
>
>- turned off "dma" and "unmaskirq" for the CD drives
>- tried ide-scsi/sg instead of ide-cd
>- tried booting with "noapic"
>- tried 2.4.19-pre8 and 2.4.19-pre8-ac4
>
>Nothing has helped. The machine configuration is an MSI KT7266-Pro2RU
>motherboard, KT266A chipset with on-board Promise PDC20265R FastTrak
>"lite"). There is also a Promise PDC20262 (Ultra66TX2) in a PCI slot, and
>that is where the CD drives are connected. Each CD drive is the master on
>its channel, and one of them also has a Iomega ZIP 250 ATAPI drive as its
>slave. Interestingly, the ZIP drive works perfectly, no "lost interrupt"
>messages at all.

1. It's been stated here on LKML several times that optical drives
   should NOT be connected to Promise chips. It may work with Promise's
   Windows drivers, but that doesn't help here. A better strategy is to
   connect your CD-ROMs and Zip drive to the KT266A, and any IDE disks
   either to the FastTrak or the Ultra66 add-on card (though from your
   `lspci` I suppose your disks are SCSI).

2. "noapic" only controls whether the I/O-APIC is used or not.
   If you want to test without the _local_ APIC being enabled,
   then I'm afraid you have to rebuild the kernel with
   CONFIG_X86_UP_APIC disabled.

/Mikael
