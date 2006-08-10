Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161246AbWHJN1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161246AbWHJN1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161262AbWHJN1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:27:33 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:60650 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1161313AbWHJN1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:27:30 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 1/5] Clean up suspend header
Date: Thu, 10 Aug 2006 15:12:02 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608101510.40544.rjw@sisk.pl>
In-Reply-To: <200608101510.40544.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608101512.02434.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some things that are no longer used or defined elsewhere from suspend.h
and make the inline version of software_suspend() return the right error code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/linux/suspend.h |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

Index: linux-2.6.18-rc3-mm2/include/linux/suspend.h
===================================================================
--- linux-2.6.18-rc3-mm2.orig/include/linux/suspend.h	2006-08-10 00:08:08.000000000 +0200
+++ linux-2.6.18-rc3-mm2/include/linux/suspend.h	2006-08-10 07:43:53.000000000 +0200
@@ -10,11 +10,11 @@
 #include <linux/pm.h>
 
 /* page backup entry */
-typedef struct pbe {
+struct pbe {
 	unsigned long address;		/* address of the copy */
 	unsigned long orig_address;	/* original address of page */
 	struct pbe *next;
-} suspend_pagedir_t;
+};
 
 #define for_each_pbe(pbe, pblist) \
 	for (pbe = pblist ; pbe ; pbe = pbe->next)
@@ -25,15 +25,6 @@ typedef struct pbe {
 #define for_each_pb_page(pbe, pblist) \
 	for (pbe = pblist ; pbe ; pbe = (pbe+PB_PAGE_SKIP)->next)
 
-
-#define SWAP_FILENAME_MAXLENGTH	32
-
-
-extern dev_t swsusp_resume_device;
-   
-/* mm/vmscan.c */
-extern int shrink_mem(void);
-
 /* mm/page_alloc.c */
 extern void drain_local_pages(void);
 extern void mark_free_pages(struct zone *zone);
@@ -53,7 +44,7 @@ static inline void pm_restore_console(vo
 static inline int software_suspend(void)
 {
 	printk("Warning: fake suspend called\n");
-	return -EPERM;
+	return -ENOSYS;
 }
 #endif /* CONFIG_PM */
 

