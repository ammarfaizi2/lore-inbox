Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268122AbUIGOpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268122AbUIGOpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 10:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268149AbUIGOmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 10:42:42 -0400
Received: from verein.lst.de ([213.95.11.210]:40601 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S268122AbUIGOk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 10:40:26 -0400
Date: Tue, 7 Sep 2004 16:40:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] rempove pm_find, unexport pm_send
Message-ID: <20040907144021.GA8674@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cutting back some unused legacy PM code


--- 1.16/include/linux/pm.h	2004-07-02 07:23:53 +02:00
+++ edited/include/linux/pm.h	2004-09-07 14:55:58 +02:00
@@ -143,11 +143,6 @@
  */
 int pm_send_all(pm_request_t rqst, void *data);
 
-/*
- * Find a device
- */
-struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from);
-
 static inline void pm_access(struct pm_dev *dev) {}
 static inline void pm_dev_idle(struct pm_dev *dev) {}
 
--- 1.13/kernel/power/pm.c	2004-06-30 08:52:41 +02:00
+++ edited/kernel/power/pm.c	2004-09-07 14:56:09 +02:00
@@ -256,41 +256,10 @@
 	return 0;
 }
 
-/**
- *	pm_find  - find a device
- *	@type: type of device
- *	@from: where to start looking
- *
- *	Scan the power management list for devices of a specific type. The
- *	return value for a matching device may be passed to further calls
- *	to this function to find further matches. A %NULL indicates the end
- *	of the list. 
- *
- *	To search from the beginning pass %NULL as the @from value.
- *
- *	The caller MUST hold the pm_devs_lock lock when calling this 
- *	function. The instant that the lock is dropped all pointers returned
- *	may become invalid.
- */
- 
-struct pm_dev *pm_find(pm_dev_t type, struct pm_dev *from)
-{
-	struct list_head *entry = from ? from->entry.next:pm_devs.next;
-	while (entry != &pm_devs) {
-		struct pm_dev *dev = list_entry(entry, struct pm_dev, entry);
-		if (type == PM_UNKNOWN_DEV || dev->type == type)
-			return dev;
-		entry = entry->next;
-	}
-	return NULL;
-}
-
 EXPORT_SYMBOL(pm_register);
 EXPORT_SYMBOL(pm_unregister);
 EXPORT_SYMBOL(pm_unregister_all);
-EXPORT_SYMBOL(pm_send);
 EXPORT_SYMBOL(pm_send_all);
-EXPORT_SYMBOL(pm_find);
 EXPORT_SYMBOL(pm_active);
 
 
