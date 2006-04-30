Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbWD3Rdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbWD3Rdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWD3RdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:22 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45266 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751194AbWD3Rcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:39 -0400
Message-Id: <20060430173020.502782000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:29:54 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 01/14] Fix comment about remap_file_pages
Content-Disposition: inline; filename=rfp/00-rfp-comment.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

This comment is a bit unclear and also stale. So fix it. Thanks to Hugh Dickins
for explaining me what it really referred to, and correcting my first fix.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/mm/fremap.c
===================================================================
--- linux-2.6.git.orig/mm/fremap.c
+++ linux-2.6.git/mm/fremap.c
@@ -208,9 +208,10 @@ asmlinkage long sys_remap_file_pages(uns
 					    pgoff, flags & MAP_NONBLOCK);
 
 		/*
-		 * We can't clear VM_NONLINEAR because we'd have to do
-		 * it after ->populate completes, and that would prevent
-		 * downgrading the lock.  (Locks can't be upgraded).
+		 * We would like to clear VM_NONLINEAR, in the case when
+		 * sys_remap_file_pages covers the whole vma, so making
+		 * it linear again.  But cannot do so until after a
+		 * successful populate, and have no way to upgrade sem.
 		 */
 	}
 	if (likely(!has_write_lock))

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
