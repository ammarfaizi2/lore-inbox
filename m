Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbTEFVZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbTEFVZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:25:38 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:1866 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261912AbTEFVZg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:25:36 -0400
Subject: [PATCH] 2.5.69 n_hdlc.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1052257094.2497.6.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 May 2003 16:38:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Use C99 initializers

Please apply

-- 
Paul Fulghum, paulkf@microgate.com
Microgate Corporation, http://www.microgate.com


--- linux-2.5.69/drivers/char/n_hdlc.c	2003-05-06 14:16:19.000000000 -0500
+++ linux-2.5.69-mg/drivers/char/n_hdlc.c	2003-05-06 16:29:59.000000000 -0500
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 4.6 2003/04/21 19:14:07 paulkf Exp $
+ * $Id: n_hdlc.c,v 4.8 2003/05/06 21:18:51 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 4.6 $"
+#define HDLC_VERSION "$Revision: 4.8 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -215,6 +215,21 @@
 /* Define this string only once for all macro invocations */
 static char szVersion[] = HDLC_VERSION;
 
+static struct tty_ldisc n_hdlc_ldisc = {
+	.owner		= THIS_MODULE,
+	.magic		= TTY_LDISC_MAGIC,
+	.name		= "hdlc",
+	.open		= n_hdlc_tty_open,
+	.close		= n_hdlc_tty_close,
+	.read		= n_hdlc_tty_read,
+	.write		= n_hdlc_tty_write,
+	.ioctl		= n_hdlc_tty_ioctl,
+	.poll		= n_hdlc_tty_poll,
+	.receive_buf	= n_hdlc_tty_receive,
+	.receive_room	= n_hdlc_tty_room,
+	.write_wakeup	= n_hdlc_tty_wakeup,
+};
+
 /* n_hdlc_release()
  *
  *	release an n_hdlc per device line discipline info structure
@@ -968,25 +983,6 @@
 
 static int __init n_hdlc_init(void)
 {
-	static struct tty_ldisc	n_hdlc_ldisc = {
-		TTY_LDISC_MAGIC,    /* magic */
-		"hdlc",             /* name */
-		0,                  /* num */
-		0,                  /* flags */
-		n_hdlc_tty_open,    /* open */
-		n_hdlc_tty_close,   /* close */
-		0,                  /* flush_buffer */
-		0,                  /* chars_in_buffer */
-		n_hdlc_tty_read,    /* read */
-		n_hdlc_tty_write,   /* write */
-		n_hdlc_tty_ioctl,   /* ioctl */
-		0,                  /* set_termios */
-		n_hdlc_tty_poll,    /* poll */
-		n_hdlc_tty_receive, /* receive_buf */
-		n_hdlc_tty_room,    /* receive_room */
-		n_hdlc_tty_wakeup,  /* write_wakeup */
-		THIS_MODULE         /* owner */
-	};
 	int    status;
 
 	/* range check maxframe arg */



