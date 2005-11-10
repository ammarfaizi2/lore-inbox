Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVKJAoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVKJAoF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 19:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVKJAoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 19:44:05 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4106 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1751138AbVKJAoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 19:44:04 -0500
Date: Wed, 9 Nov 2005 16:44:03 -0800
Message-Id: <200511100044.jAA0i3Dd028394@zach-dev.vmware.com>
Subject: [PATCH 8/10] Stop deleting nt
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 10 Nov 2005 00:44:03.0516 (UTC) FILETIME=[D916C7C0:01C5E58F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop deleting NT bit from EFLAGS.  See arch/i386/kernel/head.S line 223,
which does something even better.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14.orig/arch/i386/kernel/cpu/common.c	2005-11-09 01:46:44.000000000 -0800
+++ linux-2.6.14/arch/i386/kernel/cpu/common.c	2005-11-09 06:13:51.000000000 -0800
@@ -604,11 +604,6 @@
 	load_idt(&idt_descr);
 
 	/*
-	 * Delete NT
-	 */
-	__asm__("pushfl ; andl $0xffffbfff,(%esp) ; popfl");
-
-	/*
 	 * Set up and load the per-CPU TSS and LDT
 	 */
 	atomic_inc(&init_mm.mm_count);
