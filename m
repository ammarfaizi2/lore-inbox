Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWF2TV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWF2TV2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 15:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWF2TV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 15:21:27 -0400
Received: from [141.84.69.5] ([141.84.69.5]:28432 "HELO mailout.stusta.mhn.de")
	by vger.kernel.org with SMTP id S932275AbWF2TU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 15:20:56 -0400
Date: Thu, 29 Jun 2006 21:20:15 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, trond.myklebust@fys.uio.no
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fs/nfs/: make 2 functions static
Message-ID: <20060629192015.GQ19712@stusta.de>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 01:36:43AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-mm3:
>...
>  git-nfs.patch
>...
>  git trees.
>...

nfs_writedata_free() and nfs_readdata_free() can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/nfs/read.c          |    2 +-
 fs/nfs/write.c         |    2 +-
 include/linux/nfs_fs.h |    6 ++----
 3 files changed, 4 insertions(+), 6 deletions(-)

--- linux-2.6.17-mm4-full/include/linux/nfs_fs.h.old	2006-06-29 15:04:22.000000000 +0200
+++ linux-2.6.17-mm4-full/include/linux/nfs_fs.h	2006-06-29 15:05:22.000000000 +0200
@@ -477,10 +477,9 @@
 }
 
 /*
- * Allocate and free nfs_write_data structures
+ * Allocate nfs_write_data structures
  */
 extern struct nfs_write_data *nfs_writedata_alloc(unsigned int pagecount);
-extern void nfs_writedata_free(struct nfs_write_data *p);
 
 /*
  * linux/fs/nfs/read.c
@@ -492,10 +491,9 @@
 extern void nfs_readdata_release(void *data);
 
 /*
- * Allocate and free nfs_read_data structures
+ * Allocate nfs_read_data structures
  */
 extern struct nfs_read_data *nfs_readdata_alloc(unsigned int pagecount);
-extern void nfs_readdata_free(struct nfs_read_data *p);
 
 /*
  * linux/fs/nfs3proc.c
--- linux-2.6.17-mm4-full/fs/nfs/read.c.old	2006-06-29 15:05:31.000000000 +0200
+++ linux-2.6.17-mm4-full/fs/nfs/read.c	2006-06-29 15:05:37.000000000 +0200
@@ -64,7 +64,7 @@
 	return p;
 }
 
-void nfs_readdata_free(struct nfs_read_data *p)
+static void nfs_readdata_free(struct nfs_read_data *p)
 {
 	if (p && (p->pagevec != &p->page_array[0]))
 		kfree(p->pagevec);
--- linux-2.6.17-mm4-full/fs/nfs/write.c.old	2006-06-29 15:05:48.000000000 +0200
+++ linux-2.6.17-mm4-full/fs/nfs/write.c	2006-06-29 15:05:56.000000000 +0200
@@ -138,7 +138,7 @@
 	return p;
 }
 
-void nfs_writedata_free(struct nfs_write_data *p)
+static void nfs_writedata_free(struct nfs_write_data *p)
 {
 	if (p && (p->pagevec != &p->page_array[0]))
 		kfree(p->pagevec);

