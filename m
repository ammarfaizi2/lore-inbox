Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753140AbWKCGc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbWKCGc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 01:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbWKCGc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 01:32:57 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:22741 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1753140AbWKCGc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 01:32:56 -0500
Date: Fri, 3 Nov 2006 01:27:37 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: remove IOPL check on task switch
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Zachary Amsden <zach@vmware.com>, Andi Kleen <ak@suse.de>
Message-ID: <200611030130_MC3-1-D02A-DEB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

IOPL is implicitly saved and restored on task switch,
so explicit check is no longer needed.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.19-rc4-32smp.orig/arch/i386/kernel/process.c
+++ 2.6.19-rc4-32smp/arch/i386/kernel/process.c
@@ -681,12 +681,6 @@ struct task_struct fastcall * __switch_t
 		loadsegment(gs, next->gs);
 
 	/*
-	 * Restore IOPL if needed.
-	 */
-	if (unlikely(prev->iopl != next->iopl))
-		set_iopl_mask(next->iopl);
-
-	/*
 	 * Now maybe handle debug registers and/or IO bitmaps
 	 */
 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
-- 
Chuck
"Even supernovas have their duller moments."
