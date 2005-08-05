Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263109AbVHEV7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263109AbVHEV7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 17:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVHEV6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 17:58:15 -0400
Received: from sd291.sivit.org ([194.146.225.122]:60932 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261912AbVHEVzU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 17:55:20 -0400
Subject: [PATCH] Export handle_mm_fault to modules.
From: Stelian Pop <stelian@popies.net>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 05 Aug 2005 23:55:12 +0200
Message-Id: <1123278912.8224.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

handle_mm_fault changed from an inline function to a non-inline one
(__handle_mm_fault), which is not available to external kernel modules.
The patch below fixes this.

Stelian.

Export __handle_mm_fault to modules (called by the inlined handle_mm_fault function).

Signed-off-by: Stelian Pop <stelian@popies.net>

Index: linux-2.6.git/mm/memory.c
===================================================================
--- linux-2.6.git.orig/mm/memory.c	2005-08-05 22:26:20.000000000 +0200
+++ linux-2.6.git/mm/memory.c	2005-08-05 23:46:49.000000000 +0200
@@ -2061,6 +2061,7 @@
 	spin_unlock(&mm->page_table_lock);
 	return VM_FAULT_OOM;
 }
+EXPORT_SYMBOL(__handle_mm_fault);
 
 #ifndef __PAGETABLE_PUD_FOLDED
 /*

-- 
Stelian Pop <stelian@popies.net>

