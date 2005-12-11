Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVLKTda@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVLKTda (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVLKTda
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:33:30 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:61739 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVLKTd3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:33:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=DPDdNTiY+SKefdqpqe202mnptlEC1AylfIPZDgCwyLle0eY9P1FeTIMm2KbxMEACbwSTTz+LTErvfQb/Psz2x7hfusv6tQJZ1F1CHDWGwiwGdzuDsqVUuF6S49A9TpXBmeOOsq+iAGrhqCZUbbdKSeKcc30K7pouQMyC1JSID6A=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] drivers/usb: Remove unneeded kmalloc() return value casts
Date: Sun, 11 Dec 2005 20:34:02 +0100
User-Agent: KMail/1.9
Cc: "Greg Kroah-Hartman" <gregkh@suse.de>, wolfgang@iksw-muees.de,
       Luca Risolia <luca.risolia@studio.unibo.it>,
       Cesar Miquel <miquel@df.uba.ar>, Andrew Morton <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512112034.02734.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Remove kmalloc() return value casts that we don't need from
drivers/usb/*


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 drivers/usb/media/usbvideo.c |    2 +-
 drivers/usb/media/w9968cf.c  |    4 ++--
 drivers/usb/misc/auerswald.c |    4 ++--
 drivers/usb/misc/rio500.c    |    4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

--- linux-2.6.15-rc5-git1-orig/drivers/usb/misc/auerswald.c	2005-12-04 18:48:23.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/usb/misc/auerswald.c	2005-12-11 20:03:54.000000000 +0100
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
--- linux-2.6.15-rc5-git1-orig/drivers/usb/misc/rio500.c	2005-12-04 18:48:23.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/usb/misc/rio500.c	2005-12-11 20:07:12.000000000 +0100
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
--- linux-2.6.15-rc5-git1-orig/drivers/usb/media/usbvideo.c	2005-10-28 02:02:08.000000000 +0200
+++ linux-2.6.15-rc5-git1/drivers/usb/media/usbvideo.c	2005-12-11 20:08:22.000000000 +0100
@@ -725,7 +725,7 @@ int usbvideo_register(
 		/* Allocate user_data separately because of kmalloc's limits */
 		if (num_extra > 0) {
 			up->user_size = num_cams * num_extra;
-			up->user_data = (char *) kmalloc(up->user_size, GFP_KERNEL);
+			up->user_data = kmalloc(up->user_size, GFP_KERNEL);
 			if (up->user_data == NULL) {
 				err("%s: Failed to allocate user_data (%d. bytes)",
 				    __FUNCTION__, up->user_size);
--- linux-2.6.15-rc5-git1-orig/drivers/usb/media/w9968cf.c	2005-12-04 18:48:22.000000000 +0100
+++ linux-2.6.15-rc5-git1/drivers/usb/media/w9968cf.c	2005-12-11 20:09:44.000000000 +0100
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



