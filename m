Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWAQR4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWAQR4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 12:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWAQR4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 12:56:48 -0500
Received: from [81.2.110.250] ([81.2.110.250]:51644 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S932264AbWAQR4r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 12:56:47 -0500
Subject: PATCH: Fix warning on 64bit boxes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 17 Jan 2006 17:56:05 +0000
Message-Id: <1137520565.14135.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We cast an int to a void * which not unreasonably makes gcc suspicious.
We don't actually care what type "type" is so use unsigned long so it
matches pointer length on all platforms.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.16-rc1/drivers/usb/storage/libusual.c linux-2.6.16-rc1/drivers/usb/storage/libusual.c
--- linux.vanilla-2.6.16-rc1/drivers/usb/storage/libusual.c	2006-01-17 15:52:54.000000000 +0000
+++ linux-2.6.16-rc1/drivers/usb/storage/libusual.c	2006-01-17 17:19:01.000000000 +0000
@@ -116,7 +116,7 @@
 static int usu_probe(struct usb_interface *intf,
 			 const struct usb_device_id *id)
 {
-	int type;
+	unsigned long type;
 	int rc;
 	unsigned long flags;
 

