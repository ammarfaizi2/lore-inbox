Return-Path: <linux-kernel-owner+w=401wt.eu-S932531AbWLMRms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWLMRms (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 12:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWLMRms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 12:42:48 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:3117 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932531AbWLMRmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 12:42:47 -0500
Date: Wed, 13 Dec 2006 17:10:36 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
cc: linux-fbdev-devel@lists.sourceforge.net, axp-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19 2/6] tgafb: Fix copying overlapping areas
Message-ID: <Pine.LNX.4.64N.0612131600360.24220@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 The direction of copying in the copyarea functions is selected 
incorrectly, resulting in corruption.  This is a fix.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 It looks like these functions are not used by the console code as image 
blitting is preferred for scrolling and hence the bug has escaped 
unnoticed for so long.  Still it is not an excuse for these functions to 
be wrong.

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-copyarea-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 05:15:28.000000000 +0000
@@ -919,7 +919,7 @@ copyarea_line_8bpp(struct fb_info *info,
 
 	n64 = (height * width) / 64;
 
-	if (dy < sy) {
+	if (sy < dy) {
 		spos = (sy + height) * width;
 		dpos = (dy + height) * width;
 
@@ -967,7 +967,7 @@ copyarea_line_32bpp(struct fb_info *info
 
 	n16 = (height * width) / 16;
 
-	if (dy < sy) {
+	if (sy < dy) {
 		src = tga_fb + (sy + height) * width * 4;
 		dst = tga_fb + (dy + height) * width * 4;
 
