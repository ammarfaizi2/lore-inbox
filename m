Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264292AbTLKBcm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 20:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264332AbTLKBbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 20:31:25 -0500
Received: from mail.kroah.org ([65.200.24.183]:62159 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264333AbTLKBaX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 20:30:23 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10711061462803@kroah.com>
Subject: Re: [PATCH] USB Fixes for 2.6.0-test11
In-Reply-To: <10711061462834@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 10 Dec 2003 17:29:06 -0800
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1521, 2003/12/09 10:00:49-08:00, oliver@neukum.org

[PATCH] USB: fix sleping in interrupt bug in auerswald driver

this fixes two instances of GFP_KERNEL from completion handlers.


 drivers/usb/misc/auerswald.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/usb/misc/auerswald.c b/drivers/usb/misc/auerswald.c
--- a/drivers/usb/misc/auerswald.c	Wed Dec 10 16:47:26 2003
+++ b/drivers/usb/misc/auerswald.c	Wed Dec 10 16:47:26 2003
@@ -324,7 +324,7 @@
                 urb    = acep->urbp;
                 dbg ("auerchain_complete: submitting next urb from chain");
 		urb->status = 0;	/* needed! */
-		result = usb_submit_urb(urb, GFP_KERNEL);
+		result = usb_submit_urb(urb, GFP_ATOMIC);
 
                 /* check for submit errors */
                 if (result) {
@@ -402,7 +402,7 @@
         if (acep) {
                 dbg("submitting urb immediate");
 		urb->status = 0;	/* needed! */
-                result = usb_submit_urb(urb, GFP_KERNEL);
+                result = usb_submit_urb(urb, GFP_ATOMIC);
                 /* check for submit errors */
                 if (result) {
                         urb->status = result;

