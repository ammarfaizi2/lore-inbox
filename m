Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265269AbUBALVv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 06:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUBALVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 06:21:51 -0500
Received: from fed1mtao06.cox.net ([68.6.19.125]:46781 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S265269AbUBALVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 06:21:49 -0500
To: linux-kernel@vger.kernel.org
cc: trivial@rustcorp.com.au
Subject: [TRIVIAL] fix compilation warnings in
 2.6.2-rc3/drivers/video/neofb.c
From: Junio C Hamano <junkio@cox.net>
Date: Sun, 01 Feb 2004 03:21:47 -0800
Message-ID: <7v7jz79h9w.fsf@assigned-by-dhcp.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling neofb.c without MTRR results in two "unused variable"
warnings.

--- 2.6.2-rc3/drivers/video/neofb.c	2003-11-26 12:44:30 -0800
+++ 2.6.2-rc3/drivers/video/neofb.c	2004-02-01 03:05:10 -0800
@@ -1649,8 +1649,6 @@
 static int __devinit neo_map_video(struct fb_info *info,
 				   struct pci_dev *dev, int video_len)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
-
 	DBG("neo_map_video");
 
 	info->fix.smem_start = pci_resource_start(dev, 0);
@@ -1674,7 +1672,7 @@
 		       info->screen_base);
 
 #ifdef CONFIG_MTRR
-	par->mtrr =
+	((struct neofb_par *)(info->par))->mtrr =
 	    mtrr_add(info->fix.smem_start, pci_resource_len(dev, 0),
 		     MTRR_TYPE_WRCOMB, 1);
 #endif
@@ -1686,12 +1684,12 @@
 
 static void __devinit neo_unmap_video(struct fb_info *info)
 {
-	struct neofb_par *par = (struct neofb_par *) info->par;
 
 	DBG("neo_unmap_video");
 
 	if (info->screen_base) {
 #ifdef CONFIG_MTRR
+		struct neofb_par *par = (struct neofb_par *) info->par;
 		mtrr_del(par->mtrr, info->fix.smem_start,
 			 info->fix.smem_len);
 #endif

