Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261362AbVCYBI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbVCYBI6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 20:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVCYBIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 20:08:40 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:25361 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261362AbVCYBGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 20:06:30 -0500
Date: Fri, 25 Mar 2005 02:06:29 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.ne, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/misc/usbtest.c: fix a NULL dereference
Message-ID: <20050325010629.GN3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL dereference found by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-rc1-mm1-full/drivers/usb/misc/usbtest.c.old	2005-03-24 04:33:34.000000000 +0100
+++ linux-2.6.12-rc1-mm1-full/drivers/usb/misc/usbtest.c	2005-03-24 04:33:59.000000000 +0100
@@ -851,7 +851,7 @@
 	 */
 	urb = kmalloc (param->sglen * sizeof (struct urb *), SLAB_KERNEL);
 	if (!urb)
-		goto cleanup;
+		return -ENOMEM;
 	memset (urb, 0, param->sglen * sizeof (struct urb *));
 	for (i = 0; i < param->sglen; i++) {
 		int			pipe = usb_rcvctrlpipe (udev, 0);

