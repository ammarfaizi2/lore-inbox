Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265911AbVBFAaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbVBFAaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 19:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266728AbVBFAaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 19:30:16 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:56848 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S265911AbVBFA3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 19:29:15 -0500
Date: Sun, 6 Feb 2005 01:29:07 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Carsten Paeth <calle@calle.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/hardware/avm/: misc cleanups
Message-ID: <20050206002907.GI3129@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following cleanups:
- make some needlessly global functions static
- b1dma.c __init/__exit the functions b1dma_{init,exit}

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/hardware/avm/b1dma.c |    4 ++--
 drivers/isdn/hardware/avm/c4.c    |    6 +++---
 drivers/isdn/hardware/avm/t1isa.c |    2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/avm/b1dma.c.old	2005-02-05 15:40:43.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/avm/b1dma.c	2005-02-05 15:42:32.000000000 +0100
@@ -955,7 +955,7 @@
 EXPORT_SYMBOL(b1dma_send_message);
 EXPORT_SYMBOL(b1dmactl_read_proc);
 
-int b1dma_init(void)
+static int __init b1dma_init(void)
 {
 	char *p;
 	char rev[32];
@@ -972,7 +972,7 @@
 	return 0;
 }
 
-void b1dma_exit(void)
+static void __exit b1dma_exit(void)
 {
 }
 
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/avm/c4.c.old	2005-02-05 15:42:47.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/avm/c4.c	2005-02-05 15:43:16.000000000 +0100
@@ -885,7 +885,7 @@
 }
 
 
-void c4_reset_ctr(struct capi_ctr *ctrl)
+static void c4_reset_ctr(struct capi_ctr *ctrl)
 {
 	avmcard *card = ((avmctrl_info *)(ctrl->driverdata))->card;
 	avmctrl_info *cinfo;
@@ -933,7 +933,7 @@
 /* ------------------------------------------------------------- */
 
 
-void c4_register_appl(struct capi_ctr *ctrl,
+static void c4_register_appl(struct capi_ctr *ctrl,
 				u16 appl,
 				capi_register_params *rp)
 {
@@ -978,7 +978,7 @@
 
 /* ------------------------------------------------------------- */
 
-void c4_release_appl(struct capi_ctr *ctrl, u16 appl)
+static void c4_release_appl(struct capi_ctr *ctrl, u16 appl)
 {
 	avmctrl_info *cinfo = (avmctrl_info *)(ctrl->driverdata);
 	avmcard *card = cinfo->card;
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/avm/t1isa.c.old	2005-02-05 15:43:33.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/avm/t1isa.c	2005-02-05 15:43:41.000000000 +0100
@@ -328,7 +328,7 @@
 	return 0;
 }
 
-void t1isa_reset_ctr(struct capi_ctr *ctrl)
+static void t1isa_reset_ctr(struct capi_ctr *ctrl)
 {
 	avmctrl_info *cinfo = (avmctrl_info *)(ctrl->driverdata);
 	avmcard *card = cinfo->card;

