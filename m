Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUITNBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUITNBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 09:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUITNBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 09:01:36 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:31661 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S266486AbUITNBQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 09:01:16 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 20 Sep 2004 14:45:11 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Andrew Morton <akpm@osdl.org>, Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch] bttv bugfix
Message-ID: <20040920124511.GA7992@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

This fixes a initialization order bug in bttv, also known as "dark red
image bug".  Please apply,

  Gerd

diff -u linux-2.6.9-rc2/drivers/media/video/bttv-driver.c linux/drivers/media/video/bttv-driver.c
--- linux-2.6.9-rc2/drivers/media/video/bttv-driver.c	2004-09-17 14:56:37.000000000 +0200
+++ linux/drivers/media/video/bttv-driver.c	2004-09-20 14:41:47.563654821 +0200
@@ -1052,11 +1052,6 @@
 	btwrite(whitecrush_upper, BT848_WC_UP);
 	btwrite(whitecrush_lower, BT848_WC_DOWN);
 
-	bt848_bright(btv,   btv->bright);
-	bt848_hue(btv,      btv->hue);
-	bt848_contrast(btv, btv->contrast);
-	bt848_sat(btv,      btv->saturation);
-
 	if (btv->opt_lumafilter) {
 		btwrite(0, BT848_E_CONTROL);
 		btwrite(0, BT848_O_CONTROL);
@@ -1065,6 +1060,11 @@
 		btwrite(BT848_CONTROL_LDEC, BT848_O_CONTROL);
 	}
 
+	bt848_bright(btv,   btv->bright);
+	bt848_hue(btv,      btv->hue);
+	bt848_contrast(btv, btv->contrast);
+	bt848_sat(btv,      btv->saturation);
+	
         /* interrupt */
 	init_irqreg(btv);
 }

-- 
return -ENOSIG;
