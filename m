Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVCFOcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVCFOcj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:32:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261404AbVCFOcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:32:39 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:17168 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261401AbVCFOcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:32:36 -0500
Date: Sun, 6 Mar 2005 15:32:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] mm/filemap.c: make generic_file_direct_IO static
Message-ID: <20050306143235.GC5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

generic_file_direct_IO isn't used outside of this file.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/fs.h |    2 --
 mm/filemap.c       |    7 +++++--
 2 files changed, 5 insertions(+), 4 deletions(-)

--- linux-2.6.11-mm1-full/include/linux/fs.h.old	2005-03-04 15:42:34.000000000 +0100
+++ linux-2.6.11-mm1-full/include/linux/fs.h	2005-03-04 15:42:40.000000000 +0100
@@ -1487,8 +1487,6 @@
 				    loff_t *, read_descriptor_t *, read_actor_t);
 extern void
 file_ra_state_init(struct file_ra_state *ra, struct address_space *mapping);
-extern ssize_t generic_file_direct_IO(int rw, struct kiocb *iocb,
-	const struct iovec *iov, loff_t offset, unsigned long nr_segs);
 extern ssize_t generic_file_readv(struct file *filp, const struct iovec *iov, 
 	unsigned long nr_segs, loff_t *ppos);
 ssize_t generic_file_writev(struct file *filp, const struct iovec *iov, 
--- linux-2.6.11-mm1-full/mm/filemap.c.old	2005-03-04 15:42:48.000000000 +0100
+++ linux-2.6.11-mm1-full/mm/filemap.c	2005-03-04 15:44:29.000000000 +0100
@@ -41,6 +41,10 @@
 #include <asm/uaccess.h>
 #include <asm/mman.h>
 
+static ssize_t
+generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
+	loff_t offset, unsigned long nr_segs);
+
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
  * though.
@@ -2314,7 +2318,7 @@
  * Called under i_sem for writes to S_ISREG files.   Returns -EIO if something
  * went wrong during pagecache shootdown.
  */
-ssize_t
+static ssize_t
 generic_file_direct_IO(int rw, struct kiocb *iocb, const struct iovec *iov,
 	loff_t offset, unsigned long nr_segs)
 {
@@ -2349,4 +2353,3 @@
 	}
 	return retval;
 }
-EXPORT_SYMBOL_GPL(generic_file_direct_IO);

