Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVAHK27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVAHK27 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 05:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261855AbVAHJT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:19:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:34949 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261841AbVAHFsJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:48:09 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <11051632633790@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:44 -0800
Message-Id: <11051632643263@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1938.446.4, 2004/12/15 14:13:33-08:00, greg@kroah.com

[PATCH] USB: fix sparse and compiler warnings in ti_usb_3410_5052.c

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/usb/serial/ti_usb_3410_5052.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


diff -Nru a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
--- a/drivers/usb/serial/ti_usb_3410_5052.c	2005-01-07 15:51:02 -08:00
+++ b/drivers/usb/serial/ti_usb_3410_5052.c	2005-01-07 15:51:02 -08:00
@@ -179,7 +179,7 @@
 static int ti_get_serial_info(struct ti_port *tport,
 	struct serial_struct __user *ret_arg);
 static int ti_set_serial_info(struct ti_port *tport,
-	struct serial_struct *new_arg);
+	struct serial_struct __user *new_arg);
 static void ti_handle_new_msr(struct ti_port *tport, __u8 msr);
 
 static void ti_drain(struct ti_port *tport, unsigned long timeout, int flush);
@@ -200,10 +200,10 @@
 
 /* circular buffer */
 static struct circ_buf *ti_buf_alloc(void);
-static inline void ti_buf_free(struct circ_buf *cb);
-static inline void ti_buf_clear(struct circ_buf *cb);
-static inline int ti_buf_data_avail(struct circ_buf *cb);
-static inline int ti_buf_space_avail(struct circ_buf *cb);
+static void ti_buf_free(struct circ_buf *cb);
+static void ti_buf_clear(struct circ_buf *cb);
+static int ti_buf_data_avail(struct circ_buf *cb);
+static int ti_buf_space_avail(struct circ_buf *cb);
 static int ti_buf_put(struct circ_buf *cb, const char *buf, int count);
 static int ti_buf_get(struct circ_buf *cb, char *buf, int count);
 
@@ -841,7 +841,7 @@
 
 		case TIOCSSERIAL:
 			dbg("%s - (%d) TIOCSSERIAL", __FUNCTION__, port->number);
-			return ti_set_serial_info(tport, (struct serial_struct *)arg);
+			return ti_set_serial_info(tport, (struct serial_struct __user *)arg);
 			break;
 
 		case TIOCMIWAIT:
@@ -1428,7 +1428,7 @@
 
 
 static int ti_set_serial_info(struct ti_port *tport,
-	struct serial_struct *new_arg)
+	struct serial_struct __user *new_arg)
 {
 	struct usb_serial_port *port = tport->tp_port;
 	struct serial_struct new_serial;
@@ -1734,7 +1734,7 @@
  * Free the buffer and all associated memory.
  */
 
-static inline void ti_buf_free(struct circ_buf *cb)
+static void ti_buf_free(struct circ_buf *cb)
 {
 	kfree(cb->buf);
 	kfree(cb);
@@ -1747,7 +1747,7 @@
  * Clear out all data in the circular buffer.
  */
 
-static inline void ti_buf_clear(struct circ_buf *cb)
+static void ti_buf_clear(struct circ_buf *cb)
 {
 	cb->head = cb->tail = 0;
 }
@@ -1760,7 +1760,7 @@
  * buffer.
  */
 
-static inline int ti_buf_data_avail(struct circ_buf *cb)
+static int ti_buf_data_avail(struct circ_buf *cb)
 {
 	return CIRC_CNT(cb->head,cb->tail,TI_WRITE_BUF_SIZE);
 }
@@ -1773,7 +1773,7 @@
  * buffer.
  */
 
-static inline int ti_buf_space_avail(struct circ_buf *cb)
+static int ti_buf_space_avail(struct circ_buf *cb)
 {
 	return CIRC_SPACE(cb->head,cb->tail,TI_WRITE_BUF_SIZE);
 }

