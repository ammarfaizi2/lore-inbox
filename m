Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRBBLhb>; Fri, 2 Feb 2001 06:37:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRBBLhW>; Fri, 2 Feb 2001 06:37:22 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:42504 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S129442AbRBBLgq>; Fri, 2 Feb 2001 06:36:46 -0500
Message-ID: <3A7A944D.A2AB9FE@namesys.com>
Date: Fri, 02 Feb 2001 14:04:45 +0300
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Jan Kasprzak <kas@informatics.muni.cz>
CC: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <20010202122849.A4088@informatics.muni.cz>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is why our next patch will detect the use of gcc 2.96, and complain, in the
reiserfs Makefile.

Hans

Jan Kasprzak wrote:
> 
>         Hello,
> 
>         with ReiserFS support in 2.4.1 I have decided to give it a try.
> I created a filesystem on a spare partition, mounted it as /mnt,
> and tried to use it. The kernel crashed - I am able to reproduce it
> with the following steps:
> 
> - boot linux with init=/bin/bash
> - [optional] /sbin/mkreiserfs /dev/hdd1 (it can be reproduced even
>         on freshly created FS)
> - mount -t reiserfs /dev/hdd1 /mnt
> - cp -arv /usr /mnt
> 
>         I am attaching the details, feel free to ask for more information,
> if you want it. Please Cc: me in any reply.
> 
> Oops is a NULL pointer dereference at address 00000010,
> EIP is c017c7c3 (in check_leaf), EFLAGS is 00010292, Process is "cp",
> Code: 8b 52 10 ff d2 59 5b 8b 54 24 14 8b 42 34 89 c7 0f b7 47 02,
> Call trace is the following:
>         c015f459 (in do_balance)
>         c0179466 (in fix_nodes)
>         c0179476 (also in fix_nodes)
>         c018612c (in reiserfs_insert_item)
>         c0173cb4 (near the end of reiserfs_new_symlink)
>         c0174170 (in reiserfs_new_inode)
>         c0170cbd (in reiserfs_symlink)
>         c0142a45 (in d_alloc)
>         c013c825 (in vfs_symlink)
>         c013c8de (in sys_symlink)
>         c0109023 (in system_call)
> 
>         All numbers are written by hand from the screen, so there may
> be a minor mistakes. Looking at the cp output, it seems it crashed
> while copying the symlink "/usr/bin/sgml2xml -> osx" to /mnt/bin.
> 
>         My computer is almost generic Red Hat 7.0 with all updates.
> Hardware is K6-2 @523 MHz, 128M RAM, VIA VT82C598 north bridge.
> 
>         I tried to create ext2 filesystem on /dev/hdd1, and then
> cp -arv /usr /mnt worked fine.
> 
>         The kernel config (grep '=[ym]' /usr/src/linux/.config) is the
> following (no modules were loadaed, though):
> 
> CONFIG_X86=y
> CONFIG_ISA=y
> CONFIG_UID16=y
> CONFIG_EXPERIMENTAL=y
> CONFIG_MODULES=y
> CONFIG_KMOD=y
> CONFIG_MK6=y
> CONFIG_X86_WP_WORKS_OK=y
> CONFIG_X86_INVLPG=y
> CONFIG_X86_CMPXCHG=y
> CONFIG_X86_BSWAP=y
> CONFIG_X86_POPAD_OK=y
> CONFIG_X86_ALIGNMENT_16=y
> CONFIG_X86_TSC=y
> CONFIG_X86_USE_PPRO_CHECKSUM=y
> CONFIG_NOHIGHMEM=y
> CONFIG_MTRR=y
> CONFIG_NET=y
> CONFIG_PCI=y
> CONFIG_PCI_GOANY=y
> CONFIG_PCI_BIOS=y
> CONFIG_PCI_DIRECT=y
> CONFIG_HOTPLUG=y
> CONFIG_PCMCIA=y
> CONFIG_CARDBUS=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSCTL=y
> CONFIG_KCORE_ELF=y
> CONFIG_BINFMT_AOUT=m
> CONFIG_BINFMT_ELF=y
> CONFIG_BINFMT_MISC=y
> CONFIG_PARPORT=m
> CONFIG_PARPORT_PC=m
> CONFIG_PARPORT_PC_FIFO=y
> CONFIG_PARPORT_PC_SUPERIO=y
> CONFIG_PARPORT_1284=y
> CONFIG_BLK_DEV_FD=m
> CONFIG_BLK_DEV_LOOP=m
> CONFIG_PACKET=y
> CONFIG_PACKET_MMAP=y
> CONFIG_NETLINK=y
> CONFIG_RTNETLINK=y
> CONFIG_UNIX=y
> CONFIG_INET=y
> CONFIG_INET_ECN=y
> CONFIG_IPV6=m
> CONFIG_IPV6_EUI64=y
> CONFIG_IDE=y
> CONFIG_BLK_DEV_IDE=y
> CONFIG_BLK_DEV_IDEDISK=y
> CONFIG_IDEDISK_MULTI_MODE=y
> CONFIG_BLK_DEV_IDECS=m
> CONFIG_BLK_DEV_IDECD=m
> CONFIG_BLK_DEV_IDEPCI=y
> CONFIG_IDEPCI_SHARE_IRQ=y
> CONFIG_BLK_DEV_IDEDMA_PCI=y
> CONFIG_IDEDMA_PCI_AUTO=y
> CONFIG_BLK_DEV_IDEDMA=y
> CONFIG_IDEDMA_PCI_WIP=y
> CONFIG_IDEDMA_NEW_DRIVE_LISTINGS=y
> CONFIG_BLK_DEV_VIA82CXXX=y
> CONFIG_IDEDMA_AUTO=y
> CONFIG_BLK_DEV_IDE_MODES=y
> CONFIG_NETDEVICES=y
> CONFIG_NET_ETHERNET=y
> CONFIG_NET_VENDOR_3COM=y
> CONFIG_VORTEX=y
> CONFIG_HAMACHI=m
> CONFIG_PPP=m
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_WAN=y
> CONFIG_COSA=m
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_UNIX98_PTYS=y
> CONFIG_PRINTER=m
> CONFIG_MOUSE=y
> CONFIG_PSMOUSE=y
> CONFIG_NVRAM=m
> CONFIG_RTC=m
> CONFIG_AGP=y
> CONFIG_AGP_VIA=y
> CONFIG_DRM=y
> CONFIG_DRM_MGA=y
> CONFIG_PCMCIA_SERIAL=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_REISERFS_FS=y
> CONFIG_REISERFS_CHECK=y
> CONFIG_ISO9660_FS=m
> CONFIG_PROC_FS=y
> CONFIG_DEVPTS_FS=y
> CONFIG_EXT2_FS=y
> CONFIG_CODA_FS=m
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> CONFIG_NFSD=m
> CONFIG_NFSD_V3=y
> CONFIG_SUNRPC=y
> CONFIG_LOCKD=y
> CONFIG_LOCKD_V4=y
> CONFIG_MSDOS_PARTITION=y
> CONFIG_VGA_CONSOLE=y
> CONFIG_VIDEO_SELECT=y
> CONFIG_SOUND=y
> CONFIG_SOUND_ES1371=y
> CONFIG_USB=m
> CONFIG_USB_DEVICEFS=y
> CONFIG_USB_UHCI=m
> CONFIG_USB_AUDIO=m
> CONFIG_USB_SCANNER=m
> 
>         The dmesg output:
> 
> Linux version 2.4.1 (root@calypso.fi.muni.cz) (gcc version 2.96 20000731 (Red Hat Linux 7.0)) #2 Fri Feb 2 11:46:21 CET 2001
> BIOS-provided physical RAM map:
>  BIOS-e820: 000000000009fc00 @ 0000000000000000 (usable)
>  BIOS-e820: 0000000000000400 @ 000000000009fc00 (usable)
>  BIOS-e820: 0000000000010000 @ 00000000000f0000 (reserved)
>  BIOS-e820: 0000000000010000 @ 00000000ffff0000 (reserved)
>  BIOS-e820: 0000000007ef0000 @ 0000000000100000 (usable)
>  BIOS-e820: 000000000000d000 @ 0000000007ff3000 (ACPI data)
>  BIOS-e820: 0000000000003000 @ 0000000007ff0000 (ACPI NVS)
> On node 0 totalpages: 32752
> zone(0): 4096 pages.
> zone(1): 28656 pages.
> zone(2): 0 pages.
> Kernel command line: auto BOOT_IMAGE=linux ro root=301 BOOT_FILE=/boot/linux no-hlt
> Initializing CPU#0
> Detected 524.100 MHz processor.
> Console: colour VGA+ 80x50
> Calibrating delay loop... 1045.29 BogoMIPS
> Memory: 126608k/131008k available (1153k kernel code, 4012k reserved, 396k data, 64k init, 0k highmem)
> Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
> Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
> Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
> Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
> CPU: Before vendor init, caps: 008021bf 808029bf 00000000, vendor = 2
> CPU: L1 I Cache: 32K (32 bytes/line), D cache 32K (32 bytes/line)
> CPU: After vendor init, caps: 008021bf 808029bf 00000000 00000002
> CPU: After generic, caps: 008021bf 808029bf 00000000 00000002
> CPU: Common caps: 008021bf 808029bf 00000000 00000002
> CPU: AMD-K6(tm) 3D processor stepping 0c
> Checking 'hlt' instruction... disabled
> POSIX conformance testing by UNIFIX
> mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
> mtrr: detected mtrr type: AMD K6
> PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
> PCI: Using configuration type 1
> PCI: Probing PCI hardware
> PCI: Using IRQ router VIA [1106/0586] at 00:07.0
> Activating ISA DMA hang workarounds.
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> Initializing RT netlink socket
> DMI 2.2 present.
> 33 structures occupying 873 bytes.
> DMI table at 0x000F0800.
> BIOS Vendor: Award Software International, Inc.
> BIOS Version: 4.51 PG
> BIOS Release: 03/15/99
> System Vendor: VIA Technologies, Inc..
> Product Name: VT82C597.
> Version  .
> Serial Number  .
> Starting kswapd v1.8
> Detected PS/2 Mouse Port.
> pty: 256 Unix98 ptys configured
> block: queued sectors max/low 84088kB/28029kB, 256 slots per queue
> Uniform Multi-Platform E-IDE driver Revision: 6.31
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> VP_IDE: IDE controller on PCI bus 00 dev 39
> VP_IDE: chipset revision 6
> VP_IDE: not 100% native mode: will probe irqs later
> VP_IDE: VIA vt82c586b IDE UDMA33 controller on pci0:7.1
>     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
>     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
> hda: ST38410A, ATA DISK drive
> ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
> hdd: ST320423A, ATA DISK drive
> ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> ide1 at 0x170-0x177,0x376 on irq 15
> hda: 16841664 sectors (8623 MB) w/512KiB Cache, CHS=1048/255/63, UDMA(33)
> hdd: 40011300 sectors (20486 MB) w/512KiB Cache, CHS=39693/16/63, UDMA(33)
> Partition check:
>  hda: hda1 hda2 hda3
>  hdd: hdd1
> Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
> ttyS00 at 0x03f8 (irq = 4) is a 16550A
> ttyS01 at 0x02f8 (irq = 3) is a 16550A
> PCI: Found IRQ 9 for device 00:09.0
> PCI: The same IRQ used for device 00:08.1
> 3c59x.c:LK1.1.12 06 Jan 2000  Donald Becker and others. http://www.scyld.com/network/vortex.html $Revision: 1.102.2.46 $
> See Documentation/networking/vortex.txt
> eth0: 3Com PCI 3c905 Boomerang 100baseTx at 0xe000,  00:60:97:36:90:ac, IRQ 9
>   product code 'HH' rev 00.0 date 11-11-96
>   8K word-wide RAM 3:5 Rx:Tx split, autoselect/MII interface.
>   MII transceiver found at address 24, status 782f.
>   Enabling bus-master transmits and whole-frame receives.
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 94M
> agpgart: Detected Via MVP3 chipset
> agpgart: AGP aperture is 64M @ 0xe0000000
> [drm] AGP 0.99 on VIA MVP3 @ 0xe0000000 64MB
> [drm] Initialized mga 2.0.1 20000928 on minor 63
> es1371: version v0.27 time 10:11:49 Feb  2 2001
> es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
> PCI: Assigned IRQ 9 for device 00:0b.0
> es1371: found es1371 rev 8 at io 0xe400 irq 9
> es1371: features: joystick 0x0
> ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A)
> Linux PCMCIA Card Services 3.1.22
>   options:  [pci] [cardbus]
> PCI: Found IRQ 9 for device 00:08.0
> IRQ routing conflict in pirq table for device 00:08.0
> PCI: Found IRQ 9 for device 00:08.1
> PCI: The same IRQ used for device 00:09.0
> NET4: Linux TCP/IP 1.0 for NET4.0
> IP Protocols: ICMP, UDP, TCP
> IP: routing cache hash table of 512 buckets, 4Kbytes
> TCP: Hash tables configured (established 8192 bind 8192)
> NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
> Yenta IRQ list 0000, PCI irq11
> Socket status: 10000006
> Yenta IRQ list 0000, PCI irq9
> Socket status: 10000006
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing unused kernel memory: 64k freed
> Adding Swap: 265064k swap-space (priority -1)
> usb.c: registered new driver usbdevfs
> usb.c: registered new driver hub
> usb-uhci.c: $Revision: 1.251 $ time 10:23:17 Feb  2 2001
> usb-uhci.c: High bandwidth mode enabled
> usb-uhci.c: USB UHCI at I/O 0xd400, IRQ 12
> usb-uhci.c: Detected 2 ports
> usb.c: new USB bus registered, assigned bus number 1
> hub.c: USB hub found
> hub.c: 2 ports detected
> eth0: first available media type: MII
> Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
> 
>         Hope this helps,
> 
> -Yenya
> 
> --
> \ Jan "Yenya" Kasprzak <kas at fi.muni.cz>       http://www.fi.muni.cz/~kas/
> \\ PGP: finger kas at aisa.fi.muni.cz   0D99A7FB206605D7 8B35FCDE05B18A5E //
> \\\             Czech Linux Homepage:  http://www.linux.cz/              ///
> > Is there anything else I can contribute? -- The latitude and longtitude of
> the bios writers current position, and a ballistic missile.       (Alan Cox)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
