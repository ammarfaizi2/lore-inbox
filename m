Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932865AbWCVWch@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932865AbWCVWch (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932869AbWCVWcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:32:23 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:42470 "EHLO
	amsfep19-int.chello.nl") by vger.kernel.org with ESMTP
	id S932868AbWCVWcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:32:03 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223128.12658.81399.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 02/34] mm: page-replace-kconfig-makefile.patch
Date: Wed, 22 Mar 2006 23:32:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Introduce the configuration option, and modify the Makefile.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 mm/Kconfig  |   11 +++++++++++
 mm/Makefile |    2 ++
 mm/useonce.c    |    3 +++
 3 files changed, 16 insertions(+)

Index: linux-2.6/mm/Kconfig
===================================================================
--- linux-2.6.orig/mm/Kconfig	2006-03-13 20:37:08.000000000 +0100
+++ linux-2.6/mm/Kconfig	2006-03-13 20:37:24.000000000 +0100
@@ -133,6 +133,17 @@ config SPLIT_PTLOCK_CPUS
 	default "4096" if PARISC && !PA20
 	default "4"
 
+choice
+	prompt	"Page replacement policy"
+	default MM_POLICY_USEONCE
+
+config MM_POLICY_USEONCE
+	bool "LRU-2Q USE-ONCE"
+	help
+	  This option selects the standard multi-queue LRU policy.
+
+endchoice
+
 #
 # support for page migration
 #
Index: linux-2.6/mm/Makefile
===================================================================
--- linux-2.6.orig/mm/Makefile	2006-03-13 20:37:08.000000000 +0100
+++ linux-2.6/mm/Makefile	2006-03-13 20:37:24.000000000 +0100
@@ -12,6 +12,8 @@ obj-y			:= bootmem.o filemap.o mempool.o
 			   readahead.o swap.o truncate.o vmscan.o \
 			   prio_tree.o util.o $(mmu-y)
 
+obj-$(CONFIG_MM_POLICY_USEONCE) += useonce.o
+
 obj-$(CONFIG_SWAP)	+= page_io.o swap_state.o swapfile.o thrash.o
 obj-$(CONFIG_HUGETLBFS)	+= hugetlb.o
 obj-$(CONFIG_NUMA) 	+= mempolicy.o
Index: linux-2.6/mm/useonce.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/mm/useonce.c	2006-03-13 20:37:24.000000000 +0100
@@ -0,0 +1,3 @@
+
+
+
