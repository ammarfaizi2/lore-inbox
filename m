Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWAQO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWAQO1M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWAQO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:27:12 -0500
Received: from hera.kernel.org ([140.211.167.34]:16811 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932510AbWAQO1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:27:11 -0500
Date: Tue, 17 Jan 2006 10:27:01 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: linux-kernel@vger.kernel.org
Cc: levon@movementarian.org, Al Viro <viro@ftp.linux.org.uk>
Subject: make "struct d_cookie" dependable on CONFIG_PROFILING?
Message-ID: <20060117122701.GA26491@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Is there any good reason for not making "struct dcookie_struct
*d_cookie" dependable on CONFIG_PROFILING? 

Shrinks "struct dentry" from 128 bytes to 124 on x86, allowing
31 objects per slab instead of 30.

John Levon informed me that he had such selection in his
original patches, but was asked but take it off (?).


--- ./fs/dcache.c.orig	2006-01-17 09:52:31.000000000 -0200
+++ ./fs/dcache.c	2006-01-17 09:52:50.000000000 -0200
@@ -743,7 +743,9 @@ struct dentry *d_alloc(struct dentry * p
 	dentry->d_op = NULL;
 	dentry->d_fsdata = NULL;
 	dentry->d_mounted = 0;
+#ifdef CONFIG_PROFILING
 	dentry->d_cookie = NULL;
+#endif
 	INIT_HLIST_NODE(&dentry->d_hash);
 	INIT_LIST_HEAD(&dentry->d_lru);
 	INIT_LIST_HEAD(&dentry->d_subdirs);
--- ./include/linux/dcache.h.orig	2006-01-17 09:54:12.000000000 -0200
+++ ./include/linux/dcache.h	2006-01-17 09:55:26.000000000 -0200
@@ -108,7 +108,9 @@ struct dentry {
 	struct dentry_operations *d_op;
 	struct super_block *d_sb;	/* The root of the dentry tree */
 	void *d_fsdata;			/* fs-specific data */
+#ifdef CONFIG_PROFILING
 	struct dcookie_struct *d_cookie; /* cookie, if any */
+#endif
 	int d_mounted;
 	unsigned char d_iname[DNAME_INLINE_LEN_MIN];	/* small names */
 };
