Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261808AbTDUSA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 14:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTDUSA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 14:00:26 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:29490 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S261808AbTDUSAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 14:00:24 -0400
Subject: [PATCH] n_hdlc.c 2.5.68
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050948742.1841.15.camel@diemos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 21 Apr 2003 13:12:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to remove MODULE_USE_COUNT macros
and make some functions static.

Please apply.

Paul Fulghum
paulkf@microgate.com

--- linux-2.5.68/drivers/char/n_hdlc.c	2003-04-07 12:30:59.000000000
-0500
+++ linux-2.5.68-mg/drivers/char/n_hdlc.c	2003-04-21 12:54:06.650579776
-0500
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras
<Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 4.2 2002/10/10 14:52:41 paulkf Exp $
+ * $Id: n_hdlc.c,v 4.5 2003/04/21 17:46:54 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 4.2 $"
+#define HDLC_VERSION "$Revision: 4.5 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -171,9 +171,9 @@
 /*
  * HDLC buffer list manipulation functions
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list);
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf);
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list);
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list);
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf);
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list);
 
 /* Local functions */
 
@@ -299,7 +299,6 @@
 			n_hdlc->tty = n_hdlc->backup_tty;
 		} else {
 			n_hdlc_release (n_hdlc);
-			MOD_DEC_USE_COUNT;
 		}
 	}
 	
@@ -339,8 +338,6 @@
 	tty->disc_data = n_hdlc;
 	n_hdlc->tty    = tty;
 	
-	MOD_INC_USE_COUNT;
-	
 #if defined(TTY_NO_WRITE_SPLIT)
 	/* change tty_io write() to not split large writes into 8K chunks */
 	set_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
@@ -903,7 +900,7 @@
  * Arguments:	 	list	pointer to buffer list
  * Return Value:	None	
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
 {
 	memset(list,0,sizeof(N_HDLC_BUF_LIST));
 	spin_lock_init(&list->spinlock);
@@ -920,7 +917,7 @@
  * 
  * Return Value:	None	
  */
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&list->spinlock,flags);
@@ -950,7 +947,7 @@
  * 
  * 	pointer to HDLC buffer if available, otherwise NULL
  */
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
 {
 	unsigned long flags;
 	N_HDLC_BUF *buf;



