Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWIFQLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWIFQLH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWIFQLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:11:07 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:4107 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751361AbWIFQLE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:11:04 -0400
Subject: Re: [patch 3/6] fault-injection capability for alloc_pages() [bug
	fix]
From: Don Mullis <dwm@meer.net>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 09:07:11 -0700
Message-Id: <1157558831.9460.52.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation when CONFIG_FAIL_PAGE_ALLOC=n

Signed-off-by: Don Mullis <dwm@meer.net>

---
 mm/page_alloc.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.17/mm/page_alloc.c
===================================================================
--- linux-2.6.17.orig/mm/page_alloc.c
+++ linux-2.6.17/mm/page_alloc.c
@@ -938,9 +938,11 @@ __alloc_pages(gfp_t gfp_mask, unsigned i
 
 	might_sleep_if(wait);
 
+#ifdef CONFIG_FAIL_PAGE_ALLOC
 	if (!(gfp_mask & __GFP_NOFAIL) &&
 	    should_fail(fail_page_alloc, 1 << order))
 		return NULL;
+#endif
 
 restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */


