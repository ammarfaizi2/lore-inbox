Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161030AbWFVKDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161030AbWFVKDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 06:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWFVKDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 06:03:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:42255 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161030AbWFVKDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 06:03:24 -0400
Date: Thu, 22 Jun 2006 12:03:24 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, swhiteho@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: [-mm patch] fs/gfs2/: make code static
Message-ID: <20060622100324.GZ9111@stusta.de>
References: <20060621034857.35cfe36f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060621034857.35cfe36f.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2006 at 03:48:57AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.17-rc6-mm2:
>...
>  git-gfs2.patch
>...
>  git trees
>...

This patch makes the following needlessly global code static:
- eaops.c: struct gfs2_security_eaops
- rgrp.c: gfs2_free_uninit_di()

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/gfs2/eaops.c |    2 +-
 fs/gfs2/eaops.h |    2 --
 fs/gfs2/rgrp.c  |    2 +-
 fs/gfs2/rgrp.h  |    1 -
 4 files changed, 2 insertions(+), 5 deletions(-)

--- linux-2.6.17-mm1-full/fs/gfs2/eaops.h.old	2006-06-22 01:39:33.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/gfs2/eaops.h	2006-06-22 01:39:45.000000000 +0200
@@ -23,8 +23,6 @@
 
 extern struct gfs2_eattr_operations gfs2_system_eaops;
 
-extern struct gfs2_eattr_operations gfs2_security_eaops;
-
 extern struct gfs2_eattr_operations *gfs2_ea_ops[];
 
 #endif /* __EAOPS_DOT_H__ */
--- linux-2.6.17-mm1-full/fs/gfs2/eaops.c.old	2006-06-22 01:39:05.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/gfs2/eaops.c	2006-06-22 01:39:40.000000000 +0200
@@ -214,7 +214,7 @@
 	.eo_name = "system",
 };
 
-struct gfs2_eattr_operations gfs2_security_eaops = {
+static struct gfs2_eattr_operations gfs2_security_eaops = {
 	.eo_get = security_eo_get,
 	.eo_set = security_eo_set,
 	.eo_remove = security_eo_remove,
--- linux-2.6.17-mm1-full/fs/gfs2/rgrp.h.old	2006-06-22 01:39:52.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/gfs2/rgrp.h	2006-06-22 01:40:07.000000000 +0200
@@ -43,7 +43,6 @@
 
 void gfs2_free_data(struct gfs2_inode *ip, uint64_t bstart, uint32_t blen);
 void gfs2_free_meta(struct gfs2_inode *ip, uint64_t bstart, uint32_t blen);
-void gfs2_free_uninit_di(struct gfs2_rgrpd *rgd, uint64_t blkno);
 void gfs2_free_di(struct gfs2_rgrpd *rgd, struct gfs2_inode *ip);
 void gfs2_unlink_di(struct inode *inode);
 
--- linux-2.6.17-mm1-full/fs/gfs2/rgrp.c.old	2006-06-22 01:40:15.000000000 +0200
+++ linux-2.6.17-mm1-full/fs/gfs2/rgrp.c	2006-06-22 01:40:20.000000000 +0200
@@ -1401,7 +1401,7 @@
 	gfs2_trans_add_rg(rgd);
 }
 
-void gfs2_free_uninit_di(struct gfs2_rgrpd *rgd, uint64_t blkno)
+static void gfs2_free_uninit_di(struct gfs2_rgrpd *rgd, uint64_t blkno)
 {
 	struct gfs2_sbd *sdp = rgd->rd_sbd;
 	struct gfs2_rgrpd *tmp_rgd;

