Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbWGYUUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWGYUUd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 16:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWGYUUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 16:20:33 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:8137 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750997AbWGYUUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 16:20:32 -0400
Date: Tue, 25 Jul 2006 16:15:16 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: switch_to(): misplaced parentheses
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607251616_MC3-1-C618-C015@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent changes in i386 __switch_to() have a misplaced closing
parenthesis causing an unlikely() to terminate early.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc2-32.orig/arch/i386/kernel/process.c
+++ 2.6.18-rc2-32/arch/i386/kernel/process.c
@@ -690,8 +690,8 @@ struct task_struct fastcall * __switch_t
 	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
-	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
-	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
+	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
+	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP)))
 		__switch_to_xtra(next_p, tss);
 
 	disable_tsc(prev_p, next_p);
-- 
Chuck
