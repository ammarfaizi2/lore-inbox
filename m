Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267680AbTBLTEd>; Wed, 12 Feb 2003 14:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTBLTEd>; Wed, 12 Feb 2003 14:04:33 -0500
Received: from ztxmail01.ztx.compaq.com ([161.114.1.205]:6930 "EHLO
	ztxmail01.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S267680AbTBLTEc>; Wed, 12 Feb 2003 14:04:32 -0500
Date: Wed, 12 Feb 2003 13:14:55 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071455.GD1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix possible array bounds overrun in cciss driver
(patch 4 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss.c~fix_open_bug	2003-02-12 10:12:48.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:12:48.000000000 +0600
@@ -345,7 +345,7 @@ static int cciss_open(struct inode *inod
 	printk(KERN_DEBUG "cciss_open %x (%x:%x)\n", inode->i_rdev, ctlr, dsk);
 #endif /* CCISS_DEBUG */ 
 
-	if (ctlr > MAX_CTLR || hba[ctlr] == NULL)
+	if (ctlr >= MAX_CTLR || hba[ctlr] == NULL)
 		return -ENXIO;
 	/*
 	 * Root is allowed to open raw volume zero even if its not configured

_
