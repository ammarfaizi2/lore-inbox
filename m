Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVHLOtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVHLOtB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 10:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbVHLOs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 10:48:59 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:62158 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S1751056AbVHLOsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 10:48:32 -0400
Date: Fri, 12 Aug 2005 10:48:31 -0400
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: hirofumi@mail.parknet.co.jp,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: The Linux FAT issue on SD Cards.. maintainer support please
Message-ID: <20050812144831.GJ6714@csclub.uwaterloo.ca>
References: <C349E772C72290419567CFD84C26E0170A0186@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C349E772C72290419567CFD84C26E0170A0186@mail.esn.co.in>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 07:52:31PM +0530, Mukund JB. wrote:
> I dumped the 0th sector of SD when formatted on 
> 	1) CAM &
> 	2) Windows
> The partition table exists on both.
> But, the Master Boot Code is NOT present on the CAM formatted SD but is
> available on windows formatted SD card.
> 
> Can you comment on the Master Boot Code? What is it required on Linux
> HOW does windows managed without it? I mean how is Windows able to mount
> the SD?
> 
> My driver does NOT support partitions? I mean I have implemented it as
> alloc_disk(1) & relative first_minor chage obviously.

If you don't at least read the partition table to find where the first
partition starts, then you won't know where to start looking for a FAT
filesystem.

> Is it why I am NOT able to mount the CAM formatted device?
> Is this a problem?

