Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbTLFB34 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 20:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbTLFB34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 20:29:56 -0500
Received: from dm51.neoplus.adsl.tpnet.pl ([80.54.235.51]:12548 "EHLO
	satan.blackhosts") by vger.kernel.org with ESMTP id S264905AbTLFB3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 20:29:55 -0500
Date: Sat, 6 Dec 2003 02:34:25 +0100
From: Jakub Bogusz <qboosh@pld-linux.org>
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] fix for fbcon margin colour in 2.6.0-test*
Message-ID: <20031206013425.GB3914@satan.blackhosts>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xXmbgvnjoT4axfJE"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Organization: PLD Linux Distribution
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I posted this patch to fbdev-devel some time ago, but haven't got any
opinions there.
It sets fbcon margin colour to sane, black value, instead of changing
from time to time depending on background of last erase character
(more details inside).
It was tested by me on tdfxfb and one other person on matroxfb.


-- 
Jakub Bogusz    http://cyber.cs.net.pl/~qboosh/
PLD Linux       http://www.pld-linux.org/

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-fbcon-margins.patch"

This fixes "margin colour" (colour used to clear margins - e.g. a half of line
at the bottom of 100x37 console on 800x600 framebuffer).

I don't know what was the intention behind using attr_bgcol_ec() here, but it
caused using of background colour of last erase character to clear margins -
which definitely isn't what we want...
This patch changes margin colour to black (or colour 0 in palette modes).

	-- Jakub Bogusz <qboosh@pld-linux.org>

--- linux-2.6.0-test2/drivers/video/console/fbcon.c.orig	2003-07-14 05:36:32.000000000 +0200
+++ linux-2.6.0-test2/drivers/video/console/fbcon.c	2003-07-31 00:53:26.000000000 +0200
@@ -502,7 +502,7 @@
 	unsigned int bs = info->var.yres - bh;
 	struct fb_fillrect region;
 
-	region.color = attr_bgcol_ec(bgshift, vc);
+	region.color = 0;
 	region.rop = ROP_COPY;
 
 	if (rw && !bottom_only) {

--xXmbgvnjoT4axfJE--
