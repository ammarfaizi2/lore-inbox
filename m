Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUCQXaQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 18:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUCQXaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 18:30:15 -0500
Received: from aea152.neoplus.adsl.tpnet.pl ([83.31.137.152]:5124 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S262176AbUCQX34
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 18:29:56 -0500
Date: Thu, 18 Mar 2004 00:36:38 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6][RESEND] tdfxfb fillrect fix for truecolor modes
Message-ID: <20040317233638.GC3510@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tdfxfb fillrect (used e.g. for "clear" terminal commands) uses wrong
colour in 16/32-bpp modes - attached patch fixes it.

This change has been already applied into fbdev-2.5 tree, applies
cleanly to Linux 2.6.4 tree - so can be easily merged as small part
of integration.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/

--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-tdfxfb-fillrect.patch"

This fixes background used for "clear" terminal commands (^[[J, ^[[K etc.)
in 16/24/32bpp modes.

This patch has been already integrated into fbdev-2.5 tree.

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.0-test2/drivers/video/tdfxfb.c.orig	2003-07-30 08:31:57.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/tdfxfb.c	2003-07-31 00:44:26.000000000 +0200
@@ -890,7 +890,11 @@
 
 	banshee_make_room(par, 5);
 	tdfx_outl(par,	DSTFORMAT, fmt);
-	tdfx_outl(par,	COLORFORE, rect->color);
+	if (info->fix.visual == FB_VISUAL_PSEUDOCOLOR) {
+		tdfx_outl(par,	COLORFORE, rect->color);
+	} else { /* FB_VISUAL_TRUECOLOR */
+		tdfx_outl(par, COLORFORE, ((u32*)(info->pseudo_palette))[rect->color]);
+	}
 	tdfx_outl(par,	COMMAND_2D, COMMAND_2D_FILLRECT | (tdfx_rop << 24));
 	tdfx_outl(par,	DSTSIZE,    rect->width | (rect->height << 16));
 	tdfx_outl(par,	LAUNCH_2D,  rect->dx | (rect->dy << 16));

--ZoaI/ZTpAVc4A5k6--
