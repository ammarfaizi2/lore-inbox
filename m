Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVJ2Kth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVJ2Kth (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 06:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVJ2Kth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 06:49:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:9948 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750758AbVJ2Kth
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 06:49:37 -0400
Date: Sat, 29 Oct 2005 11:49:33 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Dmitry Torokhov <dtor@mail.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] amikbd fix
Message-ID: <20051029104933.GF7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	it's input_allocate_device(), not input_dev_allocate()...
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-base/drivers/input/keyboard/amikbd.c current/drivers/input/keyboard/amikbd.c
--- RC14-base/drivers/input/keyboard/amikbd.c	2005-10-28 22:35:58.000000000 -0400
+++ current/drivers/input/keyboard/amikbd.c	2005-10-29 06:01:15.000000000 -0400
@@ -199,7 +199,7 @@
 	if (!request_mem_region(CIAA_PHYSADDR-1+0xb00, 0x100, "amikeyb"))
 		return -EBUSY;
 
-	amikbd_dev = input_dev_allocate();
+	amikbd_dev = input_allocate_device();
 	if (!amikbd_dev) {
 		printk(KERN_ERR "amikbd: not enough memory for input device\n");
 		release_mem_region(CIAA_PHYSADDR - 1 + 0xb00, 0x100);
