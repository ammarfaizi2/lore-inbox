Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWHDTfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWHDTfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 15:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbWHDTfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 15:35:01 -0400
Received: from www.osadl.org ([213.239.205.134]:57779 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932489AbWHDTfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 15:35:01 -0400
Subject: [PATCH] futex: Apply recent futex fixes to futex_compat
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Olaf Hering <olaf@aepfle.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060803192302.GA6049@aepfle.de>
References: <20060802053821.GA24356@aepfle.de>
	 <20060803192302.GA6049@aepfle.de>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 21:35:21 +0200
Message-Id: <1154720121.5932.239.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent fixups in futex.c need to be applied to futex_compat.c too.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/kernel/futex_compat.c b/kernel/futex_compat.c
index d1aab1a..c5cca3f 100644
--- a/kernel/futex_compat.c
+++ b/kernel/futex_compat.c
@@ -39,7 +39,7 @@ void compat_exit_robust_list(struct task
 {
 	struct compat_robust_list_head __user *head = curr->compat_robust_list;
 	struct robust_list __user *entry, *pending;
-	unsigned int limit = ROBUST_LIST_LIMIT, pi;
+	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
 	compat_uptr_t uentry, upending;
 	compat_long_t futex_offset;
 
@@ -59,10 +59,10 @@ void compat_exit_robust_list(struct task
 	 * if it exists:
 	 */
 	if (fetch_robust_entry(&upending, &pending,
-			       &head->list_op_pending, &pi))
+			       &head->list_op_pending, &pip))
 		return;
 	if (upending)
-		handle_futex_death((void *)pending + futex_offset, curr, pi);
+		handle_futex_death((void *)pending + futex_offset, curr, pip);
 
 	while (compat_ptr(uentry) != &head->list) {
 		/*


