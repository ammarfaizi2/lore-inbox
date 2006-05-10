Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbWEJC4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbWEJC4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 22:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWEJC4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 22:56:16 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:47165 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S932352AbWEJC4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 22:56:16 -0400
Date: Tue, 9 May 2006 19:55:52 -0700
Message-Id: <200605100255.k4A2tqZU031642@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: brad@neruo.com, linux-kernel@vger.kernel.org
Subject: [PATCH -mm] aty128_decode_var gcc 4.1 warning fix 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to be possible to get a random post divider, if aty128_var_to_pll()
doesn't find one in the table .. Needs review .

Fixes the following warning,

drivers/video/aty/aty128fb.c: In function ‘aty128_decode_var’:
drivers/video/aty/aty128fb.c:1516: warning: ‘pll.post_divider’ may be used uninitialized in this function

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/video/aty/aty128fb.c
===================================================================
--- linux-2.6.16.orig/drivers/video/aty/aty128fb.c
+++ linux-2.6.16/drivers/video/aty/aty128fb.c
@@ -1513,7 +1513,7 @@ static int aty128_decode_var(struct fb_v
 {
 	int err;
 	struct aty128_crtc crtc;
-	struct aty128_pll pll;
+	struct aty128_pll pll = { .post_divider = 1 };
 	struct aty128_ddafifo fifo_reg;
 
 	if ((err = aty128_var_to_crtc(var, &crtc, par)))
