Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267327AbUIOTYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267327AbUIOTYn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 15:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267333AbUIOTYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 15:24:43 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10725 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267327AbUIOTY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 15:24:26 -0400
Date: Wed, 15 Sep 2004 14:24:14 -0500
From: Robin Holt <holt@sgi.com>
To: linux-kernel@vger.kernel.org, resierfs-dev@namesys.com
Subject: [PATCH 2/2] Fix write() return values for reiserfs.
Message-ID: <20040915192414.GC3275@lnx-holt.americas.sgi.com>
References: <20040915191933.GA3275@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915191933.GA3275@lnx-holt.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes the direct I/O return value for reiserfs writes
to be ssize_t instead of int.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/fs/reiserfs/file.c
===================================================================
--- linux-2.6.orig/fs/reiserfs/file.c	2004-09-14 14:39:37.000000000 -0500
+++ linux-2.6/fs/reiserfs/file.c	2004-09-15 12:42:41.000000000 -0500
@@ -1099,7 +1099,7 @@
 {
     size_t already_written = 0; // Number of bytes already written to the file.
     loff_t pos; // Current position in the file.
-    size_t res; // return value of various functions that we call.
+    ssize_t res; // return value of various functions that we call.
     struct inode *inode = file->f_dentry->d_inode; // Inode of the file that we are writing to.
 				/* To simplify coding at this time, we store
 				   locked pages in array for now */
@@ -1108,7 +1108,7 @@
     th.t_trans_id = 0;
 
     if ( file->f_flags & O_DIRECT) { // Direct IO needs treatment
-	int result, after_file_end = 0;
+	ssize_t result, after_file_end = 0;
 	if ( (*ppos + count >= inode->i_size) || (file->f_flags & O_APPEND) ) {
 	    /* If we are appending a file, we need to put this savelink in here.
 	       If we will crash while doing direct io, finish_unfinished will
