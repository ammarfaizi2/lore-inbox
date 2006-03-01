Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWCAEk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWCAEk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWCAEk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:40:56 -0500
Received: from mail7.hitachi.co.jp ([133.145.228.42]:20151 "EHLO
	mail7.hitachi.co.jp") by vger.kernel.org with ESMTP id S932081AbWCAEkz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:40:55 -0500
Message-ID: <440525CD.4090505@sdl.hitachi.co.jp>
Date: Wed, 01 Mar 2006 13:40:45 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, ananth@in.ibm.com, prasanna@in.ibm.com,
       anil.s.keshavamurthy@intel.com
CC: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>,
       systemtap@sources.redhat.com, jkenisto@us.ibm.com,
       linux-kernel@vger.kernel.org, sugita@sdl.hitachi.co.jp,
       soshima@redhat.com, haoki@redhat.com
Subject: [PATCH] kprobe: kprobe-booster fix for NX support on i386
References: <43DE0A4D.20908@sdl.hitachi.co.jp>	<4402E920.5080402@sdl.hitachi.co.jp> <20060227185012.037c8830.akpm@osdl.org> <4403E894.4050300@sdl.hitachi.co.jp>
In-Reply-To: <4403E894.4050300@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew

Here is the patch to fix kprobe-booster against linux-2.6.16-rc5-mm1.
 - Fix to assign the correct address of the instruction buffer.
   From linux-2.6.16-rc5, the ainsn.insn on i386 arch became a pointer
   instead of an array itself.

Best regards,

-- 
Masami HIRAMATSU
2nd Research Dept.
Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp

Signed-off-by: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>

 kprobes.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
diff -Narup a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c	2006-03-01 09:53:22.000000000 +0900
+++ b/arch/i386/kernel/kprobes.c	2006-03-01 09:56:58.000000000 +0900
@@ -313,7 +313,7 @@ static int __kprobes kprobe_handler(stru
 	    !p->post_handler && !p->break_handler ) {
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
-		regs->eip = (unsigned long)&p->ainsn.insn;
+		regs->eip = (unsigned long)p->ainsn.insn;
 		preempt_enable_no_resched();
 		return 1;
 	}

