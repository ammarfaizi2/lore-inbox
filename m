Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263007AbUDLTRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbUDLTRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:17:33 -0400
Received: from astra.telenet-ops.be ([195.130.132.58]:12686 "EHLO
	astra.telenet-ops.be") by vger.kernel.org with ESMTP
	id S263007AbUDLTRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:17:32 -0400
Date: Mon, 12 Apr 2004 21:17:06 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Andrew Apted <ajapted@netspace.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] v2.6.5 drivers/video/console/mdacon.c
Message-ID: <20040412211706.E30061@infomag.infomag.iguana.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

A small fix for drivers/video/console/mdacon.c .
It's untested since I don't have this hardware myself.

Greetings,
Wim.

================================================================================
diff -Nru a/drivers/video/console/mdacon.c b/drivers/video/console/mdacon.c
--- a/drivers/video/console/mdacon.c	Thu Mar 11 03:55:28 2004
+++ b/drivers/video/console/isicom.c	Mon Apr 12 20:49:45 2004
@@ -371,7 +371,7 @@
 	if (mda_display_fg == NULL)
 		mda_display_fg = c;
 
-	MOD_INC_USE_COUNT;
+	__module_get(THIS_MODULE);
 }
 
 static void mdacon_deinit(struct vc_data *c)
@@ -381,7 +381,7 @@
 	if (mda_display_fg == c)
 		mda_display_fg = NULL;
 
-	MOD_DEC_USE_COUNT;
+	module_put(THIS_MODULE);
 }
 
 static inline u16 mda_convert_attr(u16 ch)
@@ -502,7 +502,7 @@
 	return -EINVAL;
 }
 
-static int mdacon_blank(struct vc_data *c, int blank)
+static int mdacon_blank(struct vc_data *c, int blank, int mode_switch)
 {
 	if (mda_type == TYPE_MDA) {
 		if (blank) 
