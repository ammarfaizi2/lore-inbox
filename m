Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267984AbUIJWVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267984AbUIJWVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267979AbUIJWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:21:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:32472 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267984AbUIJWUT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:20:19 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix uninitialized warnings in mempolicy.c
Date: Fri, 10 Sep 2004 15:20:12 -0700
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ciiQBw4hbF8V8Hv"
Message-Id: <200409101520.12653.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_ciiQBw4hbF8V8Hv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Sorry if you already got these fixes, but err may be used uninitialized in 
mempolicy.c in both compat_set_mempolicy and compat_mbind.  This patch fixes 
that by setting them both to 0.

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

--Boundary-00=_ciiQBw4hbF8V8Hv
Content-Type: text/plain;
  charset="us-ascii";
  name="compat-mempolicy-warning-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="compat-mempolicy-warning-fixes.patch"

===== mm/mempolicy.c 1.14 vs edited =====
--- 1.14/mm/mempolicy.c	2004-09-07 23:32:56 -07:00
+++ edited/mm/mempolicy.c	2004-09-10 15:16:51 -07:00
@@ -557,7 +557,7 @@
 asmlinkage long compat_set_mempolicy(int mode, compat_ulong_t __user *nmask,
 				     compat_ulong_t maxnode)
 {
-	long err;
+	long err = 0;
 	unsigned long __user *nm = NULL;
 	unsigned long nr_bits, alloc_size;
 	DECLARE_BITMAP(bm, MAX_NUMNODES);
@@ -581,7 +581,7 @@
 			     compat_ulong_t mode, compat_ulong_t __user *nmask,
 			     compat_ulong_t maxnode, compat_ulong_t flags)
 {
-	long err;
+	long err = 0;
 	unsigned long __user *nm = NULL;
 	unsigned long nr_bits, alloc_size;
 	DECLARE_BITMAP(bm, MAX_NUMNODES);

--Boundary-00=_ciiQBw4hbF8V8Hv--
