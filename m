Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVLNXXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVLNXXp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 18:23:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965061AbVLNXXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 18:23:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19677 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965028AbVLNXXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 18:23:44 -0500
Date: Wed, 14 Dec 2005 15:23:36 -0800 (PST)
From: hawkes@sgi.com
To: Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jack Steiner <steiner@sgi.com>, Keith Owens <kaos@sgi.com>, hawkes@sgi.com
Message-Id: <20051214232336.8314.29391.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] ia64: eliminate softlockup warning
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an unnecessary softlockup watchdog warning in the ia64
uncached_build_memmap() that occurs occasionally at 256p and always at
512p.  The problem occurs at boot time.

It would be good if we had a cleaner mechanism to temporarily silence
the watchdog thread, e.g.,
    http://marc.theaimsgroup.com/?l=linux-kernel&m=111552476401175&w=2
but until that patch gets merged, this fix will have to suffice.

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/arch/ia64/kernel/uncached.c
===================================================================
--- linux.orig/arch/ia64/kernel/uncached.c	2005-12-06 15:12:14.000000000 -0800
+++ linux/arch/ia64/kernel/uncached.c	2005-12-14 14:50:55.000000000 -0800
@@ -210,6 +210,7 @@
 
 	dprintk(KERN_ERR "uncached_build_memmap(%lx %lx)\n", start, end);
 
+	touch_softlockup_watchdog();
 	memset((char *)start, 0, length);
 
 	node = paddr_to_nid(start - __IA64_UNCACHED_OFFSET);
