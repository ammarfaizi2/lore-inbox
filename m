Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVC0UnL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVC0UnL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 15:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVC0UnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 15:43:10 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24592 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261381AbVC0UlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 15:41:22 -0500
Date: Sun, 27 Mar 2005 22:41:19 +0200
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/video/console/fbcon.c: fix a check after use
Message-ID: <20050327204119.GY4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a check after use found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm1-full/drivers/video/console/fbcon.c.old	2005-03-23 04:53:20.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/video/console/fbcon.c	2005-03-23 04:53:44.000000000 +0100
@@ -906,10 +906,13 @@ static void fbcon_init(struct vc_data *v
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
-	int cap = info->flags;
+	int cap;
 
 	if (info_idx == -1 || info == NULL)
 	    return;
+
+	cap = info->flags;
+
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;

