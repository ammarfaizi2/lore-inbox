Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUAWGpN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUAWGpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:45:06 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26322 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266526AbUAWGgq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:46 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org, benh@kernel.crashing.org
From: davej@redhat.com
Subject: logic error in radeonfb.
Message-Id: <E1Ajuub-0000xr-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like another instance of a ! in the wrong place.

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/video/radeonfb.c linux-2.5/drivers/video/radeonfb.c
--- bk-linus/drivers/video/radeonfb.c	2004-01-21 15:58:42.000000000 +0000
+++ linux-2.5/drivers/video/radeonfb.c	2004-01-21 17:48:54.000000000 +0000
@@ -2319,7 +2319,7 @@ static int radeon_set_backlight_enable(i
 	lvds_gen_cntl |= (LVDS_BL_MOD_EN | LVDS_BLON);
 	if (on && (level > BACKLIGHT_OFF)) {
 		lvds_gen_cntl |= LVDS_DIGON;
-		if (!lvds_gen_cntl & LVDS_ON) {
+		if (!(lvds_gen_cntl & LVDS_ON)) {
 			lvds_gen_cntl &= ~LVDS_BLON;
 			OUTREG(LVDS_GEN_CNTL, lvds_gen_cntl);
 			(void)INREG(LVDS_GEN_CNTL);
