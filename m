Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267363AbSLSUe4>; Thu, 19 Dec 2002 15:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLSUe4>; Thu, 19 Dec 2002 15:34:56 -0500
Received: from www.microgate.com ([216.30.46.105]:56837 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP
	id <S267363AbSLSUey>; Thu, 19 Dec 2002 15:34:54 -0500
Subject: [PATCH] 2.5.52 n_hdlc.c
From: Paul Fulghum <paulkf@microgate.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "torvalds@transmeta.com" <torvalds@transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.4 
Date: 19 Dec 2002 14:42:30 -0600
Message-Id: <1040330551.931.8.camel@diemos.microgate.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make global func/var static to avoid namespace polution

--- linux-2.5.52/drivers/char/n_hdlc.c	Sun Dec 15 20:07:51 2002
+++ linux-2.5.52-mg/drivers/char/n_hdlc.c	Thu Dec 19 12:01:23 2002
@@ -9,7 +9,7 @@
  *	Al Longyear <longyear@netcom.com>, Paul Mackerras <Paul.Mackerras@cs.anu.edu.au>
  *
  * Original release 01/11/99
- * $Id: n_hdlc.c,v 4.2 2002/10/10 14:52:41 paulkf Exp $
+ * $Id: n_hdlc.c,v 4.3 2002/12/19 18:58:56 paulkf Exp $
  *
  * This code is released under the GNU General Public License (GPL)
  *
@@ -78,7 +78,7 @@
  */
 
 #define HDLC_MAGIC 0x239e
-#define HDLC_VERSION "$Revision: 4.2 $"
+#define HDLC_VERSION "$Revision: 4.3 $"
 
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
 
@@ -185,10 +185,10 @@
 
 /* debug level can be set by insmod for debugging purposes */
 #define DEBUG_LEVEL_INFO	1
-int debuglevel=0;
+static int debuglevel=0;
 
 /* max frame size for memory allocations */
-ssize_t	maxframe=4096;
+static ssize_t	maxframe=4096;
 
 /* TTY callbacks */
 
@@ -903,7 +903,7 @@
  * Arguments:	 	list	pointer to buffer list
  * Return Value:	None	
  */
-void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
+static void n_hdlc_buf_list_init(N_HDLC_BUF_LIST *list)
 {
 	memset(list,0,sizeof(N_HDLC_BUF_LIST));
 	spin_lock_init(&list->spinlock);
@@ -920,7 +920,7 @@
  * 
  * Return Value:	None	
  */
-void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
+static void n_hdlc_buf_put(N_HDLC_BUF_LIST *list,N_HDLC_BUF *buf)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&list->spinlock,flags);
@@ -950,7 +950,7 @@
  * 
  * 	pointer to HDLC buffer if available, otherwise NULL
  */
-N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
+static N_HDLC_BUF* n_hdlc_buf_get(N_HDLC_BUF_LIST *list)
 {
 	unsigned long flags;
 	N_HDLC_BUF *buf;



