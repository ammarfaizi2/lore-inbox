Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRACTtE>; Wed, 3 Jan 2001 14:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbRACTsy>; Wed, 3 Jan 2001 14:48:54 -0500
Received: from ns2.avnet.it ([194.91.85.195]:64007 "EHLO interno.emmenet.it")
	by vger.kernel.org with ESMTP id <S129415AbRACTsr>;
	Wed, 3 Jan 2001 14:48:47 -0500
From: Diego Liziero <pmcq@interno.emmenet.it>
Message-Id: <200101031919.f03JJQU13197@interno.emmenet.it>
Subject: gcc2.96 + prerelease BUG at inode.c:372
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Jan 2001 20:19:26 +0100 (CET)
Cc: pmcq@emmenet.it
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc2.96 + prerelease BUG at inode.c:372

I've compiled by mistake the kernel with the wrong compiler: gcc 2.96
(RedHat 7.0 without the upgrade to gcc 2.96-69)

->1: The sound module for my mad16 based card plays the bytes swapped
     (the same module recompiled with egcs-2.91.66 works fine).

->2: after two day under heavy load I've got the following BUG:
     (I don't know if it's related to the compiler, that's why I'm reporting
     this.)

kernel BUG at inode.c:372!
invalid operand: 0000
CPU:    0
EIP:    0010:[clear_inode+53/272]
EFLAGS: 00010286
eax: 0000001b   ebx: c11e2be0   ecx: ffffffff   edx: 00000000
esi: 00000f1a   edi: c11e2be0   ebp: 0002761b   esp: c2ce9ea4
ds: 0018   es: 0018   ss: 0018
Process wineserver (pid: 17050, stackpage=c2ce9000)
Stack: c01efd23 c01efda3 00000174 c1167800 00000f1a c11e2be0 0002761b c1167800
       c0151a20 c11e2be0 00000000 0000000a c3b02400 c3653ba0 c11e2c84 c11e2be0
       c11e2be0 c021e200 c11e2be0 c11e2be0 c021e200 c11e2be0 c1d7bbe0 c0144765
Call Trace: [tvecs+21919/42720] [tvecs+22047/42720] [ext2_free_inode+208/432] [iput+165/336] [dput+237/320] [ext2_release_file+20/32] [fput+113/208]
       [unmap_fixup+86/304] [do_munmap+550/672] [filp_close+85/96] [sys_munmap+41/64] [system_call+51/56] [startup_32+43/313]
Code: 0f 0b 83 c4 0c 8b 83 ec 00 00 00 a9 10 00 00 00 75 1f 68 76

I've lost the original System.map so I've to trust in klogd symbols.

Code;  c0143e35 [clear_inode+53/272]      <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0143e37
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0143e3a
   5:   8b 83 ec 00 00 00         mov    0xec(%ebx),%eax
Code;  c0143e40
   b:   a9 10 00 00 00            test   $0x10,%eax
Code;  c0143e45
  10:   75 1f                     jne    31 <_EIP+0x31> c0143e66 No symbols available
Code;  c0143e47
  12:   68 76 00 00 00            push   $0x76


System info:
Linux nuovo 2.4.0-prerelease #166 lun gen 1 19:19:56 MET 2001 i686 unknown
CPU: Intel Pentium II (Klamath) stepping 04
ide info:
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 90432D3, ATA DISK drive
hdb: FUJITSU MPE3136AT, ATA DISK drive
hdc: Conner Peripherals 340MB - CP30344, ATA DISK drive
hdd: LTN301, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15

Please, CC to pmcq@emmenet.it as I'm not subscribed to the list.

			Diego Liziero (pmcq@emmenet.it)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
