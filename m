Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262579AbVHDPEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262579AbVHDPEp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 11:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVHDPC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 11:02:59 -0400
Received: from mailfe09.swipnet.se ([212.247.155.1]:7080 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262561AbVHDPBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 11:01:01 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Thu, 4 Aug 2005 17:00:53 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Robin Holt <holt@sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch 2.6.13-rc4] fix get_user_pages bug
Message-ID: <20050804150053.GA1346@localhost.localdomain>
References: <Pine.LNX.4.58.0508020911480.3341@g5.osdl.org> <Pine.LNX.4.61.0508021809530.5659@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021127120.3341@g5.osdl.org> <Pine.LNX.4.61.0508022001420.6744@goblin.wat.veritas.com> <Pine.LNX.4.58.0508021244250.3341@g5.osdl.org> <Pine.LNX.4.61.0508022150530.10815@goblin.wat.veritas.com> <42F09B41.3050409@yahoo.com.au> <Pine.LNX.4.58.0508030902380.3341@g5.osdl.org> <20050804141457.GA1178@localhost.localdomain> <42F2266F.30008@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42F2266F.30008@yahoo.com.au>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >x86_64 had hardcoded the VM_ numbers so it broke down when the numbers
> >were changed.
> >
> 
> Ugh, sorry I should have audited this but I really wasn't expecting
> it (famous last words). Hasn't been a good week for me.

Hardcoding is evil so it's good it gets cleaned up anyway.

> parisc, cris, m68k, frv, sh64, arm26 are also broken.
> Would you mind resending a patch that fixes them all?
> 

Remove the hardcoding in return value checking of handle_mm_fault()

Signed-off-by: Alexander Nyberg <alexn@telia.com>

 arm26/mm/fault.c  |    6 +++---
 cris/mm/fault.c   |    6 +++---
 frv/mm/fault.c    |    6 +++---
 m68k/mm/fault.c   |    6 +++---
 parisc/mm/fault.c |    6 +++---
 sh64/mm/fault.c   |    6 +++---
 x86_64/mm/fault.c |    6 +++---
 7 files changed, 21 insertions(+), 21 deletions(-)

Index: linux-2.6/arch/x86_64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/x86_64/mm/fault.c	2005-07-31 18:10:20.000000000 +0200
+++ linux-2.6/arch/x86_64/mm/fault.c	2005-08-04 16:04:59.000000000 +0200
@@ -439,13 +439,13 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, address, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
 	default:
 		goto out_of_memory;
Index: linux-2.6/arch/cris/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/cris/mm/fault.c	2005-07-31 18:10:02.000000000 +0200
+++ linux-2.6/arch/cris/mm/fault.c	2005-08-04 16:40:56.000000000 +0200
@@ -284,13 +284,13 @@
 	 */
 
 	switch (handle_mm_fault(mm, vma, address, writeaccess & 1)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
 	default:
 		goto out_of_memory;
Index: linux-2.6/arch/m68k/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/m68k/mm/fault.c	2005-07-31 18:10:05.000000000 +0200
+++ linux-2.6/arch/m68k/mm/fault.c	2005-08-04 16:42:05.000000000 +0200
@@ -160,13 +160,13 @@
 	printk("handle_mm_fault returns %d\n",fault);
 #endif
 	switch (fault) {
-	case 1:
+	case VM_FAULT_MINOR:
 		current->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto bus_err;
 	default:
 		goto out_of_memory;
Index: linux-2.6/arch/parisc/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/parisc/mm/fault.c	2005-07-31 18:10:11.000000000 +0200
+++ linux-2.6/arch/parisc/mm/fault.c	2005-08-04 16:41:18.000000000 +0200
@@ -178,13 +178,13 @@
 	 */
 
 	switch (handle_mm_fault(mm, vma, address, (acc_type & VM_WRITE) != 0)) {
-	      case 1:
+	      case VM_FAULT_MINOR:
 		++current->min_flt;
 		break;
-	      case 2:
+	      case VM_FAULT_MAJOR:
 		++current->maj_flt;
 		break;
-	      case 0:
+	      case VM_FAULT_SIGBUS:
 		/*
 		 * We ran out of memory, or some other thing happened
 		 * to us that made us unable to handle the page fault
Index: linux-2.6/arch/arm26/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/arm26/mm/fault.c	2005-07-31 18:10:00.000000000 +0200
+++ linux-2.6/arch/arm26/mm/fault.c	2005-08-04 16:46:18.000000000 +0200
@@ -176,12 +176,12 @@
 	 * Handle the "normal" cases first - successful and sigbus
 	 */
 	switch (fault) {
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		return fault;
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		return fault;
 	}
 
Index: linux-2.6/arch/frv/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/frv/mm/fault.c	2005-07-31 18:10:03.000000000 +0200
+++ linux-2.6/arch/frv/mm/fault.c	2005-08-04 16:44:02.000000000 +0200
@@ -163,13 +163,13 @@
 	 * the fault.
 	 */
 	switch (handle_mm_fault(mm, vma, ear0, write)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		current->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		current->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
 	default:
 		goto out_of_memory;
Index: linux-2.6/arch/sh64/mm/fault.c
===================================================================
--- linux-2.6.orig/arch/sh64/mm/fault.c	2005-07-31 18:10:16.000000000 +0200
+++ linux-2.6/arch/sh64/mm/fault.c	2005-08-04 16:44:58.000000000 +0200
@@ -223,13 +223,13 @@
 	 */
 survive:
 	switch (handle_mm_fault(mm, vma, address, writeaccess)) {
-	case 1:
+	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
-	case 2:
+	case VM_FAULT_MAJOR:
 		tsk->maj_flt++;
 		break;
-	case 0:
+	case VM_FAULT_SIGBUS:
 		goto do_sigbus;
 	default:
 		goto out_of_memory;
