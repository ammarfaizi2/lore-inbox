Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266333AbUIMH5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266333AbUIMH5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 03:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266364AbUIMH5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 03:57:31 -0400
Received: from clusterfw.beelinegprs.com ([217.118.66.232]:53551 "EHLO
	crimson.namesys.com") by vger.kernel.org with ESMTP id S266333AbUIMH5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 03:57:20 -0400
Date: Mon, 13 Sep 2004 11:49:22 +0400
From: Alex Zarochentsev <zam@namesys.com>
To: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] use S_ISDIR() in link_path_walk() to decide whether the last path component is a directory
Message-ID: <20040913074921.GA2252@backtop.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch does not allow open(name, O_DIRECTORY) to be successful for
non-directories in reiser4.  It replaces ->i_op->lookup != NULL "is dir" check
for the last path component by explicit S_ISDIR(->i_mode) check. 

Regardless to reiser4, S_ISDIR() looks more clear there.

Thanks in advance.

===== fs/namei.c 1.104 vs edited =====
--- 1.104/fs/namei.c	Tue Aug 10 16:59:38 2004
+++ edited/fs/namei.c	Sun Sep 12 11:00:18 2004
@@ -816,7 +816,7 @@
 			break;
 		if (lookup_flags & LOOKUP_DIRECTORY) {
 			err = -ENOTDIR; 
-			if (!inode->i_op || !inode->i_op->lookup)
+			if (!S_ISDIR(inode->i_mode))
 				break;
 		}
 		goto return_base;