Well in the past I have seen cards that had a partition table, with one
partition in it (usually either primary partition 1 or 4) and had that
partition formated with FAT12, 16 or 32 (depending on size).  Some had
no partitions, and just had the whole device formated with FAT like a
floppy.  Windows seems to deal with both, as does linux (as long as you
ask it to mount the right device such as /dev/sda1 sda4 or sda depending
on which partition (if any) the card uses.

If you ignore partitions entirely, many cards will not work for you
since they do have partitions on them.  Some will work if they use the
entire device without partitions like a floppy would.

The SD card I have here formated by my Canon SD200 has this as the
MBR/partition table (first sector):
0000000: fa33 c08e d0bc 007c 8bf4 5007 501f fbfc  .3.....|..P.P...
0000010: bf00 06b9 0001 f2a5 ea1d 0600 00be be07  ................
0000020: b304 803c 8074 0e80 3c00 751c 83c6 10fe  ...<.t..<.u.....
0000030: cb75 efcd 188b 148b 4c02 8bee 83c6 10fe  .u......L.......
0000040: cb74 1a80 3c00 74f4 be8b 06ac 3c00 740b  .t..<.t.....<.t.
0000050: 56bb 0700 b40e cd10 5eeb f0eb febf 0500  V.......^.......
0000060: bb00 7cb8 0102 57cd 135f 730c 33c0 cd13  ..|...W.._s.3...
0000070: 4f75 edbe a306 ebd3 bec2 06bf fe7d 813d  Ou...........}.=
0000080: 55aa 75c7 8bf5 ea00 7c00 0049 6e76 616c  U.u.....|..Inval
0000090: 6964 2070 6172 7469 7469 6f6e 2074 6162  id partition tab
00000a0: 6c65 0045 7272 6f72 206c 6f61 6469 6e67  le.Error loading
00000b0: 206f 7065 7261 7469 6e67 2073 7973 7465   operating syste
00000c0: 6d00 4d69 7373 696e 6720 6f70 6572 6174  m.Missing operat
00000d0: 696e 6720 7379 7374 656d 0000 8158 3315  ing system...X3.
00000e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000f0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000100: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000110: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000120: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000130: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000140: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000150: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000160: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000170: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000180: 0000 0000 0000 0000 0000 0000 0000 0000  ................
0000190: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00001a0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00001b0: 0000 0000 0000 0000 0000 0000 0000 0001  ................
00001c0: 1a00 0101 60c1 3900 0000 4770 0000 0000  ....`.9...Gp....
00001d0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00001e0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00001f0: 0000 0000 0000 0000 0000 0000 0000 55aa  ..............U.

The first sector of the partition is this:
0000000: eb00 9050 7772 5368 6f74 2000 0220 0100  ...PwrShot .. ..
0000010: 0200 0247 70f8 0300 2000 0200 3900 0000  ...Gp... ...9...
0000020: 0000 0000 8000 294e cf68 6f43 414e 4f4e  ......)N.hoCANON
0000030: 5f44 4320 2020 4641 5431 3220 2020 33ff  _DC   FAT12   3.
0000040: 8edf be00 7c8d 9ce4 018e 4702 fcb9 0002  ....|.....G.....
0000050: f3a4 c707 5800 ff2f 8cc8 fa8e d0bc 0006  ....X../........
0000060: fb8b ec83 ec16 c536 7800 8976 f68c 5ef8  .......6x..v..^.
0000070: 8d7e eab9 0b00 57f3 a45f 8ed9 be78 0089  .~....W.._...x..
0000080: 3c8c 4402 0e1f c645 0412 c645 090f b200  <.D....E...E....
0000090: 91cd 13a0 1800 f626 1a00 8946 fa83 3eea  .......&...F..>.
00000a0: 0100 7520 a010 0098 f626 1600 0306 0e00  ..u .....&......
00000b0: a3ea 0191 b820 00f7 2611 00f7 360b 0003  ..... ..&...6...
00000c0: c1a3 ec01 33d2 a1ea 01b9 0100 c41e e001  ....3...........
00000d0: e890 00b0 20f6 26e8 01c4 3ee0 0103 f8be  .... .&...>.....
00000e0: f101 b90b 00f3 a674 24be a501 e849 0032  .......t$....I.2
00000f0: e4cd 16e8 0200 cd19 33c0 8ed8 bb78 00c4  ........3....x..
0000100: 7ef6 893f 8c47 02c3 becc 01eb dfc4 1ee0  ~..?.G..........
0000110: 018b 16ee 01a1 ec01 8a0e f001 b500 e842  ...............B
0000120: 00e8 d4ff bb84 002e 8a16 2400 c747 02ff  ..........$..G..
0000130: ff89 172e ff2e e001 ac0a c074 25b4 0ebb  ...........t%...
0000140: 0700 cd10 ebf2 0306 1c00 1316 1e00 f776  ...............v
0000150: fa89 46fe 8bc2 f636 1800 8846 fcfe c488  ..F....6...F....
0000160: 66fd c3e3 fd52 5051 e8db ffb8 0100 50e8  f....RPQ......P.
0000170: 1900 5872 9359 5f5a 2bc8 03f8 83d2 0052  ..Xr.Y_Z+......R
0000180: 57f7 260b 0003 d858 5aeb d88b 56fe b106  W.&....XZ...V...
0000190: d2e6 0a76 fd8b ca86 e98a 1624 008a 76fc  ...v.......$..v.
00001a0: b402 cd13 c34e 6f20 5379 7374 656d 206f  .....No System o
00001b0: 6e20 4469 736b 0d0a 5072 6573 7320 4573  n Disk..Press Es
00001c0: 6320 746f 2052 6562 6f6f 7400 4469 736b  c to Reboot.Disk
00001d0: 2042 6f6f 7420 4661 696c 7572 6500 0000   Boot Failure...
00001e0: 0000 7000 0000 000c 0000 0000 0000 0000  ..p.............
00001f0: 0049 424d 4249 4f20 2043 4f4d 0080 55aa  .IBMBIO  COM..U.

And the minfo of the partition:
device information:
===================
filename="/dev/sde1"
sectors per track: 32
heads: 2
cylinders: 450

mformat command line: mformat -t 450 -h 2 -s 32 -H 57 c:

bootsector information
======================
banner:"PwrShot "
sector size: 512 bytes
cluster size: 32 sectors
reserved (boot) sectors: 1
fats: 2
max available root directory slots: 512
small size: 28743 sectors
media descriptor byte: 0xf8
sectors per fat: 3
sectors per track: 32
heads: 2
hidden sectors: 57
big size: 0 sectors
physical drive id: 0x80
reserved=0x0
dos4=0x29
serial number: 6F68CF4E
disk label="CANON_DC   "
disk type="FAT12   "

Len Sorensen
