Return-Path: <linux-kernel-owner+w=401wt.eu-S1750903AbXACQVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXACQVk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 11:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbXACQVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 11:21:40 -0500
Received: from mail.parknet.jp ([210.171.160.80]:3851 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750903AbXACQVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 11:21:39 -0500
X-AuthUser: hirofumi@parknet.jp
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: Fix dump_trace()
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 04 Jan 2007 01:21:28 +0900
Message-ID: <87k604rshj.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If caller passed the tsk, we should use it to validate a stack ptr.
Otherwise, sysrq-t and other debugging stuff doesn't work.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 arch/x86_64/kernel/traps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/x86_64/kernel/traps.c~x86_64-fix-show_trace arch/x86_64/kernel/traps.c
--- linux-2.6/arch/x86_64/kernel/traps.c~x86_64-fix-show_trace	2007-01-04 00:28:02.000000000 +0900
+++ linux-2.6-hirofumi/arch/x86_64/kernel/traps.c	2007-01-04 00:28:02.000000000 +0900
@@ -319,7 +319,7 @@ void dump_trace(struct task_struct *tsk,
 	/*
 	 * This handles the process stack:
 	 */
-	tinfo = current_thread_info();
+	tinfo = task_thread_info(tsk);
 	HANDLE_STACK (valid_stack_ptr(tinfo, stack));
 #undef HANDLE_STACK
 	put_cpu();
_

-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
