Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264868AbTFLPml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264869AbTFLPml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:42:41 -0400
Received: from windsormachine.com ([206.48.122.28]:2059 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S264868AbTFLPmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:42:40 -0400
Date: Thu, 12 Jun 2003 11:56:11 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: <linux-kernel@vger.kernel.org>
Subject: 3ware and two drive hardware raid1
Message-ID: <Pine.LNX.4.33.0306121148340.22835-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If i have a hardware raid1 array of two 120 gig Maxtor DiamondMax 9 drives
on a 3ware 7000-2.  Failure of one disk should not go all the way up to
the OS and cause the OS to report hard errors, and remount the drive as
read-only, right?

My understanding of raid1 was that if there was a disk failure it would
note it, mark the drive as bad, and switch to running off the other drive.
Software raid on Linux does that.

This certainly isn't that!

Jun 12 04:00:00 x kernel: 3w-xxxx: scsi1: Command failed: status = 0xc7, flags = 0x40, unit #0.
Jun 12 04:00:25 x last message repeated 4 times
Jun 12 04:00:25 x kernel: scsi1: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 86 b8 aa 00 00 08 00
Jun 12 04:00:25 x kernel: Info fld=0x0, Current sd08:06: sns = f0  3
Jun 12 04:00:25 x kernel: ASC=11 ASCQ= 0
Jun 12 04:00:25 x kernel: Raw sense data:0xf0 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x00
Jun 12 04:00:25 x kernel:  I/O error: dev 08:06, sector 41480
Jun 12 04:00:25 x kernel: journal_bmap: journal block not found at offset 5132 on sd(8,6)
Jun 12 04:00:25 x kernel: Aborting journal on device sd(8,6).
Jun 12 04:00:29 x kernel: ext3_abort called.
Jun 12 04:00:29 x kernel: EXT3-fs abort (device sd(8,6)): ext3_journal_start: Detected aborted journal
Jun 12 04:00:29 x kernel: Remounting filesystem read-only

I'll be out at the facility tomorrow to replace the dead drive(appears to
be unit #0), but am extremely curious why the 3ware unit did what it did!

I'm running a badblocks on the partition that was mounted readonly to see
if the filesystem is corrupted.(luckily it's all .tar files, so any
corruption will hopefully be easy to see.)

Running kernel 2.4.20 on Debian Stable.

Mike

