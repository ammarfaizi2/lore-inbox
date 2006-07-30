Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964793AbWG3Xn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWG3Xn4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 19:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbWG3Xnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 19:43:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49930 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964793AbWG3Xnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 19:43:55 -0400
Date: Mon, 31 Jul 2006 01:43:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: [2.6 patch] fix the USB_GADGET_DUMMY_HCD dependencies
Message-ID: <20060730234353.GB3658@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If USB=m, USB_GADGET=y, the option USB_GADGET_DUMMY_HCD mustn't be 
offered since selecting it results in a compile error.

This patch fixes kernel Bugzilla #6534 reported by Toralf Förster.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc2-mm1-full/drivers/usb/gadget/Kconfig.old	2006-07-29 03:58:25.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/drivers/usb/gadget/Kconfig	2006-07-29 03:59:15.000000000 +0200
@@ -207,7 +207,7 @@
 
 config USB_GADGET_DUMMY_HCD
 	boolean "Dummy HCD (DEVELOPMENT)"
-	depends on USB && EXPERIMENTAL
+	depends on (USB=y || (USB=m && USB_GADGET=m)) && EXPERIMENTAL
 	select USB_GADGET_DUALSPEED
 	help
 	  This host controller driver emulates USB, looping all data transfer

