Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbRGXIZw>; Tue, 24 Jul 2001 04:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267134AbRGXIZm>; Tue, 24 Jul 2001 04:25:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19473 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267124AbRGXIZb>;
	Tue, 24 Jul 2001 04:25:31 -0400
Date: Tue, 24 Jul 2001 10:25:26 +0200
From: Jens Axboe <axboe@suse.de>
To: David Johnson <dave-kernel-list@centerclick.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD-RAM media detected with wrong number of blocks (2.4.7)
Message-ID: <20010724102526.K4221@suse.de>
In-Reply-To: <v04210101b781c827accb@[10.0.2.30]>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="NMuMz9nt05w80d4+"
Content-Disposition: inline
In-Reply-To: <v04210101b781c827accb@[10.0.2.30]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 23 2001, David Johnson wrote:
> When attempting to create an ext2 partition on a dvd-ram (2.6G/5.2G) 
> media the number of blocks is detected wrong causing only half of the 
> disk to be usable.  When creating the filesystem with mke2fs only 
> 609480 2K blocks are allowed instead of 1218960 2K blocks, and I end 
> up with a 1.2GB partition instead of 2.4GB one.  The 1.2GB fs works 
> fine, it's just a bit small :(
> 
> This is with 2.4.7 using a Creative DVD-RAM drive (1216S) on an Adaptec 
> 2940UW.
> 
> The correct number of blocks is detected in 2.4.6

Does this work?

-- 
Jens Axboe


--NMuMz9nt05w80d4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=sr-cap-1

--- drivers/scsi/sr_ioctl.c~	Tue Jul 24 10:24:46 2001
+++ drivers/scsi/sr_ioctl.c	Tue Jul 24 10:24:59 2001
@@ -545,7 +545,7 @@
 
 	switch (cmd) {
 	case BLKGETSIZE:
-		return put_user(scsi_CDs[target].capacity >> 1, (long *) arg);
+		return put_user(scsi_CDs[target].capacity >> 2, (long *) arg);
 	case BLKROSET:
 	case BLKROGET:
 	case BLKRASET:

--NMuMz9nt05w80d4+--
