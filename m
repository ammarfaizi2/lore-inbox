Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262966AbTCWIOl>; Sun, 23 Mar 2003 03:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbTCWIOl>; Sun, 23 Mar 2003 03:14:41 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:60395 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S262966AbTCWIOj>;
	Sun, 23 Mar 2003 03:14:39 -0500
Date: Sun, 23 Mar 2003 09:25:43 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3+LVM - allocating block in system zone
Message-ID: <20030323092542.G20599@fi.muni.cz>
References: <20030321204342.A20599@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030321204342.A20599@fi.muni.cz>; from kas@informatics.muni.cz on Fri, Mar 21, 2003 at 08:43:43PM +0100
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak wrote:
: 	Hello,
: 
: 	I've got lots of the following messaegs today:
: 
: EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455454
: EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455455
: EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455456
: EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455457
: EXT3-fs error (device lvm(58,0)): ext3_new_block: Allocating block in system zone - block = 205455461
: 
: 	The system is newly-created LVM volume group with one LV (~820 GB)
: Extent size is 32MB, LV has its extents interleaved across six PVs.
: 
: The ext3 filesystem is also newly created by the following command:
: mke2fs -j /dev/data_vg/export_lv -m 0 -R stride=8192  -J size=256
: 
: 	The problem appeared when I started to copy data to this
: LV (about half an hour after the tar xvf - was started).

	More info: no error has been reported by IDE layer.
XFS on the same LV works fine (2.4.20 + XFS patch + ptrace patch) - 
I've restored 200+GB data from backup to the XFS volume (no FS error
reported), then unmounted the filesystem, rebooted and ran xfs_repair
- no inconsistencies were found. I've also checked MD5 sums of few files,
and it was OK. So it seems it is an ext2/ext3 problem.

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
