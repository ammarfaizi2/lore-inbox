Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282092AbRLCIvk>; Mon, 3 Dec 2001 03:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284392AbRLCIuA>; Mon, 3 Dec 2001 03:50:00 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:58119 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S284401AbRLBXW5>; Sun, 2 Dec 2001 18:22:57 -0500
Date: Mon, 3 Dec 2001 00:22:08 +0100
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com, Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Looback bugfix
Message-ID: <20011203002208.D16005@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending you a patch which should fix bug in loopback device - it
allows you to setup loopback /dev/loop0 -> /dev/loop0 with very unpleasant
(hard deadlock) results. The patch is against 2.4.16 but should apply well
against 2.5.0 too. Could oth of you apply the patch please?

							Bye

								Honza

--
Jan Kara <jack@suse.cz>
SuSE CR Labs

------- <cut> ---------

diff -ruX /home/jack/.kerndiffexclude linux-2.4.16/drivers/block/loop.c linux-2.4.16-loopfix/drivers/block/loop.c
--- linux-2.4.16/drivers/block/loop.c	Mon Nov 19 23:48:02 2001
+++ linux-2.4.16-loopfix/drivers/block/loop.c	Sat Dec  1 00:07:39 2001
@@ -640,6 +640,10 @@
 
 	if (S_ISBLK(inode->i_mode)) {
 		lo_device = inode->i_rdev;
+		if (lo_device == dev) {
+			error = -EBUSY;
+			goto out;
+		}
 	} else if (S_ISREG(inode->i_mode)) {
 		struct address_space_operations *aops = inode->i_mapping->a_ops;
 		/*
