Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262818AbTFDNG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 09:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbTFDNG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 09:06:27 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20452 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262818AbTFDNG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 09:06:26 -0400
Date: Wed, 4 Jun 2003 10:13:20 -0300
From: Flavio Bruno Leitner <fbl@conectiva.com.br>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4 - trivial cleanup in kmem_cache_reap()
Message-ID: <20030604131320.GA24997@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The patch below is against v2.4.21-rc7, please apply.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1193  -> 1.1194 
#	           mm/slab.c	1.22    -> 1.23   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/06/03	fbl@netbank.com.br	1.1194
# [PATCH] Cleanup kmem_cache_reap()
#     
# There is no need to keep the list_entry() 
# out of DEBUG condition.
# --------------------------------------------
#
diff -Nru a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Wed Nov 27 16:04:37 2002
+++ b/mm/slab.c	Tue Jun  3 22:47:41 2003
@@ -1784,8 +1784,9 @@
 		full_free = 0;
 		p = searchp->slabs_free.next;
 		while (p != &searchp->slabs_free) {
-			slabp = list_entry(p, slab_t, list);
 #if DEBUG
+			slabp = list_entry(p, slab_t, list);
+
 			if (slabp->inuse)
 				BUG();
 #endif
-- 
Flávio Bruno Leitner <fbl@conectiva.com.br>
[ E74B 0BD0 5E05 C385 239E  531C BC17 D670 7FF0 A9E0 ]

