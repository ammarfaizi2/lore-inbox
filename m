Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751061AbWITU7S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbWITU7S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWITU7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:59:15 -0400
Received: from [63.64.152.142] ([63.64.152.142]:58125 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751066AbWITU7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:59:14 -0400
From: Ashwini Kulkarni <ashwini.kulkarni@intel.com>
Subject: [RFC 1/6] Make splice_to_pipe non-static and move structure definitions to a header file
Date: Wed, 20 Sep 2006 14:08:11 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: christopher.leech@intel.com
Message-Id: <20060920210811.17480.60103.stgit@gitlost.site>
In-Reply-To: <20060920210711.17480.92354.stgit@gitlost.site>
References: <20060920210711.17480.92354.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


---

 fs/splice.c               |   18 +-----------------
 include/linux/pipe_fs_i.h |   18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 684bca3..c6a880b 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -29,22 +29,6 @@
 #include <linux/syscalls.h>
 #include <linux/uio.h>
 
-struct partial_page {
-	unsigned int offset;
-	unsigned int len;
-};
-
-/*
- * Passed to splice_to_pipe
- */
-struct splice_pipe_desc {
-	struct page **pages;		/* page map */
-	struct partial_page *partial;	/* pages[] may not be contig */
-	int nr_pages;			/* number of pages in map */
-	unsigned int flags;		/* splice flags */
-	struct pipe_buf_operations *ops;/* ops associated with output pipe */
-};
-
 /*
  * Attempt to steal a page from a pipe buffer. This should perhaps go into
  * a vm helper function, it's already simplified quite a bit by the
@@ -173,7 +157,7 @@ static struct pipe_buf_operations user_p
  * Pipe output worker. This sets up our pipe format with the page cache
  * pipe buffer operations. Otherwise very similar to the regular pipe_writev().
  */
-static ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
+ssize_t splice_to_pipe(struct pipe_inode_info *pipe,
 			      struct splice_pipe_desc *spd)
 {
 	int ret, do_wakeup, page_nr;
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index ea4f7cd..9067985 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -100,4 +100,22 @@ extern ssize_t splice_from_pipe(struct p
 				loff_t *, size_t, unsigned int,
 				splice_actor *);
 
+struct partial_page {
+	unsigned int offset;
+	unsigned int len;
+};
+
+/*
+ * Passed to splice_to_pipe
+ */
+struct splice_pipe_desc {
+	struct page **pages;		/* page map */
+	struct partial_page *partial;	/* pages[] may not be contig */
+	int nr_pages;			/* number of pages in map */
+	unsigned int flags;		/* splice flags */
+	struct pipe_buf_operations *ops;/* ops associated with output pipe */
+};
+
+ssize_t splice_to_pipe(struct pipe_inode_info *, struct splice_pipe_desc *);
+
 #endif

