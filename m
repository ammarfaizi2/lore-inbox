Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261829AbULGPUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbULGPUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 10:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbULGPUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 10:20:13 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:52973 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S261829AbULGPUG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 10:20:06 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 7 Dec 2004 16:03:52 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [patch] msp3400 quick fix
Message-ID: <20041207150352.GA23945@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The new "simpler" opmode added by the recent merge from ivtv breaks
msp3400 support for other tv cards.  Not figured yet why.

This patch disables the "simpler" mode by default (can still be enabled
by insmod option) as quick fix for 2.6.10.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/media/video/msp3400.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -u linux-2.6.10/drivers/media/video/msp3400.c linux/drivers/media/video/msp3400.c
--- linux-2.6.10/drivers/media/video/msp3400.c	2004-12-07 14:16:53.000000000 +0100
+++ linux/drivers/media/video/msp3400.c	2004-12-07 15:57:22.268877333 +0100
@@ -1503,9 +1503,12 @@
 
 	msp->opmode = opmode;
 	if (OPMODE_AUTO == msp->opmode) {
+#if 0 /* seems to work for ivtv only, disable by default for now ... */
 		if (HAVE_SIMPLER(msp))
 			msp->opmode = OPMODE_SIMPLER;
-		else if (HAVE_SIMPLE(msp))
+		else
+#endif
+		if (HAVE_SIMPLE(msp))
 			msp->opmode = OPMODE_SIMPLE;
 		else
 			msp->opmode = OPMODE_MANUAL;

-- 
#define printk(args...) fprintf(stderr, ## args)
