Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUAWGiw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbUAWGgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:36:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:17618 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266514AbUAWGgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:40 -0500
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
From: davej@redhat.com
Subject: logic error in aty128fb
Message-Id: <E1Ajuub-0000xm-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Negate the expression not the register seems more sensible?

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/video/aty/aty128fb.c linux-2.5/drivers/video/aty/aty128fb.c
--- bk-linus/drivers/video/aty/aty128fb.c	2003-10-15 05:00:42.000000000 +0100
+++ linux-2.5/drivers/video/aty/aty128fb.c	2004-01-14 07:07:10.000000000 +0000
@@ -2102,7 +2102,7 @@ aty128_set_backlight_enable(int on, int 
 	reg |= LVDS_BL_MOD_EN | LVDS_BLON;
 	if (on && level > BACKLIGHT_OFF) {
 		reg |= LVDS_DIGION;
-		if (!reg & LVDS_ON) {
+		if (!(reg & LVDS_ON)) {
 			reg &= ~LVDS_BLON;
 			aty_st_le32(LVDS_GEN_CNTL, reg);
 			(void)aty_ld_le32(LVDS_GEN_CNTL);
