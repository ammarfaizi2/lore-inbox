Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbWF1Awi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbWF1Awi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 20:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWF1Awi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 20:52:38 -0400
Received: from xenotime.net ([66.160.160.81]:8908 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932608AbWF1AwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 20:52:18 -0400
Date: Tue, 27 Jun 2006 17:54:56 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mchehab@infradead.org, akpm <akpm@osdl.org>
Subject: [PATCH] videocodec: make 1-bit fields unsigned
Message-Id: <20060627175456.89ef6d07.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Make 1-bit bitfields unsigned.  Removes 68 sparse errors like these:
drivers/media/video/videocodec.h:225:17: error: dubious one-bit signed bitfield
drivers/media/video/msp3400-driver.h:93:32: error: dubious one-bit signed bitfield

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/media/video/msp3400-driver.h |    4 ++--
 drivers/media/video/videocodec.h     |   16 ++++++++--------
 2 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2617-g11.orig/drivers/media/video/videocodec.h
+++ linux-2617-g11/drivers/media/video/videocodec.h
@@ -222,14 +222,14 @@ M                       zr36055[1] 0001 
 /* ========================= */
 
 struct vfe_polarity {
-	int vsync_pol:1;
-	int hsync_pol:1;
-	int field_pol:1;
-	int blank_pol:1;
-	int subimg_pol:1;
-	int poe_pol:1;
-	int pvalid_pol:1;
-	int vclk_pol:1;
+	unsigned int vsync_pol:1;
+	unsigned int hsync_pol:1;
+	unsigned int field_pol:1;
+	unsigned int blank_pol:1;
+	unsigned int subimg_pol:1;
+	unsigned int poe_pol:1;
+	unsigned int pvalid_pol:1;
+	unsigned int vclk_pol:1;
 };
 
 struct vfe_settings {
--- linux-2617-g11.orig/drivers/media/video/msp3400-driver.h
+++ linux-2617-g11/drivers/media/video/msp3400-driver.h
@@ -90,8 +90,8 @@ struct msp_state {
 	/* thread */
 	struct task_struct   *kthread;
 	wait_queue_head_t    wq;
-	int                  restart:1;
-	int                  watch_stereo:1;
+	unsigned int         restart:1;
+	unsigned int         watch_stereo:1;
 };
 
 /* msp3400-driver.c */


---
