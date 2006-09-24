Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWIXWwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWIXWwB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWIXWwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:52:01 -0400
Received: from mail.gmx.de ([213.165.64.20]:11651 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932136AbWIXWwB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:52:01 -0400
X-Authenticated: #704063
Subject: [Patch] remove unnessecairy check in drivers/scsi/sg.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: dgilbert@interlog.com
Content-Type: text/plain
Date: Mon, 25 Sep 2006 00:51:57 +0200
Message-Id: <1159138317.9062.9.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

coverity spotted this (cid #758). All callers dereference sfp,
so we dont need this check. In addition to this, we dereference
it earlier in the function.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git3/drivers/scsi/sg.c.orig	2006-09-24 22:11:36.000000000 +0200
+++ linux-2.6.18-git3/drivers/scsi/sg.c	2006-09-24 22:12:14.000000000 +0200
@@ -1828,7 +1828,7 @@ sg_build_indirect(Sg_scatter_hold * schp
 	int blk_size = buff_size;
 	struct page *p = NULL;
 
-	if ((blk_size < 0) || (!sfp))
+	if (blk_size < 0)
 		return -EFAULT;
 	if (0 == blk_size)
 		++blk_size;	/* don't know why */


