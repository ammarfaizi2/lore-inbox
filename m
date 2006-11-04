Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965675AbWKDU3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965675AbWKDU3g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965670AbWKDU3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:29:15 -0500
Received: from cacti2.profiwh.com ([85.93.165.64]:52672 "EHLO
	cacti.profiwh.com") by vger.kernel.org with ESMTP id S965665AbWKDU25
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:28:57 -0500
Message-id: <109505566143013108@wsc.cz>
Subject: [PATCH 5/8] Char: istallion, ifdef eisa code
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Date: Sat,  4 Nov 2006 21:29:08 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

istallion, ifdef eisa code

Disable compiling eisa stuff if STLI_EISAPROBE == 0.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b2606947cdfd650f706f4d0f97574a2a00c325ce
tree f2bd24bf4ceafb6bd820e411da59f4a6c65b4d23
parent 5d593cca61510bc31b01025fa5f9070e143be2aa
author Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:42:02 +0059
committer Jiri Slaby <jirislaby@gmail.com> Sat, 04 Nov 2006 20:42:02 +0059

 drivers/char/istallion.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
index 730db7f..aff6a4c 100644
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -355,6 +355,7 @@ MODULE_PARM_DESC(board2, "Board 2 config
 module_param_array(board3, charp, NULL, 0);
 MODULE_PARM_DESC(board3, "Board 3 config -> name[,ioaddr[,memaddr]");
 
+#if STLI_EISAPROBE != 0
 /*
  *	Set up a default memory address table for EISA board probing.
  *	The default addresses are all bellow 1Mbyte, which has to be the
@@ -372,6 +373,7 @@ static unsigned long	stli_eisamemprobead
 };
 
 static int	stli_eisamempsize = ARRAY_SIZE(stli_eisamemprobeaddrs);
+#endif
 
 /*
  *	Define the Stallion PCI vendor and device IDs.
@@ -684,7 +686,9 @@ static struct stliport *stli_getport(uns
 
 static int	stli_initecp(struct stlibrd *brdp);
 static int	stli_initonb(struct stlibrd *brdp);
+#if STLI_EISAPROBE != 0
 static int	stli_eisamemprobe(struct stlibrd *brdp);
+#endif
 static int	stli_initports(struct stlibrd *brdp);
 
 /*****************************************************************************/
@@ -3711,6 +3715,7 @@ static int __devinit stli_brdinit(struct
 	return 0;
 }
 
+#if STLI_EISAPROBE != 0
 /*****************************************************************************/
 
 /*
@@ -3804,6 +3809,7 @@ static int stli_eisamemprobe(struct stli
 	}
 	return 0;
 }
+#endif
 
 static int stli_getbrdnr(void)
 {
@@ -3819,6 +3825,7 @@ static int stli_getbrdnr(void)
 	return -1;
 }
 
+#if STLI_EISAPROBE != 0
 /*****************************************************************************/
 
 /*
@@ -3894,6 +3901,9 @@ static int stli_findeisabrds(void)
 
 	return 0;
 }
+#else
+static inline int stli_findeisabrds(void) { return 0; }
+#endif
 
 /*****************************************************************************/
 
@@ -4019,8 +4029,7 @@ static int stli_initbrds(void)
 		stli_brdinit(brdp);
 	}
 
-	if (STLI_EISAPROBE)
-		stli_findeisabrds();
+	stli_findeisabrds();
 
 	retval = pci_register_driver(&stli_pcidriver);
 	/* TODO: check retval and do something */
