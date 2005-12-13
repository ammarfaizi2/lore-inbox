Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932266AbVLMAFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266AbVLMAFn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLMAFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:05:43 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:49924 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932266AbVLMAFm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:05:42 -0500
Date: Tue, 13 Dec 2005 01:05:42 +0100
From: Adrian Bunk <bunk@stusta.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [2.6 patch] drivers/mtd/: small cleanups
Message-ID: <20051213000542.GR23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- chips/sharp.c: make the needlessly global sharp_probe_init() static
- move some declarations to a header file where they belong to


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/chips/sharp.c |    2 +-
 drivers/mtd/inftlcore.c   |    5 -----
 include/linux/mtd/inftl.h |    5 +++++
 3 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.15-rc5-mm2-full/drivers/mtd/chips/sharp.c.old	2005-12-13 00:30:03.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/drivers/mtd/chips/sharp.c	2005-12-13 00:30:14.000000000 +0100
@@ -581,7 +581,7 @@
 
 }
 
-int __init sharp_probe_init(void)
+static int __init sharp_probe_init(void)
 {
 	printk("MTD Sharp chip driver <ds@lineo.com>\n");
 
--- linux-2.6.15-rc5-mm2-full/include/linux/mtd/inftl.h.old	2005-12-13 00:38:32.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/include/linux/mtd/inftl.h	2005-12-13 00:40:26.000000000 +0100
@@ -52,6 +52,11 @@
 int INFTL_mount(struct INFTLrecord *s);
 int INFTL_formatblock(struct INFTLrecord *s, int block);
 
+extern char inftlmountrev[];
+
+void INFTL_dumptables(struct INFTLrecord *s);
+void INFTL_dumpVUchains(struct INFTLrecord *s);
+
 #endif /* __KERNEL__ */
 
 #endif /* __MTD_INFTL_H__ */
--- linux-2.6.15-rc5-mm2-full/drivers/mtd/inftlcore.c.old	2005-12-13 00:39:14.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/drivers/mtd/inftlcore.c	2005-12-13 00:40:43.000000000 +0100
@@ -47,9 +47,6 @@
  */
 #define MAX_LOOPS 10000
 
-extern void INFTL_dumptables(struct INFTLrecord *inftl);
-extern void INFTL_dumpVUchains(struct INFTLrecord *inftl);
-
 static void inftl_add_mtd(struct mtd_blktrans_ops *tr, struct mtd_info *mtd)
 {
 	struct INFTLrecord *inftl;
@@ -885,8 +882,6 @@
 	.owner		= THIS_MODULE,
 };
 
-extern char inftlmountrev[];
-
 static int __init init_inftl(void)
 {
 	printk(KERN_INFO "INFTL: inftlcore.c $Revision: 1.19 $, "

