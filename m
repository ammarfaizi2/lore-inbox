Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318171AbSG2WFr>; Mon, 29 Jul 2002 18:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318173AbSG2WFr>; Mon, 29 Jul 2002 18:05:47 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:44311 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S318171AbSG2WFq>; Mon, 29 Jul 2002 18:05:46 -0400
Date: Mon, 29 Jul 2002 23:09:13 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: [PATCH] vmacct4/9 mmap MAP_NORESERVE not in vm_flags
In-Reply-To: <Pine.LNX.4.21.0207292257001.1184-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0207292307430.1184-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do_mmap_pgoff clears MAP_NORESERVE from vm_flags when VM accounts
strictly: but it's not in vm_flags, it's in flags (and tested there).

--- vmacct3/mm/mmap.c	Mon Jul 29 11:48:04 2002
+++ vmacct4/mm/mmap.c	Mon Jul 29 19:23:46 2002
@@ -535,7 +535,7 @@
 		return -ENOMEM;
 
 	if (sysctl_overcommit_memory > 1)
-		vm_flags &= ~MAP_NORESERVE;
+		flags &= ~MAP_NORESERVE;
 
 	/* Private writable mapping? Check memory availability.. */
 	if ((((vm_flags & (VM_SHARED | VM_WRITE)) == VM_WRITE) ||

