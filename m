Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262500AbUKRPmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262500AbUKRPmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbUKRPmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:42:49 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41912 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262500AbUKRPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:42:20 -0500
Date: Thu, 18 Nov 2004 08:42:19 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: discuss@x86-64.org, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ak@suse.de
Subject: [PATCH 2.6.10-rc2] x86_64: only single-step into signal handlers if the tracer asked for it
Message-ID: <20041118154219.GJ4583@smtp.west.cox.net>
References: <200411150203.iAF23Trb024677@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411150203.iAF23Trb024677@hera.kernel.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 08:56:31AM +0000, torvalds@ppc970.osdl.org wrote:

> ChangeSet 1.2159, 2004/11/15 00:56:31-08:00, torvalds@ppc970.osdl.org
> 
> 	x86: only single-step into signal handlers if the tracer
> 	asked for it.

x86_64 looks to have the same issue.  But I deferr to the experts (and
hope this isn't a dupe).

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.28/arch/x86_64/kernel/signal.c	2004-09-08 11:52:55 -07:00
+++ edited/arch/x86_64/kernel/signal.c	2004-11-18 08:27:59 -07:00
@@ -325,7 +325,7 @@
 
 	set_fs(USER_DS);
 	if (regs->eflags & TF_MASK) {
-		if (current->ptrace & PT_PTRACED) {
+		if ((current->ptrace & (PT_PTRACED | PT_DTRACE)) == (PT_PTRACED | PT_DTRACE)) {
 			ptrace_notify(SIGTRAP);
 		} else {
 			regs->eflags &= ~TF_MASK;

-- 
Tom Rini
http://gate.crashing.org/~trini/
