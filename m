Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132609AbRC1XUh>; Wed, 28 Mar 2001 18:20:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132614AbRC1XUU>; Wed, 28 Mar 2001 18:20:20 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:38134 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S132609AbRC1XUL>; Wed, 28 Mar 2001 18:20:11 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org,
   autofs@linux.kernel.org, hpa@zytor.com, gam3@acm.org
Subject: Re: PROBLEM: 2.2.18 oops leaves umount hung in disk sleep
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com> <shs1yrpabky.fsf@charged.uio.no> <54hf0l8ug1.fsf@intech19.enhanced.com> <shspuf98nhy.fsf@charged.uio.no> <541yrpgsze.fsf@intech19.enhanced.com> <shs7l1gae5a.fsf@charged.uio.no> <54puf35jls.fsf@intech19.enhanced.com>
From: Camm Maguire <camm@enhanced.com>
Date: 28 Mar 2001 18:19:11 -0500
In-Reply-To: Camm Maguire's message of "27 Mar 2001 10:15:11 -0500"
Message-ID: <54lmpp8osw.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, some new information.  Apparently, the ethernet traffic is getting
corrupted by heavy disk access to the second disk on my primary ALI
5229 controller.  I suspect this is related to the oops, as the kernel
log messages reporting the errors tend to come roughly at the same
time as the oopses. 

Here is the test: I run netpipe-tcp to the host while running bonnie
on the second disk.  I then receive quite a few messages reading:
Mar 28 17:55:33 intech9 kernel: eth0: bogus packet: status=0x80 nxpg=0x6e size=1518
Mar 28 17:56:25 intech9 kernel: eth0: bogus packet: status=0x80 nxpg=0x69 size=1518

The size is always 1518.  There are also other less frequent messages
which I can collate if needed.  Running thee same test with bonnie on
the first disk does not produce the error.  Turning dma off on both
disks does not help.

