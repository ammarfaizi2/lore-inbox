Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbVGKQkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbVGKQkF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbVGKQh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:37:29 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:8326 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262117AbVGKQgi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 12:36:38 -0400
Date: Mon, 11 Jul 2005 18:36:37 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 8/12] s390: free dasd slab cache.
Message-ID: <20050711163637.GH10822@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/12] s390: free dasd slab cache.

From: Horst Hummel <horst.hummel@de.ibm.com>

Free dasd slab cache on module unload.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/block/dasd.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)

diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2005-07-11 17:37:30.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2005-07-11 17:37:47.000000000 +0200
@@ -7,7 +7,7 @@
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999-2001
  *
- * $Revision: 1.164 $
+ * $Revision: 1.165 $
  */
 
 #include <linux/config.h>
@@ -1740,6 +1740,10 @@ dasd_exit(void)
 	dasd_proc_exit();
 #endif
 	dasd_ioctl_exit();
+        if (dasd_page_cache != NULL) {
+		kmem_cache_destroy(dasd_page_cache);
+		dasd_page_cache = NULL;
+	}
 	dasd_gendisk_exit();
 	dasd_devmap_exit();
 	devfs_remove("dasd");
