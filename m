Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSG2WEH>; Mon, 29 Jul 2002 18:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318171AbSG2WEG>; Mon, 29 Jul 2002 18:04:06 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:58110 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318170AbSG2WEF>; Mon, 29 Jul 2002 18:04:05 -0400
Date: Mon, 29 Jul 2002 23:07:32 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct3/9 mremap MAP_NORESERVE not in flags
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292306280.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is no point in do_mremap clearing MAP_NORESERVE from its flags:
it has already validated that only the MREMAP_ flags can be set,
and it has no use for MAP_NORESERVE in the code that follows anyway.

--- vmacct2/mm/mremap.c	Mon Jul 29 11:48:04 2002
+++ vmacct3/mm/mremap.c	Mon Jul 29 19:23:46 2002
@@ -229,8 +229,6 @@
 	return -ENOMEM;
 }
 
-extern int sysctl_overcommit_memory;	/* FIXME!! */
-
 /*
  * Expand (or shrink) an existing mapping, potentially moving it at the
  * same time (controlled by the MREMAP_MAYMOVE flag and available VM space)
@@ -315,8 +313,6 @@
 	    > current->rlim[RLIMIT_AS].rlim_cur)
 		goto out;
 
-	if (sysctl_overcommit_memory > 1)
-		flags &= ~MAP_NORESERVE;
 	if (vma->vm_flags & VM_ACCOUNT) {
 		charged = (new_len - old_len) >> PAGE_SHIFT;
 		if (!vm_enough_memory(charged))

