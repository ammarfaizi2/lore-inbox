Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268820AbTBZQ7x>; Wed, 26 Feb 2003 11:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268821AbTBZQ7x>; Wed, 26 Feb 2003 11:59:53 -0500
Received: from cmailm1.svr.pol.co.uk ([195.92.193.18]:62982 "EHLO
	cmailm1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S268820AbTBZQ7v>; Wed, 26 Feb 2003 11:59:51 -0500
Date: Wed, 26 Feb 2003 17:09:27 +0000
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/8] dm: prevent possible buffer overflow in ioctl interface
Message-ID: <20030226170927.GC8369@fib011235813.fsnet.co.uk>
References: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030226170537.GA8289@fib011235813.fsnet.co.uk>
User-Agent: Mutt/1.5.3i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the correct size for "name" in register_with_devfs().

During Al Viro's devfs cleanup a few versions ago, this function was
rewritten, and the "name" string added. The 32-byte size is not large
enough to prevent a possible buffer overflow in the sprintf() call,
since the hash cell can have a name up to 128 characters.

[Kevin Corry]

--- diff/drivers/md/dm-ioctl.c	2003-02-26 16:09:42.000000000 +0000
+++ source/drivers/md/dm-ioctl.c	2003-02-26 16:09:52.000000000 +0000
@@ -173,7 +173,7 @@
  */
 static int register_with_devfs(struct hash_cell *hc)
 {
-	char name[32];
+	char name[DM_NAME_LEN + strlen(DM_DIR) + 1];
 	struct gendisk *disk = dm_disk(hc->md);
 
 	sprintf(name, DM_DIR "/%s", hc->name);
