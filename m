Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263943AbTCUTza>; Fri, 21 Mar 2003 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263864AbTCUTyU>; Fri, 21 Mar 2003 14:54:20 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:28594 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S263842AbTCUTcm>;
	Fri, 21 Mar 2003 14:32:42 -0500
Date: Fri, 21 Mar 2003 20:43:43 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: ext3+LVM - allocating block in system zone
Message-ID: <20030321204342.A20599@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

	I've got lots of the following messaegs today:

EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455454
EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455455
EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455456
EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455457
EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455461

	The system is newly-created LVM volume group with one LV (~820 GB)
Extent size is 32MB, LV has its extents interleaved across six PVs.

The ext3 filesystem is also newly created by the following command:
mke2fs -j /dev/data_vg/export_lv -m 0 -R stride=8192  -J size=256

	The problem appeared when I started to copy data to this
LV (about half an hour after the tar xvf - was started).

The problem also occurs on ext2. The kernel is 2.4.21-pre5 + the recent
ptrace() security patch. CONFIG_HIGHMEM4G is set, as well as CONFIG_HIGHIO.
The box has 1.2G RAM, disks are connected to on-board VIA 686a and PDC 20265
and one SIL/CMD 680 PCI IDE controllers. NIC is 3c985B (Tigon II), chipset
is VIA KT133. More information available on request.

	Is it a problem in kernel? Thanks,

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