Here is my disk information:
=============================================================================
intech9:/proc/ide/ide0/hda# for i in * ; do echo "---"$i"---" ; cat $i ; done
for i in * ; do echo "---"$i"---" ; cat $i ; done
---cache---
512
---capacity---
12672450
---driver---
ide-disk version 1.08
---geometry---
physical     13410/15/63
logical      788/255/63
---identify---
045a 3462 0000 000f 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 2020 2020
3035 3338 3232 3537 0000 0400 0004 4544
2d30 332d 3038 4655 4a49 5453 5520 4d50
4533 3036 3441 5420 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 0b00 0000 0200 0000 0007 3462 000f
003f 5dc2 00c1 0000 5dc2 00c1 0000 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
001e 0000 346b 4008 4000 0061 0000 4000
041f 0006 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
---media---
disk
---model---
FUJITSU MPE3064AT
---settings---
name			value		min		max		mode
----			-----		---		---		----
bios_cyl                788             0               65535           rw
bios_head               255             0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
file_readahead          124             0               2097151         rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      64              1               127             rw
multcount               0               0               8               rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
---smart_thresholds---
0010 2001 0000 0000 0000 0000 0000 1402
0000 0000 0000 0000 0000 1903 0000 0000
0000 0000 0000 1004 0000 0000 0000 0000
0000 1805 0000 0000 0000 0000 0000 1407
0000 0000 0000 0000 0000 1308 0000 0000
0000 0000 0000 1409 0000 0000 0000 0000
0000 140a 0000 0000 0000 0000 0000 140c
0000 0000 0000 0000 0000 18c4 0000 0000
0000 0000 0000 14c5 0000 0000 0000 0000
0000 14c6 0000 0000 0000 0000 0000 00c7
0000 0000 0000 0000 0000 14c8 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 a900
---smart_values---
0010 0b01 6400 5164 02e2 0000 0000 0502
6400 0064 0000 0000 0000 0703 6000 0160
0000 0000 0000 1204 6400 2964 0000 0000
0000 3305 6400 0064 0000 0000 0000 0b07
6400 e664 0006 0000 0000 0508 6400 0064
0000 0000 0000 1209 3800 7d38 71c5 0001
0000 130a 6400 0064 0000 0000 0000 320c
6400 2964 0000 0000 0000 33c4 6400 0064
0000 0000 0000 10c5 6400 0064 0000 0000
0000 10c6 6400 0064 0000 0000 0000 0ac7
c800 00c8 0000 0000 0000 0bc8 6400 0d61
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 00b4 1b00
0002 0001 0802 0000 0000 0000 0000 0000
0000 3e50 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 671d 2958 087e 7b50 9700
intech9:/proc/ide/ide0/hda# cd ../hdb
cd ../hdb
intech9:/proc/ide/ide0/hdb# for i in * ; do echo "---"$i"---" ; cat $i ; done
for i in * ; do echo "---"$i"---" ; cat $i ; done
---cache---
128
---capacity---
4127760
---driver---
ide-disk version 1.08
---geometry---
physical     4095/16/63
logical      4095/16/63
---identify---
045a 0fff 0000 0010 ffff 03b7 003f 0000
0000 0000 2020 2020 2020 2020 2020 2020
4a42 3831 3830 3334 0003 0100 0016 3038
2e30 382e 3031 5354 3332 3134 3041 2020
2020 2020 2020 2020 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8020
0000 0b00 0000 0200 0000 0003 0fff 0010
003f fc10 003e 0100 fc10 003e 0007 0407
0003 0078 0078 00b4 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
---media---
disk
---model---
ST32140A
---settings---
name			value		min		max		mode
----			-----		---		---		----
bios_cyl                4095            0               65535           rw
bios_head               16              0               255             rw
bios_sect               63              0               63              rw
breada_readahead        4               0               127             rw
bswap                   0               0               1               r
file_readahead          124             0               2097151         rw
io_32bit                0               0               3               rw
keepsettings            0               0               1               rw
max_kb_per_request      64              1               127             rw
multcount               0               0               16              rw
nice1                   1               0               1               rw
nowerr                  0               0               1               rw
pio_mode                write-only      0               255             w
slow                    0               0               1               rw
unmaskirq               0               0               1               rw
using_dma               0               0               1               rw
---smart_thresholds---
0005 5505 0000 0000 0000 0000 0000 5f07
0000 0000 0000 0000 0000 620a 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 cf00
---smart_values---
0005 1305 6300 0263 0000 0000 0000 0b07
6400 0064 0000 0000 0000 130a 6400 0064
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0003 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 e61e
0403 002c 0000 104a 07cf 1c9b 01f2 0afd
0eed 19c5 140c 0000 0000 0000 0000 0000
0000 0000 0000 0000 0502 3307 0000 0700
intech9:/proc/ide/ide0/hdb# hdparm -d 1 /dev/hda
hdparm -d 1 /dev/hda

/dev/hda:
 setting using_dma to 1 (on)
 using_dma    =  1 (on)
intech9:/proc/ide/ide0/hdb# hdparm /dev/hda
hdparm /dev/hda

/dev/hda:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 788/255/63, sectors = 12672450, start = 0
intech9:/proc/ide/ide0/hdb# hdparm /dev/hdb
hdparm /dev/hdb

/dev/hdb:
 multcount    =  0 (off)
 I/O support  =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 4095/16/63, sectors = 4127760, start = 0
