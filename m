Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbUBYLzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 06:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbUBYLzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 06:55:38 -0500
Received: from gruby.cs.net.pl ([62.233.142.99]:49929 "EHLO gruby.cs.net.pl")
	by vger.kernel.org with ESMTP id S261275AbUBYLzh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 06:55:37 -0500
Date: Wed, 25 Feb 2004 12:55:31 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] don't use floating point in tdfxfb
Message-ID: <20040225115530.GF16814@gruby.cs.net.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch removes using of floating point operations in tdfxfb - they
are really not needed here (these consts are used only in substitutions
and comparisons with integers) are cause unresolved symbols on some
archs - e.g. on alpha:

*** Warning: "__ltdf2" [drivers/video/tdfxfb.ko] undefined!
*** Warning: "__adddf3" [drivers/video/tdfxfb.ko] undefined!
*** Warning: "__floatsidf" [drivers/video/tdfxfb.ko] undefined!


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Team        http://www.pld-linux.org/

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-nofloat.patch"

--- linux-2.6.3/drivers/video/tdfxfb.c.orig	2004-02-24 11:08:06.000000000 +0100
+++ linux-2.6.3/drivers/video/tdfxfb.c	2004-02-25 12:33:09.000000000 +0100
@@ -86,9 +86,9 @@
 #define DPRINTK(a,b...)
 #endif 
 
-#define BANSHEE_MAX_PIXCLOCK 270000.0
-#define VOODOO3_MAX_PIXCLOCK 300000.0
-#define VOODOO5_MAX_PIXCLOCK 350000.0
+#define BANSHEE_MAX_PIXCLOCK 270000
+#define VOODOO3_MAX_PIXCLOCK 300000
+#define VOODOO5_MAX_PIXCLOCK 350000
 
 static struct fb_fix_screeninfo tdfx_fix __initdata = {
 	.id =		"3Dfx",

--vtzGhvizbBRQ85DL--
