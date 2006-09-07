Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751109AbWIGT0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751109AbWIGT0n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbWIGT0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 15:26:40 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:5540 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751867AbWIGT0g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 15:26:36 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: PATCH] usbtouchscreen: fix ITM data reading
Date: Thu, 7 Sep 2006 21:25:51 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-usb" <linux-usb-devel@lists.sourceforge.net>,
       "Kai Lindholm" <megantti@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609072125.53404.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 1378;
	Body=5 Fuz1=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

before 2.6.19, please :)

[PATCH] usbtouchscreen: fix ITM data reading

From: Kai Lindhom <megantti@gmail.com>
Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/drivers/usb/input/usbtouchscreen.c b/drivers/usb/input/usbtouchscreen.c
index 3b175aa..a338bf4 100644
--- a/drivers/usb/input/usbtouchscreen.c
+++ b/drivers/usb/input/usbtouchscreen.c
@@ -286,7 +286,7 @@ #ifdef CONFIG_USB_TOUCHSCREEN_ITM
 static int itm_read_data(unsigned char *pkt, int *x, int *y, int *touch, int *press)
 {
 	*x = ((pkt[0] & 0x1F) << 7) | (pkt[3] & 0x7F);
-	*x = ((pkt[1] & 0x1F) << 7) | (pkt[4] & 0x7F);
+	*y = ((pkt[1] & 0x1F) << 7) | (pkt[4] & 0x7F);
 	*press = ((pkt[2] & 0x1F) << 7) | (pkt[5] & 0x7F);
 	*touch = ~pkt[7] & 0x20;
 