=============================================================================
and the controller:
=============================================================================
Mar 28 09:56:45 intech9 kernel: ALI15X3: IDE controller on PCI bus 00 dev 78
Mar 28 09:56:45 intech9 kernel: ALI15X3: not 100%% native mode: will probe irqs later
Mar 28 09:56:45 intech9 kernel:     ide0: BM-DMA at 0xb400-0xb407, BIOS settings: hda:DMA, hdb:DMA
Mar 28 09:56:45 intech9 kernel: 
Mar 28 09:56:45 intech9 kernel: ************************************
Mar 28 09:56:45 intech9 kernel: *    ALi IDE driver (1.0 beta3)    *
Mar 28 09:56:45 intech9 kernel: *       Chip Revision is C1        *
Mar 28 09:56:45 intech9 kernel: *  Maximum capability is - UDMA 33 *
Mar 28 09:56:45 intech9 kernel: ************************************
Mar 28 09:56:45 intech9 kernel: 
Mar 28 09:56:45 intech9 kernel:     ide1: BM-DMA at 0xb408-0xb40f, BIOS settings: hdc:pio, hdd:pio
Mar 28 09:56:45 intech9 kernel: hda: FUJITSU MPE3064AT, ATA DISK drive
Mar 28 09:56:45 intech9 kernel: hdb: ST32140A, ATA DISK drive
Mar 28 09:56:45 intech9 kernel: hdc: CONNER CTT8000-A, ATAPI TAPE drive
Mar 28 09:56:45 intech9 kernel: hdd: HP COLORADO 14GB, ATAPI TAPE drive
Mar 28 09:56:45 intech9 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Mar 28 09:56:45 intech9 kernel: ide1 at 0x170-0x177,0x376 on irq 15
Mar 28 09:56:45 intech9 kernel:  ALI15X3: Ultra DMA enabled
Mar 28 09:56:45 intech9 kernel: hda: FUJITSU MPE3064AT, 6187MB w/512kB Cache, CHS=788/255/63, (U)DMA
Mar 28 09:56:45 intech9 kernel:  ALI15X3: MultiWord DMA enabled
Mar 28 09:56:45 intech9 kernel: hdb: ST32140A, 2015MB w/128kB Cache, CHS=4095/16/63, DMA
Mar 28 09:56:45 intech9 kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
Mar 28 09:56:45 intech9 kernel:  hdb: hdb1 hdb2

intech9:/proc/ide/ide0/hdb# lspci
lspci
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04)
00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
00:09.0 Ethernet controller: Winbond Electronics Corp W89C940
00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP (rev 65)

=============================================================================


Any insights most appreciated!


Camm Maguire <camm@enhanced.com> writes:

