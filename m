Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVDGBOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVDGBOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 21:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbVDGBO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 21:14:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:51508 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262369AbVDGBNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 21:13:02 -0400
Date: Thu, 7 Apr 2005 02:13:10 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Russell King <rmk@arm.linux.org.uk>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] freepgt2: sys_mincore ignore FIRST_USER_PGD_NR
In-Reply-To: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.61.0504070210430.24723@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0504070204390.24723@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove use of FIRST_USER_PGD_NR from sys_mincore: it's inconsistent (no
other syscall refers to it), unnecessary (sys_mincore loops over vmas
further down) and incorrect (misses user addresses in ARM's first pgd).

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/mincore.c |    3 ---
 1 files changed, 3 deletions(-)

--- 2.6.12-rc2-mm1/mm/mincore.c	2005-04-05 15:21:02.000000000 +0100
+++ linux/mm/mincore.c	2005-04-05 18:59:01.000000000 +0100
@@ -118,9 +118,6 @@ asmlinkage long sys_mincore(unsigned lon
  	if (start & ~PAGE_CACHE_MASK)
 		goto einval;
 
-	if (start < FIRST_USER_PGD_NR * PGDIR_SIZE)
-		goto enomem;
-
 	limit = TASK_SIZE;
 	if (start >= limit)
 		goto enomem;
