Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBHXWR>; Thu, 8 Feb 2001 18:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129068AbRBHXWI>; Thu, 8 Feb 2001 18:22:08 -0500
Received: from mailgate1.zdv.Uni-Mainz.DE ([134.93.8.56]:41922 "EHLO
	mailgate1.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S129026AbRBHXWF>; Thu, 8 Feb 2001 18:22:05 -0500
Date: Fri, 9 Feb 2001 00:21:59 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.1-ac7
Message-ID: <20010209002159.A31500@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <E14QwU4-0004QE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14QwU4-0004QE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Feb 08, 2001 at 07:11:57PM +0000
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

somebody screwed up in either the IDE or the PCI code: the IDE driver
doesn't compile when CONFIG_PCI is _disabled_.

  Dominik

Error message:

...
make[3]: Entering directory `/export/source/i486/linux/drivers/ide'
gcc -D__KERNEL__ -I/export/source/i486/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i486    -DEXPORT_SYMTAB -c ide.c
gcc -D__KERNEL__ -I/export/source/i486/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i486    -DEXPORT_SYMTAB -c ide-features.c
gcc -D__KERNEL__ -I/export/source/i486/linux/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2
-march=i486    -c -o ide-proc.o ide-proc.c
ld -m elf_i386 -r -o ide-mod.o ide.o ide-features.o  ide-proc.o
ide-features.o: In function `pci_match_device':
ide-features.o(.text+0x0): multiple definition of `pci_match_device'
ide.o(.text+0x0): first defined here
ide-proc.o: In function `pci_match_device':
ide-proc.o(.text+0x0): multiple definition of `pci_match_device'
ide.o(.text+0x0): first defined here
make[3]: *** [ide-mod.o] Error 1
make[3]: Leaving directory `/export/source/i486/linux/drivers/ide'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/export/source/i486/linux/drivers/ide'
make[1]: *** [_subdir_ide] Error 2
make[1]: Leaving directory `/export/source/i486/linux/drivers'
make: *** [_dir_drivers] Error 2

Output of ver_linux:

-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux gateway 2.4.0-ac9 #1 Tue Jan 16 23:45:51 CET 2001 i486 unknown
Kernel modules         2.4.1
Gnu C                  2.95.3
Gnu Make               3.79.1
Binutils               2.10.1.0.2
Linux C Library        2.2.1
Dynamic linker         ldd (GNU libc) 2.2.1
Procps                 2.0.7
Mount                  2.10q
Net-tools              2.05
Console-tools          0.2.3
Sh-utils               2.0.11
Modules Loaded         ipt_MASQUERADE iptable_nat ip_conntrack ip_tables sb sb_lib uart401 sound soundcore ne 8390 hisax isdn slhc

Relevant .config options:

CONFIG_EXPERIMENTAL=y
...
# CONFIG_PCI is not set
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set
...
#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
..
CONFIG_BLK_DEV_IDECD=y
...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
