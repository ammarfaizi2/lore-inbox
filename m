Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbVKHEad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbVKHEad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 23:30:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbVKHEad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 23:30:33 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:4371 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1030281AbVKHEac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 23:30:32 -0500
Date: Mon, 7 Nov 2005 20:30:30 -0800
Message-Id: <200511080430.jA84UU5f009903@zach-dev.vmware.com>
Subject: [PATCH 11/21] i386 Stop deleting nt
From: Zachary Amsden <zach@vmware.com>
To: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Zachary Amsden <zach@vmware.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 08 Nov 2005 04:30:30.0914 (UTC) FILETIME=[26FBAE20:01C5E41D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stop deleting NT bit from EFLAGS.  See arch/i386/kernel/head.S line 223,
which does something even better.

Signed-off-by: Zachary Amsden <zach@vmware.com>
Index: linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c
===================================================================
--- linux-2.6.14-zach-work.orig/arch/i386/kernel/cpu/common.c	2005-11-04 17:45:05.000000000 -0800
+++ linux-2.6.14-zach-work/arch/i386/kernel/cpu/common.c	2005-11-05 00:28:08.000000000 -0800
@@ -617,11 +617,6 @@ void __devinit cpu_init(void)
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
