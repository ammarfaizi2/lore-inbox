Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbTEMVcY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263547AbTEMVcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:32:24 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:21260 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263540AbTEMVcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:32:23 -0400
Date: Tue, 13 May 2003 22:45:06 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Framebuffer fix 1
Message-ID: <Pine.LNX.4.44.0305132242030.12672-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This removed EDID support for VESA. The EDID code needs more developement
which can be done on the side. 

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1078  -> 1.1079 
#	drivers/video/vesafb.c	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1079
# [VESA FBDEV] Removed the EDID code. The results where mixed. It worked for some but not for others.
# --------------------------------------------
#
diff -Nru a/drivers/video/vesafb.c b/drivers/video/vesafb.c
--- a/drivers/video/vesafb.c	Mon May 12 14:26:05 2003
+++ b/drivers/video/vesafb.c	Mon May 12 14:26:05 2003
@@ -215,7 +215,6 @@
 int __init vesafb_init(void)
 {
 	int video_cmap_len;
-	char *edid = 0;
 	int i;
 
 	if (screen_info.orig_video_isVGA != VIDEO_TYPE_VLFB)
@@ -300,18 +299,10 @@
 		ypan = 0;
 	}
 
-#ifdef __i386__
-	edid = get_EDID_from_BIOS(0);
-	if (edid)
-		parse_edid(edid, &vesafb_defined);	
-	else		
-#endif
-	{	
-		/* some dummy values for timing to make fbset happy */
-		vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
-		vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
-		vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
-	}
+	/* some dummy values for timing to make fbset happy */
+	vesafb_defined.pixclock     = 10000000 / vesafb_defined.xres * 1000 / vesafb_defined.yres;
+	vesafb_defined.left_margin  = (vesafb_defined.xres / 8) & 0xf8;
+	vesafb_defined.hsync_len    = (vesafb_defined.xres / 8) & 0xf8;
 	
 	if (vesafb_defined.bits_per_pixel > 8) {
 		vesafb_defined.red.offset    = screen_info.red_pos;

