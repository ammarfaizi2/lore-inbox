Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132246AbRCYXLv>; Sun, 25 Mar 2001 18:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132247AbRCYXLl>; Sun, 25 Mar 2001 18:11:41 -0500
Received: from 24.68.117.103.on.wave.home.com ([24.68.117.103]:128 "EHLO
	cs865114-a.amp.dhs.org") by vger.kernel.org with ESMTP
	id <S132246AbRCYXLg>; Sun, 25 Mar 2001 18:11:36 -0500
Date: Sun, 25 Mar 2001 18:10:46 -0500 (EST)
From: Arthur Pedyczak <arthur-p@home.com>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: BUG at buffer.c:1276!  in 2.4.3-pre7
Message-ID: <Pine.LNX.4.30.0103251800520.1130-100000@cs865114-a.amp.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The subject says it all. The bug got trigerred under _Heavy_ load
(bootstraping gcc ang building Xfree at the same time).


My hardware:
Motherboard: Asus P2B
CPU        : P-III 600 (no overclocking)
RAM        : 384 MB
IDE        : PIIX4: IDE controller on PCI bus 00 dev 21
	     PIIX4: chipset revision 1
             hda: WDC WD200BB-00AUA1, ATA DISK drive
             hdb: MATSHITA CR-589, ATAPI CD/DVD-ROM drive  (ide-scsi)
             hdc: WDC AC313000R, ATA DISK drive
             hdd: MITSBICDRW4420a, ATAPI CD/DVD-ROM drive  (ide-scsi)
eth0       : eepro100
eth1       : 3c590
sound      : es1370


Ksymoops output:
====================================================================
ksymoops 2.3.4 on i686 2.4.3-pre7.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.3-pre7/ (default)
     -m /usr/src/linux/System.map (specified)

Mar 25 17:12:33 cs865114-a kernel: invalid operand: 0000
Mar 25 17:12:33 cs865114-a kernel: CPU:    0
Mar 25 17:12:33 cs865114-a kernel: EIP:    0010:[set_bh_page+46/64]
Mar 25 17:12:33 cs865114-a kernel: EFLAGS: 00210286
Mar 25 17:12:33 cs865114-a kernel: eax: 0000001d   ebx: 00001000   ecx:
00000001   edx:
 00000000
Mar 25 17:12:33 cs865114-a kernel: esi: c133cdec   edi: d5390c20   ebp:
00000000   esp:
 c7947e50
Mar 25 17:12:33 cs865114-a kernel: ds: 0018   es: 0018   ss: 0018
Mar 25 17:12:33 cs865114-a kernel: Process fini (pid: 26089,
stackpage=c7947000)
Mar 25 17:12:33 cs865114-a kernel: Stack: c01fbdcf c01fbffa 000004fc
c133cdec d5390c20
00001000 c0133fc8 d5390c20
Mar 25 17:12:33 cs865114-a kernel:        c133cdec 00001000 c17a2260
c099e7e0 ce12c5c0
cde0f000 c4e993e0 c133cdec
Mar 25 17:12:33 cs865114-a kernel:        00002c28 c133cdec c0134219
c133cdec 00000000
00000001 c4e993e0 00000000
Mar 25 17:12:33 cs865114-a kernel: Call Trace: [create_buffers+104/432]
[create_empty_b
uffers+25/112] [block_read_full_page+98/608] [__alloc_pages+228/720]
[do_generic_file_r
ead+817/1296] [ext2_get_block+0/1264] [generic_file_read+98/128]
Mar 25 17:12:33 cs865114-a kernel: Code: 0f 0b 83 c4 0c 8b 4e 3c 01 cb 89
5f 34 5b 5e 5
f c3 90 55 57
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   8b 4e 3c                  mov    0x3c(%esi),%ecx
Code;  00000008 Before first symbol
   8:   01 cb                     add    %ecx,%ebx
Code;  0000000a Before first symbol
   a:   89 5f 34                  mov    %ebx,0x34(%edi)
Code;  0000000d Before first symbol
   d:   5b                        pop    %ebx
Code;  0000000e Before first symbol
   e:   5e                        pop    %esi
Code;  0000000f Before first symbol
   f:   5f                        pop    %edi
Code;  00000010 Before first symbol
  10:   c3                        ret
Code;  00000011 Before first symbol
  11:   90                        nop
Code;  00000012 Before first symbol
  12:   55                        push   %ebp
Code;  00000013 Before first symbol
  13:   57                        push   %edi
====================================================================

