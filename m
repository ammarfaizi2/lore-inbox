Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264715AbUD1J7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264715AbUD1J7F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264718AbUD1J7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:59:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.184]:34780 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S264715AbUD1J7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:59:00 -0400
Date: Wed, 28 Apr 2004 11:58:49 +0200
From: Armin Schindler <armin@melware.de>
Message-Id: <200404280958.i3S9wnxP023626@phoenix.one.melware.de>
To: torvalds@osdl.org, akpm@osdl.org
Subject: [PATCH] 2.6 ISDN CAPI: fix ncci list semaphore
Cc: i4ldeveloper@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, Hi Linus,

this patch fixes the new ncci-list semaphore when 
CONFIG_ISDN_CAPI_MIDDLEWARE is disabled.

Please apply.

Thanks,
Armin


Name: ISDN CAPI: fix ncci list semaphore 
Author: Armin Schindler

D: Fix new ISDN CAPI's internal ncci list
   semaphore if CONFIG_ISDN_CAPI_MIDDLEWARE is disabled.
   Thanks to Florian Schirmer.



--- linux/drivers/isdn/capi/capi.c.orig	Wed Apr 28 11:49:49 2004
+++ linux/drivers/isdn/capi/capi.c	Wed Apr 28 11:50:12 2004
@@ -1,4 +1,4 @@
-/* $Id: capi.c,v 1.1.2.6 2004/04/26 09:33:07 armin Exp $
+/* $Id: capi.c,v 1.1.2.7 2004/04/28 09:48:59 armin Exp $
  *
  * CAPI 2.0 Interface for Linux
  *
@@ -45,7 +45,7 @@
 #include "capifs.h"
 #endif
 
-static char *revision = "$Revision: 1.1.2.6 $";
+static char *revision = "$Revision: 1.1.2.7 $";
 
 MODULE_DESCRIPTION("CAPI4Linux: Userspace /dev/capi20 interface");
 MODULE_AUTHOR("Carsten Paeth");
@@ -927,8 +927,8 @@
 			if ((mp = nccip->minorp) != 0) {
 				count += atomic_read(&mp->ttyopencount);
 			}
-			up(&cdev->ncci_list_sem);
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
+			up(&cdev->ncci_list_sem);
 			return count;
 		}
 		return 0;
