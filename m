Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWBNFLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWBNFLY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 00:11:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030424AbWBNFLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 00:11:23 -0500
Received: from ns.miraclelinux.com ([219.118.163.66]:48079 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1030395AbWBNFFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 00:05:09 -0500
Message-Id: <20060214050449.671054000@localhost.localdomain>
References: <20060214050351.252615000@localhost.localdomain>
Date: Tue, 14 Feb 2006 14:04:33 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, linuxsh-dev@lists.sourceforge.net,
       Akinobu Mita <mita@miraclelinux.com>
Subject: [patch 42/47] make thread_info.flags an unsigned long
Content-Disposition: inline; filename=thread_info-flags.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The test_bit() routines are defined to work on a pointer to unsigned
long.  But thread_info.flags is __u32 (unsigned int) on sh and it is passed to
flag set/clear/test wrappers in include/linux/thread_info.h. So the compiler
will print warnings.

This patch changes to unsigned long instead.

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>

 include/asm-sh/thread_info.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: 2.6-rc/include/asm-sh/thread_info.h
===================================================================
--- 2.6-rc.orig/include/asm-sh/thread_info.h
+++ 2.6-rc/include/asm-sh/thread_info.h
@@ -18,7 +18,7 @@
 struct thread_info {
 	struct task_struct	*task;		/* main task structure */
 	struct exec_domain	*exec_domain;	/* execution domain */
-	__u32			flags;		/* low level flags */
+	unsigned long		flags;		/* low level flags */
 	__u32			cpu;
 	int			preempt_count; /* 0 => preemptable, <0 => BUG */
 	struct restart_block	restart_block;

--
