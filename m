Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268817AbUJEF3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268817AbUJEF3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 01:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268805AbUJEF3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 01:29:01 -0400
Received: from ozlabs.org ([203.10.76.45]:7139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268802AbUJEF2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 01:28:46 -0400
Date: Tue, 5 Oct 2004 15:26:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: trivial@rustcorp.com.au, Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [TRIVIAL, PPC64]  Remove redundant #ifdef CONFIG_ALTIVEC
Message-ID: <20041005052627.GD3695@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, trivial@rustcorp.com.au,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

arch/ppc64/kernel/process.c has an #ifdef CONFIG_ALTIVEC within an
#ifdef CONFIG_ALTIVEC.  This patch removes the inner one.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/ppc64/kernel/process.c
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/process.c	2004-10-05 10:08:10.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/process.c	2004-10-05 15:18:56.581996496 +1000
@@ -147,7 +147,6 @@
  */
 void flush_altivec_to_thread(struct task_struct *tsk)
 {
-#ifdef CONFIG_ALTIVEC
 	if (tsk->thread.regs) {
 		preempt_disable();
 		if (tsk->thread.regs->msr & MSR_VEC) {
@@ -158,7 +157,6 @@
 		}
 		preempt_enable();
 	}
-#endif
 }
 
 int dump_task_altivec(struct pt_regs *regs, elf_vrregset_t *vrregs)


-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
