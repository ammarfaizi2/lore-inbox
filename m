Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261980AbUKPOXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUKPOXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbUKPOXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:23:49 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25028 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261980AbUKPOJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:09:47 -0500
Date: Tue, 16 Nov 2004 19:36:17 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [patch 3/4] Cleanup file_count usage: Redundant check based on file_count
Message-ID: <20041116140617.GD23257@impedimenta.in.ibm.com>
References: <20041116135200.GA23257@impedimenta.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116135200.GA23257@impedimenta.in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The file_count check below seems to be redundant. Getting rid of it.

Signed-off-by: Ravikiran Thirumalai <kiran@in.ibm.com>
---
diff -ruN -X dontdiff2 linux-2.6.9/fs/super.c f_count-2.6.9/fs/super.c
--- linux-2.6.9/fs/super.c	2004-10-19 03:24:07.000000000 +0530
+++ f_count-2.6.9/fs/super.c	2004-11-15 14:52:06.000000000 +0530
@@ -503,7 +503,7 @@
 
 	file_list_lock();
 	list_for_each_entry(f, &sb->s_files, f_list) {
-		if (S_ISREG(f->f_dentry->d_inode->i_mode) && file_count(f))
+		if (S_ISREG(f->f_dentry->d_inode->i_mode))
 			f->f_mode &= ~FMODE_WRITE;
 	}
 	file_list_unlock();
