Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269220AbUINI7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269220AbUINI7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 04:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269216AbUINI7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 04:59:46 -0400
Received: from pD9FF1BA5.dip.t-dialin.net ([217.255.27.165]:4612 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S269218AbUINI7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 04:59:20 -0400
Message-ID: <4146B2E6.6060608@uni-muenster.de>
Date: Tue, 14 Sep 2004 10:59:18 +0200
From: Borislav Petkov <petkov@uni-muenster.de>
Reply-To: petkov@uni-muenster.de
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] 2.6.9-rc1-mm5 remove usb_unlink_urb in class/cdc-acm.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

next...

Signed-off-by: Borislav Petkov <petkov@uni-muenster.de>

--- linux-2.6.9-rc1-mm/drivers/usb/class/cdc-acm.c.orig 2004-09-14 10:56:21.000000000 +0200
+++ linux-2.6.9-rc1-mm/drivers/usb/class/cdc-acm.c      2004-09-14 10:57:48.000000000 +0200
@@ -306,9 +306,9 @@ done:
         return 0;

  full_bailout:
-       usb_unlink_urb(acm->readurb);
+       usb_kill_urb(acm->readurb);
  bail_out_and_unlink:
-       usb_unlink_urb(acm->ctrlurb);
+       usb_kill_urb(acm->ctrlurb);
  bail_out:
         up(&open_sem);
         return -EIO;
@@ -325,9 +325,9 @@ static void acm_tty_close(struct tty_str
         if (!--acm->used) {
                 if (acm->dev) {
                         acm_set_control(acm, acm->ctrlout = 0);
-                       usb_unlink_urb(acm->ctrlurb);
-                       usb_unlink_urb(acm->writeurb);
-                       usb_unlink_urb(acm->readurb);
+                       usb_kill_urb(acm->ctrlurb);
+                       usb_kill_urb(acm->writeurb);
+                       usb_kill_urb(acm->readurb);
                 } else {
                         tty_unregister_device(acm_tty_driver, acm->minor);
                         acm_table[acm->minor] = NULL;
@@ -767,9 +767,9 @@ static void acm_disconnect(struct usb_in
         acm->dev = NULL;
         usb_set_intfdata (intf, NULL);

-       usb_unlink_urb(acm->ctrlurb);
-       usb_unlink_urb(acm->readurb);
-       usb_unlink_urb(acm->writeurb);
+       usb_kill_urb(acm->ctrlurb);
+       usb_kill_urb(acm->readurb);
+       usb_kill_urb(acm->writeurb);

         flush_scheduled_work(); /* wait for acm_softint */


