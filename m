Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbWAYGlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbWAYGlB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 01:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWAYGlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 01:41:01 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:46554 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1751052AbWAYGlA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 01:41:00 -0500
Date: Wed, 25 Jan 2006 07:40:59 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Jan Kara <jack@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: [Patch] quota: fix error code for ext2_new_inode()
Message-ID: <20060125064059.GA3778@MAIL.13thfloor.at>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel ML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Honza!

the quota check in ext2_new_inode() returns ENOSPC where
IMHO it should return EDQUOT instead. here is a trivial
patch to fix that ...

rationale: ext3, reiser, udf and ufs do similar checks
and already return EDQUOT

best,
Herbert

Signed-off-by: Herbert Pötzl <herbert@13thfloor.at>

--- ./fs/ext2/ialloc.c.orig	2006-01-03 17:29:56 +0100
+++ ./fs/ext2/ialloc.c	2006-01-25 07:26:42 +0100
@@ -605,7 +605,7 @@ got:
 	insert_inode_hash(inode);
 
 	if (DQUOT_ALLOC_INODE(inode)) {
-		err = -ENOSPC;
+		err = -EDQUOT;
 		goto fail_drop;
 	}
 

