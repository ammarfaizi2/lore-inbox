Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266555AbUIMSMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbUIMSMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266517AbUIMSMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:12:47 -0400
Received: from p5089FFAD.dip.t-dialin.net ([80.137.255.173]:6660 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S266555AbUIMSMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:12:32 -0400
Message-ID: <4145E301.2000209@uni-muenster.de>
Date: Mon, 13 Sep 2004 20:12:17 +0200
From: Borislav Petkov <petkov@uni-muenster.de>
Reply-To: petkov@uni-muenster.de
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH]  2.6.9-rc1-mm5 remove usb_unlink_urb calls in bluetty.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
hope this time the tabs remain intact. Here's another one:

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- linux-2.6.9-rc1-mm/drivers/usb/class/bluetty.c.orig 2004-09-13 20:03:23.000000000 +0200
+++ linux-2.6.9-rc1-mm/drivers/usb/class/bluetty.c      2004-09-13 20:04:56.000000000 +0200
@@ -426,8 +426,8 @@ static void bluetooth_close (struct tty_
                 bluetooth->open_count = 0;

                 /* shutdown any in-flight urbs that we know about */
-               usb_unlink_urb (bluetooth->read_urb);
-               usb_unlink_urb (bluetooth->interrupt_in_urb);
+               usb_kill_urb (bluetooth->read_urb);
+               usb_kill_urb (bluetooth->interrupt_in_urb);
         }
         up(&bluetooth->lock);
  }
@@ -705,7 +705,7 @@ void btusb_disable_bulk_read(struct tty_
         }

         if ((bluetooth->read_urb) && (bluetooth->read_urb->actual_length))
-               usb_unlink_urb(bluetooth->read_urb);
+               usb_kill_urb(bluetooth->read_urb);
  }
  #endif

@@ -1187,14 +1187,14 @@ static void usb_bluetooth_disconnect(str
                 bluetooth->open_count = 0;

                 if (bluetooth->read_urb) {
-                       usb_unlink_urb (bluetooth->read_urb);
+                       usb_kill_urb (bluetooth->read_urb);
                         usb_free_urb (bluetooth->read_urb);
                 }
                 if (bluetooth->bulk_in_buffer)
                         kfree (bluetooth->bulk_in_buffer);

                 if (bluetooth->interrupt_in_urb) {
-                       usb_unlink_urb (bluetooth->interrupt_in_urb);
+                       usb_kill_urb (bluetooth->interrupt_in_urb);
                         usb_free_urb (bluetooth->interrupt_in_urb);
                 }
                 if (bluetooth->interrupt_in_buffer)
@@ -1204,7 +1204,7 @@ static void usb_bluetooth_disconnect(str

                 for (i = 0; i < NUM_CONTROL_URBS; ++i) {
                         if (bluetooth->control_urb_pool[i]) {
-                               usb_unlink_urb (bluetooth->control_urb_pool[i]);
+                               usb_kill_urb (bluetooth->control_urb_pool[i]);
                                 if (bluetooth->control_urb_pool[i]->transfer_buffer)
                                         kfree (bluetooth->control_urb_pool[i]->transfer_buffer);
                                 usb_free_urb (bluetooth->control_urb_pool[i]);

