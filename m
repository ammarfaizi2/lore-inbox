Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264318AbTLKBqK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264325AbTLKBbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:56527 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264327AbTLKBaL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:11 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061463948@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061451940@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:06 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1519, 2003/12/09 09:35:37-08:00, mdharm-usb@one-eyed-alien.net

[PATCH] USB storage: fix for jumpshot and datafab devices

This patch fixes some obvious errors in the jumpshot and datafab drivers.

This should close out Bugzilla bug #1408

> Date: Mon, 1 Dec 2003 12:14:53 -0500 (EST)
> From: Alan Stern <stern@rowland.harvard.edu>
> Subject: Patch from Eduard Hasenleithner
> To: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
> cc: USB Storage List <usb-storage@one-eyed-alien.net>
>
> Matt:
>
> Did you see this patch?  It was posted to the usb-development mailing list
> about a week ago, before I started making all my changes.  It is clearly
> correct and necessary.
>
> Alan Stern


 drivers/usb/storage/datafab.c  |    2 +-
 drivers/usb/storage/jumpshot.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/storage/datafab.c b/drivers/usb/storage/datafab.c
--- a/drivers/usb/storage/datafab.c	Wed Dec 10 16:47:42 2003
+++ b/drivers/usb/storage/datafab.c	Wed Dec 10 16:47:42 2003
@@ -387,7 +387,7 @@
 
 	// we'll go ahead and extract the media capacity while we're here...
 	//
-	rc = datafab_bulk_read(us, reply, sizeof(reply));
+	rc = datafab_bulk_read(us, reply, 512);
 	if (rc == USB_STOR_XFER_GOOD) {
 		// capacity is at word offset 57-58
 		//
diff -Nru a/drivers/usb/storage/jumpshot.c b/drivers/usb/storage/jumpshot.c
--- a/drivers/usb/storage/jumpshot.c	Wed Dec 10 16:47:42 2003
+++ b/drivers/usb/storage/jumpshot.c	Wed Dec 10 16:47:42 2003
@@ -317,7 +317,7 @@
 	}
 
 	// read the reply
-	rc = jumpshot_bulk_read(us, reply, sizeof(reply));
+	rc = jumpshot_bulk_read(us, reply, 512);
 	if (rc != USB_STOR_XFER_GOOD) {
 		rc = USB_STOR_TRANSPORT_ERROR;
 		goto leave;

