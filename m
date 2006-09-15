Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWIOPen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWIOPen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbWIOPen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:34:43 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:27532 "EHLO
	outbound2-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751408AbWIOPem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:34:42 -0400
X-BigFish: V
Subject: [PATCH]i386: fix overflow in vmap on an x86 system which has more
	than 4GB memory.
From: Anatoli Antonovitch <antonovi@ati.com>
Reply-To: antonovi@ati.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: ATI Technologies Inc.
Date: Fri, 15 Sep 2006 11:34:37 -0400
Message-Id: <1158334477.5219.1.camel@antonovi-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 15 Sep 2006 15:34:41.0910 (UTC) FILETIME=[767F5960:01C6D8DC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description
(max_mapnr << PAGE_SHIFT) would overflow on an x86 system which has more
than 4GB memory, and hence cause vmap to fail every time.


Signed-off-by: Michael Chen <micche@ati.com>

Patch
diff -Nur linux-2.4.21-40.EL/mm/vmalloc.c
linux-2.4.21-40.EL.diff/mm/vmalloc.c
--- linux-2.4.21-40.EL/mm/vmalloc.c     2006-02-02 21:13:20.000000000
-0600
+++ linux-2.4.21-40.EL.diff/mm/vmalloc.c        2006-09-04
11:29:33.000000000 -0500
@@ -298,8 +298,8 @@
        struct vm_struct *area;
        unsigned long size = count << PAGE_SHIFT;
 
-       if (!size || size > (max_mapnr << PAGE_SHIFT))
-               return NULL;
+    if (!count || count > max_mapnr)
+        return NULL;
        area = get_vm_area(size, flags);
        if (!area) {
                return NULL;


