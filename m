Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbSLSUc0>; Thu, 19 Dec 2002 15:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbSLSUc0>; Thu, 19 Dec 2002 15:32:26 -0500
Received: from www.microgate.com ([216.30.46.105]:54277 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S267057AbSLSUcY>; Thu, 19 Dec 2002 15:32:24 -0500
Subject: [PATCH] 2.2.23 n_hdlc.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 19 Dec 2002 14:39:57 -0600
Message-Id: <1040330400.931.2.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make global func/var static to avoid namespace polution

--- linux-2.2.23/drivers/char/n_hdlc.c	Fri Nov  2 10:39:06 2001
+++ linux-2.2.23-mg/drivers/char/n_hdlc.c	Thu Dec 19 12:00:52 2002
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 2.3 2001/05/09 14:42:37 paul Exp $
+ * $Id: n_hdlc.c,v 2.4 2002/12/19 18:58:54 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 2.3 $"
+#define HDLC_VERSION "$Revision: 2.4 $"
 
 #include <linux/version.h>
 #include <linux/config.h>
@@ -184,9 +184,9 @@
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
 
@@ -197,10 +197,10 @@
 
 /* debug level can be set by insmod for debugging purposes */
 #define DEBUG_LEVEL_INFO	1
-int debuglevel=0;
+static int debuglevel=0;
 
 /* max frame size for memory allocations */
-ssize_t	maxframe=4096;
+static ssize_t	maxframe=4096;
 
 /* TTY callbacks */
 
@@ -921,7 +921,7 @@
  * Arguments:	 	list	pointer to buffer list
  * Return Value:	None	
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
 {
 	memset(list,0,sizeof(N_HDLC_BUF_LIST));
 	spin_lock_init(&list->spinlock);
@@ -938,7 +938,7 @@
  * 
  * Return Value:	None	
  */
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&list->spinlock,flags);
@@ -968,7 +968,7 @@
  * 
  * 	pointer to HDLC buffer if available, otherwise NULL
  */
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
 {
 	unsigned long flags;
 	N_HDLC_BUF *buf;



