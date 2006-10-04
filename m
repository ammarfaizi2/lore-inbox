Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161258AbWJDPse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161258AbWJDPse (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 11:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWJDPsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 11:48:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:41703 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1161258AbWJDPsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 11:48:33 -0400
X-Authenticated: #704063
Subject: [Patch] Use after free in drivers/usb/input/wacom_sys.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: pingc@wacom.com
Content-Type: text/plain
Date: Wed, 04 Oct 2006 17:48:29 +0200
Message-Id: <1159976909.15934.3.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

the following commit added a use after free
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=3bea733ab21247290bd552dd6a2cd3049af9adef
Found by coverity (cid #1441)

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git21/drivers/usb/input/wacom_sys.c.orig	2006-10-04 17:42:01.000000000 +0200
+++ linux-2.6.18-git21/drivers/usb/input/wacom_sys.c	2006-10-04 17:42:13.000000000 +0200
@@ -285,8 +285,8 @@ static void wacom_disconnect(struct usb_
 		input_unregister_device(wacom->dev);
 		usb_free_urb(wacom->irq);
 		usb_buffer_free(interface_to_usbdev(intf), 10, wacom->wacom_wac->data, wacom->data_dma);
-		kfree(wacom);
 		kfree(wacom->wacom_wac);
+		kfree(wacom);
 	}
 }
 