> Hello again!  We're in luck!  The oops happened again, and this time,
> the full oops dump appeared on the screen, which I have copied below:
> 
> =============================================================================
> Unable to handle kernel paging request at virtual address 6e617274
> current->tss.c3 = 03d06000, %cr3 = 03d06000
> *pde = 00000000
> Oops = 0
> CPU = 0
> EIP = 0010:[<c012facf>]
> EFLAGS = 00010a87
> eax = 00000000  ebx = 6e617274  ecx = 6e617274  edx = 00000006
> esi = 00000006  edi = c3bda800  ebp = 00000006  esp = c2381f5c
> ds = 0018  es = 0018  ss = 0018
> Process umount (pid:6942, process nr:58,stackpage = c2381000)
> Stack: fffffffe c01281a2 c3bda800 00000006 c25db80c 00000006 fffffffa c01282e8
>        00000006 00000000 00000000 00000000 08050006 c0b176e0 08054208 00000000
>        c01283e3 00000006 00000000 c2380000 08054209 0804fa20 c01283fc 08054208
> Call Trace: [<c01281a2>][<c01282e8>][<c01283e3>][<c01283fc>][<c01094fc>]
> code: 8b 1b 39 79 34 75 ef 8b 41 04 8b 11 89 42 04 89 10 a1 e4 4d
> =============================================================================
> and through ksymoops:
> =============================================================================
> intech9# ksymoops</home/camm/oops
> ksymoops</home/camm/oops
> ksymoops 2.3.4 on i586 2.2.18-i586tsc.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.2.18-i586tsc/ (default)
>      -m /boot/System.map-2.2.18-i586tsc (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
> Unable to handle kernel paging request at virtual address 6e617274
> current->tss.c3 = 03d06000, %cr3 = 03d06000
> *pde = 00000000
> Stack: fffffffe c01281a2 c3bda800 00000006 c25db80c 00000006 fffffffa c01282e8
>        00000006 00000000 00000000 00000000 08050006 c0b176e0 08054208 00000000
>        c01283e3 00000006 00000000 c2380000 08054209 0804fa20 c01283fc 08054208
> Call Trace: [<c01281a2>][<c01282e8>][<c01283e3>][<c01283fc>][<c01094fc>]
> code: 8b 1b 39 79 34 75 ef 8b 41 04 8b 11 89 42 04 89 10 a1 e4 4d
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Trace; c01281a2 <do_umount+5a/144>
> Trace; c01282e8 <umount_dev+5c/ac>
> Trace; c01283e3 <sys_umount+ab/b8>
> Trace; c01283fc <sys_oldumount+c/10>
> Trace; c01094fc <system_call+34/38>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 1b                     mov    (%ebx),%ebx
> Code;  00000002 Before first symbol
>    2:   39 79 34                  cmp    %edi,0x34(%ecx)
> Code;  00000005 Before first symbol
>    5:   75 ef                     jne    fffffff6 <_EIP+0xfffffff6> fffffff6 <END_OF_CODE+3b764797/????>
> Code;  00000007 Before first symbol
>    7:   8b 41 04                  mov    0x4(%ecx),%eax
> Code;  0000000a Before first symbol
>    a:   8b 11                     mov    (%ecx),%edx
> Code;  0000000c Before first symbol
>    c:   89 42 04                  mov    %eax,0x4(%edx)
> Code;  0000000f Before first symbol
>    f:   89 10                     mov    %edx,(%eax)
> Code;  00000011 Before first symbol
>   11:   a1 e4 4d 00 00            mov    0x4de4,%eax
> 
> 
> 2 warnings issued.  Results may not be reliable.
> =============================================================================
> 
> As before, the oops was truncated in the log.
> 
> I received two eth0 (ne2k-pci,using 8390) errors before this oops:
> eth0: next frame inconsistency, 0xf2
> eth0: next frame inconsistency, 0xb8
> 
> And then one eth0 error after the oops before the machine died:
> eth0: bogus packet: status=0x80 nxpg=0x7b size=1518
> 
> I will be trying to recompile with gcc272 to see if anything changes.
> In the meantime, I'd greatly appreciate any insights!
> 
> Take care,
> 
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> > >>>>> " " == Camm Maguire <camm@enhanced.com> writes:
> > 
> >      > Greetings!  Here are the contiguous lines from kern.log: Mar 21
> >      > 01:14:47 intech9 kernel: eth0: bogus packet: status=0x80
> >      > nxpg=0x57 size=1270 Mar 21 01:14:49 intech9 kernel: Unable to
> >      > handle kernel NULL pointer dereference at virtual address
> >      > 00000000 Mar 21 01:14:49 intech9 kernel: current->tss.cr3 =
> >      > 02872000, %%cr3 = 02872000 Mar 21 01:14:49 intech9 kernel: *pde
> >      > = 00000000 Mar 21 01:14:49 intech9 kernel: Oops: 0000 Mar 21
> >      > 01:14:49 intech9 kernel: CPU: 0 Mar 22 12:30:08 intech9 kernel:
> >      > klogd 1.3-3#33.1, log source = /proc/kmsg started.
> > 
> >      > Why would this have not been included, would you happen to
> >      > know?  In any case, I understand that its pretty much
> > 
> > I've no idea why it wasn't logged. Did you possibly reboot without
> > syncing the disk?
> > 
> >      > impossible to debug now, right?  dmesg wrapped around by the
> >      > time I got to it (I seem to be having a lot of ethernet bogus
> >      > packet messages, as shown above.  I've chalked this up to the
> >      > heavy traffic during the amanda backup, but maybe something is
> >      > wrong here too/instead?)
> > 
> > Have you tried to use an older version of gcc? AFAIK gcc-2.95.2 has a
> > lot of bugs that are known to cause problems with the kernel. If you
> > are having additional problems such as the bogus ethernet packets,
> > then it might be worth your while to experiment a bit to see whether
> > this might be some corruption problem.
> > 
> > Cheers,
> >    Trond
> > 
> > 
> 
> -- 
> Camm Maguire			     			camm@enhanced.com
> ==========================================================================
> "The earth is but one country, and mankind its citizens."  --  Baha'u'llah
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
