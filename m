Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSL3B7l>; Sun, 29 Dec 2002 20:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265872AbSL3B7l>; Sun, 29 Dec 2002 20:59:41 -0500
Received: from verein.lst.de ([212.34.181.86]:29196 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S265863AbSL3B7k>;
	Sun, 29 Dec 2002 20:59:40 -0500
Date: Mon, 30 Dec 2002 03:07:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] remove superflous module use count handling in jbd
Message-ID: <20021230030757.A13635@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	akpm@digeo.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

journal_init_common is always called from ext3 which already makes
jbd.ko unloadable by relying on exported functions.

--- 1.22/fs/jbd/journal.c	Thu Oct 10 22:39:43 2002
+++ edited/fs/jbd/journal.c	Mon Dec 30 02:16:47 2002
@@ -694,8 +694,6 @@
 	journal_t *journal;
 	int err;
 
-	MOD_INC_USE_COUNT;
-
 	journal = jbd_kmalloc(sizeof(*journal), GFP_KERNEL);
 	if (!journal)
 		goto fail;
@@ -724,7 +722,6 @@
 	}
 	return journal;
 fail:
-	MOD_DEC_USE_COUNT;
 	return NULL;
 }
 
@@ -1131,7 +1128,6 @@
 
 	unlock_journal(journal);
 	kfree(journal);
-	MOD_DEC_USE_COUNT;
 }
 
 
