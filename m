Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268298AbUHQQE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268298AbUHQQE5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 12:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268272AbUHQQE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 12:04:57 -0400
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:35022 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S268322AbUHQQDa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 12:03:30 -0400
Message-ID: <41222C16.7070700@ttnet.net.tr>
Date: Tue, 17 Aug 2004 19:02:30 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: [PATCH] [2.4.28-pre1] two __FUNCTION__ patches
Content-Type: multipart/mixed;
	boundary="------------090803040304030505040301"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090803040304030505040301
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit

Here are two __FUNCTION__ patches from the -ac/-pac tree.
Review and please apply to 2.4.28.

Regards,
Ozkan Sezer


--------------090803040304030505040301
Content-Type: text/plain;
	name="F01.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="F01.diff"

diff -urN 28pre1/drivers/char/ftape/lowlevel/ftape-tracing.h 28pre1ac/drivers/char/ftape/lowlevel/ftape-tracing.h
--- 28pre1/drivers/char/ftape/lowlevel/ftape-tracing.h	2000-09-03 21:22:09.000000000 +0300
+++ 28pre1ac/drivers/char/ftape/lowlevel/ftape-tracing.h	2004-08-16 16:09:03.000000000 +0300
@@ -70,8 +70,8 @@
 #define TRACE(l, m, i...)						\
 {									\
 	if ((ft_trace_t)(l) == FT_TRACE_TOP_LEVEL) {			\
-		printk(KERN_INFO"ftape"__FILE__"("__FUNCTION__"):\n"	\
-		       KERN_INFO m".\n" ,##i);				\
+		printk(KERN_INFO"ftape"__FILE__"(%s):\n"		\
+		       KERN_INFO m".\n" ,__FUNCTION__, ##i);		\
 	}								\
 }
 #define SET_TRACE_LEVEL(l)      if ((l) == (l)) do {} while(0)

--------------090803040304030505040301
Content-Type: text/plain;
	name="F02.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="F02.diff"

diff -urN 28pre1/net/irda/irlmp.c 28pre1ac/net/irda/irlmp.c
--- 28pre1/net/irda/irlmp.c	2003-06-13 17:51:39.000000000 +0300
+++ 28pre1ac/net/irda/irlmp.c	2004-08-16 16:09:05.000000000 +0300
@@ -1241,7 +1241,7 @@
 	/* Get the number of lsap. That's the only safe way to know
 	 * that we have looped around... - Jean II */
 	lsap_todo = HASHBIN_GET_SIZE(self->lsaps);
-	IRDA_DEBUG(4, __FUNCTION__ "() : %d lsaps to scan\n", lsap_todo);
+	IRDA_DEBUG(4, "%s() : %d lsaps to scan\n", __FUNCTION__, lsap_todo);
 
 	/* Poll lsap in order until the queue is full or until we
 	 * tried them all.
@@ -1255,7 +1255,7 @@
 			/* Note that if there is only one LSAP on the LAP
 			 * (most common case), self->flow_next is always NULL,
 			 * so we always avoid this loop. - Jean II */
-			IRDA_DEBUG(4, __FUNCTION__ "() : searching my LSAP\n");
+			IRDA_DEBUG(4, "%s() : searching my LSAP\n", __FUNCTION__);
 
 			/* We look again in hashbins, because the lsap
 			 * might have gone away... - Jean II */
@@ -1274,14 +1274,14 @@
 
 		/* Next time, we will get the next one (or the first one) */
 		self->flow_next = (struct lsap_cb *) hashbin_get_next(self->lsaps);
-		IRDA_DEBUG(4, __FUNCTION__ "() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
+		IRDA_DEBUG(4, "%s() : curr is %p, next was %p and is now %p, still %d to go - queue len = %d\n", __FUNCTION__, curr, next, self->flow_next, lsap_todo, IRLAP_GET_TX_QUEUE_LEN(self->irlap));
 
 		/* Inform lsap user that it can send one more packet. */
 		if (curr->notify.flow_indication != NULL)
 			curr->notify.flow_indication(curr->notify.instance, 
 						     curr, flow);
 		else
-			IRDA_DEBUG(1, __FUNCTION__ "(), no handler\n");
+			IRDA_DEBUG(1, "%s(), no handler\n", __FUNCTION__);
 	}
 }
 

--------------090803040304030505040301--
