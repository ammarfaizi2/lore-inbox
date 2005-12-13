Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVLMUBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVLMUBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 15:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbVLMUBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 15:01:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:9130 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751045AbVLMUBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 15:01:11 -0500
Subject: patch usb-remove-unneeded-kmalloc-return-value-casts.patch added to gregkh-2.6 tree
To: jesper.juhl@gmail.com, akpm@osdl.org, gregkh@suse.de,
       linux-kernel@vger.kernel.org, luca.risolia@studio.unibo.it,
       miquel@df.uba.ar
From: <gregkh@suse.de>
Date: Tue, 13 Dec 2005 11:48:50 -0800
In-Reply-To: <200512112034.02734.jesper.juhl@gmail.com>
Message-ID: <1EmG8o-7cN-00@press.kroah.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: USB: Remove unneeded kmalloc() return value casts

to my gregkh-2.6 tree.  Its filename is

     usb-remove-unneeded-kmalloc-return-value-casts.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/

Patches currently in gregkh-2.6 which might be from jesper.juhl@gmail.com are

driver/speakup-kconfig-fix.patch
usb/usb-remove-unneeded-kmalloc-return-value-casts.patch


>From jesper.juhl@gmail.com Sun Dec 11 11:35:33 2005
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: USB: Remove unneeded kmalloc() return value casts
Date: Sun, 11 Dec 2005 20:34:02 +0100
Cc: "Greg Kroah-Hartman" <gregkh@suse.de>, wolfgang@iksw-muees.de, Luca Risolia <luca.risolia@studio.unibo.it>, Cesar Miquel <miquel@df.uba.ar>, Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>
Content-Disposition: inline
Message-Id: <200512112034.02734.jesper.juhl@gmail.com>


Remove kmalloc() return value casts that we don't need from
drivers/usb/*


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/usb/media/usbvideo.c |    2 +-
 drivers/usb/media/w9968cf.c  |    4 ++--
 drivers/usb/misc/auerswald.c |    4 ++--
 drivers/usb/misc/rio500.c    |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

--- gregkh-2.6.orig/drivers/usb/misc/auerswald.c
+++ gregkh-2.6/drivers/usb/misc/auerswald.c
@@ -767,7 +767,7 @@ static int auerbuf_setup (pauerbufctl_t 
 	        memset (bep, 0, sizeof (auerbuf_t));
                 bep->list = bcp;
                 INIT_LIST_HEAD (&bep->buff_list);
-                bep->bufp = (char *) kmalloc (bufsize, GFP_KERNEL);
+                bep->bufp = kmalloc (bufsize, GFP_KERNEL);
                 if (!bep->bufp)
 			goto bl_fail;
                 bep->dr = (struct usb_ctrlrequest *) kmalloc (sizeof (struct usb_ctrlrequest), GFP_KERNEL);
@@ -1123,7 +1123,7 @@ static int auerswald_int_open (pauerswal
                 }
         }
         if (!cp->intbufp) {
-                cp->intbufp = (char *) kmalloc (irqsize, GFP_KERNEL);
+                cp->intbufp = kmalloc (irqsize, GFP_KERNEL);
                 if (!cp->intbufp) {
                         ret = -ENOMEM;
                         goto intoend;
--- gregkh-2.6.orig/drivers/usb/misc/rio500.c
+++ gregkh-2.6/drivers/usb/misc/rio500.c
@@ -465,14 +465,14 @@ static int probe_rio(struct usb_interfac
 
 	rio->rio_dev = dev;
 
-	if (!(rio->obuf = (char *) kmalloc(OBUF_SIZE, GFP_KERNEL))) {
+	if (!(rio->obuf = kmalloc(OBUF_SIZE, GFP_KERNEL))) {
 		err("probe_rio: Not enough memory for the output buffer");
 		usb_deregister_dev(intf, &usb_rio_class);
 		return -ENOMEM;
 	}
 	dbg("probe_rio: obuf address:%p", rio->obuf);
 
-	if (!(rio->ibuf = (char *) kmalloc(IBUF_SIZE, GFP_KERNEL))) {
+	if (!(rio->ibuf = kmalloc(IBUF_SIZE, GFP_KERNEL))) {
 		err("probe_rio: Not enough memory for the input buffer");
 		usb_deregister_dev(intf, &usb_rio_class);
 		kfree(rio->obuf);
--- gregkh-2.6.orig/drivers/usb/media/usbvideo.c
+++ gregkh-2.6/drivers/usb/media/usbvideo.c
@@ -725,7 +725,7 @@ int usbvideo_register(
 		/* Allocate user_data separately because of kmalloc's limits */
 		if (num_extra > 0) {
 			up->user_size = num_cams * num_extra;
-			up->user_data = (char *) kmalloc(up->user_size, GFP_KERNEL);
+			up->user_data = kmalloc(up->user_size, GFP_KERNEL);
 			if (up->user_data == NULL) {
 				err("%s: Failed to allocate user_data (%d. bytes)",
 				    __FUNCTION__, up->user_size);
--- gregkh-2.6.orig/drivers/usb/media/w9968cf.c
+++ gregkh-2.6/drivers/usb/media/w9968cf.c
@@ -3554,7 +3554,7 @@ w9968cf_usb_probe(struct usb_interface* 
 
 
 	/* Allocate 2 bytes of memory for camera control USB transfers */
-	if (!(cam->control_buffer = (u16*)kmalloc(2, GFP_KERNEL))) {
+	if (!(cam->control_buffer = kmalloc(2, GFP_KERNEL))) {
 		DBG(1,"Couldn't allocate memory for camera control transfers")
 		err = -ENOMEM;
 		goto fail;
@@ -3562,7 +3562,7 @@ w9968cf_usb_probe(struct usb_interface* 
 	memset(cam->control_buffer, 0, 2);
 
 	/* Allocate 8 bytes of memory for USB data transfers to the FSB */
-	if (!(cam->data_buffer = (u16*)kmalloc(8, GFP_KERNEL))) {
+	if (!(cam->data_buffer = kmalloc(8, GFP_KERNEL))) {
 		DBG(1, "Couldn't allocate memory for data "
 		       "transfers to the FSB")
 		err = -ENOMEM;
