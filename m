Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277514AbRKLNY0>; Mon, 12 Nov 2001 08:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKLNYR>; Mon, 12 Nov 2001 08:24:17 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:38794 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S277514AbRKLNYB>;
	Mon, 12 Nov 2001 08:24:01 -0500
Date: Mon, 12 Nov 2001 14:22:45 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
Subject: IDE + OOPS 2.4.14
Message-ID: <Pine.LNX.4.33.0111121418210.8473-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

linux single hdb=16383,16,63 hdb=noprobe

causes attached oops. I suspect that the 16383 number overflows something,
as attached oops makes no sense to me.

If I swap the hdb=16xxx and hdb=noprobe arguments, no OOPS occurs.

IDE info :

PIIX4: IDE controller on PCI bus 00 dev f9
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLlct20 20, ATA DISK drive
hdb: Maxtor 96147H6, ATA DISK drive
hdc: CR-48X5TE, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-115 0128, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 39876480 sectors (20417 MB) w/418KiB Cache, CHS=2637/240/63, UDMA(66)
hdb: 66055248 sectors (33820 MB) w/2048KiB Cache, CHS=65531/16/63,
UDMA(66)
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)

the /dev/hdb info is totally wrong, it is a 61 GB disk, not 32 GB.
Correct info :

[root@wrkst igmar]# ./setmax /dev/hdb
Using device /dev/hdb
native max address: 120064895
that is 61473226752 bytes, 61.5 GB
lba capacity: 66055248 sectors (33820286976 bytes)

Anyone got a solution for the above problem ??



	Regards,


		Igmar


-----------------------------------------------------------------------------
ksymoops 2.4.0 on i686 2.4.14.  Options used
     -v /boot/vmlinux-2.4.14 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Unable to handle kernel NULL pointer dereference at vitual address 00000063
c01c0e90
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c0e90>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: c03703b4   ebx: 00000000   ecx: 00000006   edx: 00000004
esi: 00000005   edi: c03703b4   ebp: 0008e000   esp: c122df54
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c122d000)
Stack: c03703b4 00000286 c02fa902 c01c0ed7 c03703b4 c01bf0c3 00000004 c03703b4
       00000007 c03703b4 c03703b4 00000001 c02fa902 c01c4e9d c03703b4 c02fa920
       00000001 00014690 55555556 0001e9d8 c0316a1c c0316a6f 00014690 55555556
Call Trace: [<c01c0ed7>] [<c01bf0c3>] [<c01c4e9d>] [<c0105037>] [<c0105478>]
Code: f6 43 63 08 75 06 f6 43 6a 02 74 0e be 07 00 00 00 57 e8 15

>>EIP; c01c0e90 <ac97_init_mixer+b8/e4>   <=====
Trace; c01c0ed7 <sigmatel_9708_init+1b/ac>
Trace; c01bf0c3 <i810_ioctl+66f/116c>
Trace; c01c4e9d <usb_register_bus+e5/ec>
Trace; c0105037 <init+7/110>
Trace; c0105478 <kernel_thread+28/38>
Code;  c01c0e90 <ac97_init_mixer+b8/e4>
00000000 <_EIP>:
Code;  c01c0e90 <ac97_init_mixer+b8/e4>   <=====
   0:   f6 43 63 08               testb  $0x8,0x63(%ebx)   <=====
Code;  c01c0e94 <ac97_init_mixer+bc/e4>
   4:   75 06                     jne    c <_EIP+0xc> c01c0e9c <ac97_init_mixer+c4/e4>
Code;  c01c0e96 <ac97_init_mixer+be/e4>
   6:   f6 43 6a 02               testb  $0x2,0x6a(%ebx)
Code;  c01c0e9a <ac97_init_mixer+c2/e4>
   a:   74 0e                     je     1a <_EIP+0x1a> c01c0eaa <ac97_init_mixer+d2/e4>
Code;  c01c0e9c <ac97_init_mixer+c4/e4>
   c:   be 07 00 00 00            mov    $0x7,%esi
Code;  c01c0ea1 <ac97_init_mixer+c9/e4>
  11:   57                        push   %edi
Code;  c01c0ea2 <ac97_init_mixer+ca/e4>
  12:   e8 15 00 00 00            call   2c <_EIP+0x2c> c01c0ebc <sigmatel_9708_init+0/ac>

 <0>Kernel panic: Attempting to kill init!

1 warning issued.  Results may not be reliable.

-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

