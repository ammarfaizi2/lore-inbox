Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWD3Rdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWD3Rdp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 13:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbWD3RdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 13:33:21 -0400
Received: from host157-96.pool873.interbusiness.it ([87.3.96.157]:45522 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1751197AbWD3Rcj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 13:32:39 -0400
Message-Id: <20060430173022.780897000@zion.home.lan>
References: <20060430172953.409399000@zion.home.lan>
User-Agent: quilt/0.44-1
Date: Sun, 30 Apr 2006 19:29:57 +0200
From: blaisorblade@yahoo.it
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org,
       Paolo Blaisorblade Giarrusso <blaisorblade@yahoo.it>
Subject: [patch 04/14] remap_file_pages protection support: disallow mprotect() on manyprots mappings
Content-Disposition: inline; filename=rfp/04-rfp-stop-mprotect.diff
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

For now we (I and Hugh) have found no agreement on which behavior to implement
here. So, at least as a stop-gap, return an error here.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Index: linux-2.6.git/mm/mprotect.c
===================================================================
--- linux-2.6.git.orig/mm/mprotect.c
+++ linux-2.6.git/mm/mprotect.c
@@ -217,6 +217,13 @@ sys_mprotect(unsigned long start, size_t
 	error = -ENOMEM;
 	if (!vma)
 		goto out;
+
+	/* If a need is felt, an appropriate behaviour may be implemented for
+	 * this case. We haven't agreed yet on which behavior is appropriate. */
+	error = -EACCES;
+	if (vma->vm_flags & VM_MANYPROTS)
+		goto out;
+
 	if (unlikely(grows & PROT_GROWSDOWN)) {
 		if (vma->vm_start >= end)
 			goto out;

--
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
