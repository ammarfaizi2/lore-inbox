Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTEMV3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTEMV3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:29:14 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:18188 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263522AbTEMV3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:29:10 -0400
Date: Tue, 13 May 2003 22:41:52 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Console bug fix.
Message-ID: <Pine.LNX.4.44.0305132237570.12672-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The font size needs to be set for all terminals. This patch fixes that. 
Please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1077  -> 1.1078 
#	drivers/char/vt_ioctl.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/05/12	jsimmons@maxwell.earthlink.net	1.1078
# [CONSOLE] This was the bug that was causing dual head (vga and mda) to lock up.
# --------------------------------------------
#
diff -Nru a/drivers/char/vt_ioctl.c b/drivers/char/vt_ioctl.c
--- a/drivers/char/vt_ioctl.c	Mon May 12 14:12:47 2003
+++ b/drivers/char/vt_ioctl.c	Mon May 12 14:12:47 2003
@@ -869,13 +869,13 @@
 		if (clin > 32)
 			return -EINVAL;
 		    
-		if (vlin)
-			vc->vc_scan_lines = vlin;
-		if (clin)
-			vc->vc_font.height = clin;
-	
-		for (i = 0; i < MAX_NR_CONSOLES; i++)
+		for (i = 0; i < MAX_NR_CONSOLES; i++) {
+			if (vlin)
+				vc_cons[i].d->vc_scan_lines = vlin;
+			if (clin)
+				vc_cons[i].d->vc_font.height = clin;
 			vc_resize(i, cc, ll);
+		}
   		return 0;
 	}
 

