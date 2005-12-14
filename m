Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVLNM6O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVLNM6O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 07:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVLNM6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 07:58:14 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:38829 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932124AbVLNM6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 07:58:13 -0500
Date: Wed, 14 Dec 2005 06:58:05 -0600
From: Robin Holt <holt@sgi.com>
To: tony.luck@intel.com
Cc: linux-ia64@vger.kernel.org, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: [Patch] Complete fix for SET_PERSONALITY when CONFIG_IA32_SUPPORT is not set.
Message-ID: <20051214125805.GA21960@lnx-holt.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214021644.GA19695@redhat.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missed this when fixing the SET_PERSONALITY change.

Signed-off-by: Robin Holt <holt@sgi.com>


Index: linux-2.6/arch/ia64/kernel/process.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/process.c	2005-12-14 06:49:33.512127321 -0600
+++ linux-2.6/arch/ia64/kernel/process.c	2005-12-14 06:52:07.488250554 -0600
@@ -721,11 +721,13 @@ flush_thread (void)
 	/* drop floating-point and debug-register state if it exists: */
 	current->thread.flags &= ~(IA64_THREAD_FPH_VALID | IA64_THREAD_DBG_VALID);
 	ia64_drop_fpu(current);
+#ifdef CONFIG_IA32_SUPPORT
 	if (IS_IA32_PROCESS(ia64_task_regs(current))) {
 		ia32_drop_partial_page_list(current);
 		current->thread.task_size = IA32_PAGE_OFFSET;
 		set_fs(USER_DS);
 	}
+#endif
 }
 
 /*
