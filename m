Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274883AbTHFGh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 02:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274884AbTHFGh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 02:37:57 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:35519 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S274883AbTHFGhy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 02:37:54 -0400
Date: Wed, 6 Aug 2003 02:40:26 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 badness in 2.6.0-test2
Message-ID: <20030806064026.GA1084@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   EXT3-fs error (device md0) in start_transaction: Journal has aborted

> Without the initial message we do not know.

During a dbench 64 run with 2.6.0-test2-mm4 on ext3 /var/log/messages said:

kernel: attempt to access beyond end of device
kernel: hdc1: rw=0, want=1212696656, limit=4096449

fdisk /dev/hdc using sectors for units shows:
Disk /dev/hdc: 16 heads, 63 sectors, 39703 cylinders
Units = sectors of 1 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1            63   4096511   2048224+  83  Linux
/dev/hdc2       4096512  23634575   9769032   83  Linux
/dev/hdc3   *  23634576  40020623   8193024   83  Linux


The console displayed:

Buffer I/O error on device hdc1, logical block 298266
lost page write due to I/O error on hdc1
Buffer I/O error on device hdc1, logical block 298112
lost page write due to I/O error on hdc1
Buffer I/O error on device hdc1, logical block 296626
lost page write due to I/O error on hdc1
Buffer I/O error on device hdc1, logical block 294743
lost page write due to I/O error on hdc1
EXT3-fs error (device hdc1): ext3_free_blocks: Freeing blocks not in datazone - block = 151587081, count = 1
Aborting journal on device hdc1.
ext3_abort called.
EXT3-fs abort (device hdc1): ext3_journal_start: Detected aborted journal
Remounting filesystem read-only
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hdc1) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdc1) in ext3_truncate: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hdc1) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdc1) in ext3_orphan_del: Journal has aborted
ext3_reserve_inode_write: aborting transaction: Journal has aborted in __ext3_journal_get_write_access<2>EXT3-fs error (device hdc1) in ext3_reserve_inode_write: Journal has aborted
EXT3-fs error (device hdc1) in ext3_delete_inode: Journal has aborted

The console did not respond to <Enter>.
The machine was pingable, but would not give an ssh prompt.

Additional /var/log/messages:

Aug  5 20:29:24 mountain kernel: Buffer I/O error on device hdc1, logical block 298266
Aug  5 20:29:24 mountain kernel: lost page write due to I/O error on hdc1
Aug  5 20:29:24 mountain kernel: Buffer I/O error on device hdc1, logical block 298112
Aug  5 20:29:24 mountain kernel: lost page write due to I/O error on hdc1
Aug  5 20:29:24 mountain kernel: Buffer I/O error on device hdc1, logical block 296626
Aug  5 20:29:24 mountain kernel: lost page write due to I/O error on hdc1
Aug  5 20:29:24 mountain kernel: Buffer I/O error on device hdc1, logical block 294743
Aug  5 20:29:24 mountain kernel: lost page write due to I/O error on hdc1
Aug  5 20:29:24 mountain kernel: attempt to access beyond end of device
Aug  5 20:29:24 mountain kernel: hdc1: rw=0, want=1212696656, limit=4096449
Aug  5 20:29:24 mountain kernel: attempt to access beyond end of device
Aug  5 20:29:24 mountain kernel: hdc1: rw=0, want=1212696656, limit=4096449
Aug  5 20:29:24 mountain kernel: attempt to access beyond end of device
Aug  5 20:29:36 mountain kernel: hdc1: rw=0, want=1212696656, limit=4096449
..

Uniprocessor K6/2 with IDE disks.
It did not have a problem with dbench 32 on ext3.
dbench on ext2 ran fine too.
e2fsprogs-1.33.  After e2fsck, filesystem seems okay.


--
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

