Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWG3Qmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWG3Qmj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 12:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWG3Qmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 12:42:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:38197 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932368AbWG3Qmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 12:42:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=jjWMZ7OnfaOv32rMDThF12PWoAUPxoBFNZE9mRpRy762R839uoLIFc/yUVKB5a5mapoWa9oc3JoNwmAy/IetpLkaLzfh9TroPjkuK9g4Ba2JedT1S0j6Bmsnf+ijGXl1NikNG5I5wHCCv6evIljgAF0fd3VaaxB7eOQn++vHsIU=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 11/12] making the kernel -Wshadow clean - USB & completion
Date: Sun, 30 Jul 2006 18:43:43 +0200
User-Agent: KMail/1.9.3
References: <200607301830.01659.jesper.juhl@gmail.com>
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607301843.43487.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/usb.h causes a lot of -Wshadow warnings - fix them.

  include/linux/usb.h:901: warning: declaration of 'complete' shadows a global declaration
  include/linux/completion.h:52: warning: shadowed declaration is here
  include/linux/usb.h:932: warning: declaration of 'complete' shadows a global declaration
  include/linux/completion.h:52: warning: shadowed declaration is here
  include/linux/usb.h:967: warning: declaration of 'complete' shadows a global declaration
  include/linux/completion.h:52: warning: shadowed declaration is here


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 include/linux/usb.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

--- linux-2.6.18-rc2-git7-orig/include/linux/usb.h	2006-07-29 14:57:26.000000000 +0200
+++ linux-2.6.18-rc2-git7/include/linux/usb.h	2006-07-30 06:55:24.000000000 +0200
@@ -886,7 +886,7 @@ struct urb
  * @setup_packet: pointer to the setup_packet buffer
  * @transfer_buffer: pointer to the transfer buffer
  * @buffer_length: length of the transfer buffer
- * @complete: pointer to the usb_complete_t function
+ * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  *
  * Initializes a control urb with the proper information needed to submit
@@ -898,7 +898,7 @@ static inline void usb_fill_control_urb 
 					 unsigned char *setup_packet,
 					 void *transfer_buffer,
 					 int buffer_length,
-					 usb_complete_t complete,
+					 usb_complete_t complete_fn,
 					 void *context)
 {
 	spin_lock_init(&urb->lock);
@@ -907,7 +907,7 @@ static inline void usb_fill_control_urb 
 	urb->setup_packet = setup_packet;
 	urb->transfer_buffer = transfer_buffer;
 	urb->transfer_buffer_length = buffer_length;
-	urb->complete = complete;
+	urb->complete = complete_fn;
 	urb->context = context;
 }
 
@@ -918,7 +918,7 @@ static inline void usb_fill_control_urb 
  * @pipe: the endpoint pipe
  * @transfer_buffer: pointer to the transfer buffer
  * @buffer_length: length of the transfer buffer
- * @complete: pointer to the usb_complete_t function
+ * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  *
  * Initializes a bulk urb with the proper information needed to submit it
@@ -929,7 +929,7 @@ static inline void usb_fill_bulk_urb (st
 				      unsigned int pipe,
 				      void *transfer_buffer,
 				      int buffer_length,
-				      usb_complete_t complete,
+				      usb_complete_t complete_fn,
 				      void *context)
 {
 	spin_lock_init(&urb->lock);
@@ -937,7 +937,7 @@ static inline void usb_fill_bulk_urb (st
 	urb->pipe = pipe;
 	urb->transfer_buffer = transfer_buffer;
 	urb->transfer_buffer_length = buffer_length;
-	urb->complete = complete;
+	urb->complete = complete_fn;
 	urb->context = context;
 }
 
@@ -948,7 +948,7 @@ static inline void usb_fill_bulk_urb (st
  * @pipe: the endpoint pipe
  * @transfer_buffer: pointer to the transfer buffer
  * @buffer_length: length of the transfer buffer
- * @complete: pointer to the usb_complete_t function
+ * @complete_fn: pointer to the usb_complete_t function
  * @context: what to set the urb context to.
  * @interval: what to set the urb interval to, encoded like
  *	the endpoint descriptor's bInterval value.
@@ -964,7 +964,7 @@ static inline void usb_fill_int_urb (str
 				     unsigned int pipe,
 				     void *transfer_buffer,
 				     int buffer_length,
-				     usb_complete_t complete,
+				     usb_complete_t complete_fn,
 				     void *context,
 				     int interval)
 {
@@ -973,7 +973,7 @@ static inline void usb_fill_int_urb (str
 	urb->pipe = pipe;
 	urb->transfer_buffer = transfer_buffer;
 	urb->transfer_buffer_length = buffer_length;
-	urb->complete = complete;
+	urb->complete = complete_fn;
 	urb->context = context;
 	if (dev->speed == USB_SPEED_HIGH)
 		urb->interval = 1 << (interval - 1);


