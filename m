Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267319AbUIOTWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267319AbUIOTWQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbUIOTWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:22:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21218 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267319AbUIOTWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:22:13 -0400
Date: Wed, 15 Sep 2004 14:22:12 -0500
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Fix write() return values for tmpfs.
Message-ID: <20040915192212.GB3275@lnx-holt.americas.sgi.com>
References: <20040915191933.GA3275@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915191933.GA3275@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the return from the write() syscall actually an ssize_t
instead of an int.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/mm/shmem.c
===================================================================
--- linux-2.6.orig/mm/shmem.c	2004-09-14 14:40:06.000000000 -0500
+++ linux-2.6/mm/shmem.c	2004-09-14 14:54:38.000000000 -0500
@@ -1301,7 +1301,7 @@
 	struct inode	*inode = file->f_dentry->d_inode;
 	loff_t		pos;
 	unsigned long	written;
-	int		err;
+	ssize_t		err;
 
 	if ((ssize_t) count < 0)
 		return -EINVAL;
