Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314842AbSD3S6r>; Tue, 30 Apr 2002 14:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314870AbSD3S6q>; Tue, 30 Apr 2002 14:58:46 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:55818 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S314842AbSD3S6p>; Tue, 30 Apr 2002 14:58:45 -0400
Date: Tue, 30 Apr 2002 20:58:41 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
To: Tommy Faasen <tommy@vuurwerk.nl>
cc: Linux kernel Mailinglist <linux-kernel@vger.kernel.org>, mingo@redhat.com
Subject: Re: [OOPS] 2.5.11 software raid,reiserfs & scsi
In-Reply-To: <1020100863.1111.7.camel@it0>
Message-ID: <Pine.LNX.4.21.0204302056120.23113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29 Apr 2002, Tommy Faasen wrote:

> I got an oops on 2.5.11 with an software raid 0 setup on 3 scsi disks,
> it worked ok on 2.5.8. I get this when booting up and then my /dev/md0
> isn't found.. If you need more details/help let me know!

The patch below fixes it for me.
rdev doesn't point to a valid raid partition.

bye, Roman

Index: drivers/md/md.c
===================================================================
RCS file: /usr/src/cvsroot/linux-2.5/drivers/md/md.c,v
retrieving revision 1.1.1.8
diff -u -p -r1.1.1.8 md.c
--- drivers/md/md.c	29 Apr 2002 17:35:50 -0000	1.1.1.8
+++ drivers/md/md.c	30 Apr 2002 17:52:04 -0000
@@ -1577,6 +1577,7 @@ static int device_size_calculation(mddev
 	if (!md_size[mdidx(mddev)])
 		md_size[mdidx(mddev)] = sb->size * data_disks;
 
+	rdev = list_entry(mddev->disks.next, mdk_rdev_t, same_set);
 	readahead = (blk_get_readahead(rdev->bdev) * 512) / PAGE_SIZE;
 	if (!sb->level || (sb->level == 4) || (sb->level == 5)) {
 		readahead = (mddev->sb->chunk_size>>PAGE_SHIFT) * 4 * data_disks;

