Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTDQFyB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbTDQFxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:53:15 -0400
Received: from granite.he.net ([216.218.226.66]:56848 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263087AbTDQFvD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:51:03 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10505595054090@kroah.com>
Subject: Re: [PATCH] More USB fixes for 2.5.67
In-Reply-To: <10505595051616@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 16 Apr 2003 23:05:05 -0700
Content-Transfer-Encoding: 7BIT
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1067, 2003/04/14 22:12:51-07:00, greg@kroah.com

[PATCH] USB: keyspan: fixed up might_sleep() problems on device close.


diff -Nru a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
--- a/drivers/usb/serial/keyspan.c	Wed Apr 16 10:48:23 2003
+++ b/drivers/usb/serial/keyspan.c	Wed Apr 16 10:48:23 2003
@@ -1534,7 +1534,7 @@
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	this_urb->dev = serial->dev;
-	if ((err = usb_submit_urb(this_urb, GFP_KERNEL)) != 0) {
+	if ((err = usb_submit_urb(this_urb, GFP_ATOMIC)) != 0) {
 		dbg("%s - usb_submit_urb(setup) failed (%d)", __FUNCTION__, err);
 	}
 #if 0
@@ -1659,7 +1659,7 @@
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	this_urb->dev = serial->dev;
-	if ((err = usb_submit_urb(this_urb, GFP_KERNEL)) != 0) {
+	if ((err = usb_submit_urb(this_urb, GFP_ATOMIC)) != 0) {
 		dbg("%s - usb_submit_urb(setup) failed", __FUNCTION__);
 	}
 #if 0
@@ -1824,7 +1824,7 @@
 	this_urb->transfer_buffer_length = sizeof(msg);
 
 	this_urb->dev = serial->dev;
-	if ((err = usb_submit_urb(this_urb, GFP_KERNEL)) != 0) {
+	if ((err = usb_submit_urb(this_urb, GFP_ATOMIC)) != 0) {
 		dbg("%s - usb_submit_urb(setup) failed (%d)", __FUNCTION__, err);
 	}
 #if 0

