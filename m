Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUIMWqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUIMWqd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 18:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269027AbUIMWqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 18:46:06 -0400
Received: from itapoa.terra.com.br ([200.154.55.227]:40838 "EHLO
	itapoa.terra.com.br") by vger.kernel.org with ESMTP id S269024AbUIMWjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 18:39:39 -0400
Date: Mon, 13 Sep 2004 18:43:50 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@conectiva.com.br>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] - remove ugly code from usb/serial/usb-serial.c.
Message-Id: <20040913184350.44788366.lcapitulino@conectiva.com.br>
Organization: Conectiva S/A.
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Greg,

 This patch removes ugly code from some function in usb/serial/usb-serial.c
which is using a goto statement intead of a simple `return'.

 To be true, I'm not certain if there is a special reason to do that, if so
ignore me. ;)


Signed-off-by: Luiz Capitulino <lcapitulino@conectiva.com.br>

 drivers/usb/serial/usb-serial.c |   20 ++++----------------
 1 files changed, 4 insertions(+), 16 deletions(-)


diff -X /home/capitulino/kernels/2.6/dontdiff -Nparu a/drivers/usb/serial/usb-serial.c a~/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c	2004-09-12 18:36:22.000000000 -0300
+++ a~/drivers/usb/serial/usb-serial.c	2004-09-12 18:47:32.000000000 -0300
@@ -621,15 +621,12 @@ static void serial_throttle (struct tty_
 
 	if (!port->open_count) {
 		dbg ("%s - port not open", __FUNCTION__);
-		goto exit;
+		return;
 	}
 
 	/* pass on to the driver specific version of this function */
 	if (port->serial->type->throttle)
 		port->serial->type->throttle(port);
-
-exit:
-	;
 }
 
 static void serial_unthrottle (struct tty_struct * tty)
@@ -640,15 +637,12 @@ static void serial_unthrottle (struct tt
 
 	if (!port->open_count) {
 		dbg("%s - port not open", __FUNCTION__);
-		goto exit;
+		return;
 	}
 
 	/* pass on to the driver specific version of this function */
 	if (port->serial->type->unthrottle)
 		port->serial->type->unthrottle(port);
-
-exit:
-	;
 }
 
 static int serial_ioctl (struct tty_struct *tty, struct file * file, unsigned int cmd, unsigned long arg)
@@ -681,15 +675,12 @@ static void serial_set_termios (struct t
 
 	if (!port->open_count) {
 		dbg("%s - port not open", __FUNCTION__);
-		goto exit;
+		return;
 	}
 
 	/* pass on to the driver specific version of this function if it is available */
 	if (port->serial->type->set_termios)
 		port->serial->type->set_termios(port, old);
-
-exit:
-	;
 }
 
 static void serial_break (struct tty_struct *tty, int break_state)
@@ -700,15 +691,12 @@ static void serial_break (struct tty_str
 
 	if (!port->open_count) {
 		dbg("%s - port not open", __FUNCTION__);
-		goto exit;
+		return;
 	}
 
 	/* pass on to the driver specific version of this function if it is available */
 	if (port->serial->type->break_ctl)
 		port->serial->type->break_ctl(port, break_state);
-
-exit:
-	;
 }
 
 static int serial_read_proc (char *page, char **start, off_t off, int count, int *eof, void *data)
