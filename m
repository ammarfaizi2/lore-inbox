Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964818AbVHYF1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964818AbVHYF1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVHYF05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:26:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61899 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S964809AbVHYFVP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:15 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (8/22) lvalues abuse in lance
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8ADt-0005bo-8w@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

result of comma operator is not an lvalue

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-mac8390/drivers/net/atarilance.c RC13-rc7-lance/drivers/net/atarilance.c
--- RC13-rc7-mac8390/drivers/net/atarilance.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-lance/drivers/net/atarilance.c	2005-08-25 00:54:10.000000000 -0400
@@ -235,7 +235,7 @@
 #define	MEM		lp->mem
 #define	DREG	IO->data
 #define	AREG	IO->addr
-#define	REGA(a)	( AREG = (a), DREG )
+#define	REGA(a)	(*( AREG = (a), &DREG ))
 
 /* Definitions for packet buffer access: */
 #define PKT_BUF_SZ		1544
diff -urN RC13-rc7-mac8390/drivers/net/sun3lance.c RC13-rc7-lance/drivers/net/sun3lance.c
--- RC13-rc7-mac8390/drivers/net/sun3lance.c	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-lance/drivers/net/sun3lance.c	2005-08-25 00:54:10.000000000 -0400
@@ -162,7 +162,7 @@
 #define	MEM	lp->mem
 #define	DREG	lp->iobase[0]
 #define	AREG	lp->iobase[1]
-#define	REGA(a)	( AREG = (a), DREG )
+#define	REGA(a)	(*( AREG = (a), &DREG ))
 
 /* Definitions for the Lance */
 
