Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbTETWkt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbTETWkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:40:49 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:37423 "EHLO
	mwinf0201.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261300AbTETWkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:40:45 -0400
From: Duncan Sands <baldrick@wanadoo.fr>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] USB speedtouch: remove MOD_*_USE_COUNT
Date: Wed, 21 May 2003 00:53:40 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305210053.40026.baldrick@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ATM layer takes a reference with fops_get.  This patch is already
in Linus's tree, but hasn't reached Greg's tree yet.  BK test :)

 speedtch.c |    6 ------
 1 files changed, 6 deletions(-)


diff -Nru a/drivers/usb/misc/speedtch.c b/drivers/usb/misc/speedtch.c
--- a/drivers/usb/misc/speedtch.c	Wed May 21 00:39:53 2003
+++ b/drivers/usb/misc/speedtch.c	Wed May 21 00:39:53 2003
@@ -952,19 +952,15 @@
 		return -EAGAIN;
 	}
 
-	MOD_INC_USE_COUNT;
-
 	down (&instance->serialize); /* vs self, udsl_atm_close */
 
 	if (udsl_find_vcc (instance, vpi, vci)) {
 		up (&instance->serialize);
-		MOD_DEC_USE_COUNT;
 		return -EADDRINUSE;
 	}
 
 	if (!(new = kmalloc (sizeof (struct udsl_vcc_data), GFP_KERNEL))) {
 		up (&instance->serialize);
-		MOD_DEC_USE_COUNT;
 		return -ENOMEM;
 	}
 
@@ -1033,8 +1029,6 @@
 	clear_bit (ATM_VF_ADDR, &vcc->flags);
 
 	up (&instance->serialize);
-
-	MOD_DEC_USE_COUNT;
 
 	dbg ("udsl_atm_close successful");
 }

