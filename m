Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161454AbWBUKTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161454AbWBUKTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 05:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932731AbWBUKTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 05:19:22 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:30389 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932730AbWBUKTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 05:19:22 -0500
Date: Tue, 21 Feb 2006 05:16:09 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: let signal handlers set the resume flag
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602210519_MC3-1-B8DF-2A98@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow signal handlers to set the RF bit in EFLAGS. This lets a
simple debugger using SIGTRAP skip one instruction after returning
from a signal.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.16-rc4-nb.orig/arch/i386/kernel/signal.c
+++ 2.6.16-rc4-nb/arch/i386/kernel/signal.c
@@ -123,7 +123,8 @@ restore_sigcontext(struct pt_regs *regs,
 	  err |= __get_user(tmp, &sc->seg);				\
 	  loadsegment(seg,tmp); }
 
-#define	FIX_EFLAGS	(X86_EFLAGS_AC | X86_EFLAGS_OF | X86_EFLAGS_DF | \
+#define	FIX_EFLAGS	(X86_EFLAGS_AC | X86_EFLAGS_RF |		 \
+			 X86_EFLAGS_OF | X86_EFLAGS_DF |		 \
 			 X86_EFLAGS_TF | X86_EFLAGS_SF | X86_EFLAGS_ZF | \
 			 X86_EFLAGS_AF | X86_EFLAGS_PF | X86_EFLAGS_CF)
 
-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
