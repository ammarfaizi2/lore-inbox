Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262711AbTDNCXE (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 22:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262713AbTDNCXD (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 22:23:03 -0400
Received: from dhcp065-024-013-119.columbus.rr.com ([65.24.13.119]:37512 "EHLO
	united.lan.codewhore.org") by vger.kernel.org with ESMTP
	id S262711AbTDNCXC (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 22:23:02 -0400
Date: Sun, 13 Apr 2003 22:26:18 -0400
From: David Brown <dave@codewhore.org>
To: Robert Love <rml@tech9.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
Message-ID: <20030414022618.GA8993@codewhore.org>
References: <20030412152951.GA10367@codewhore.org> <1050271044.767.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050271044.767.7.camel@localhost>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 13, 2003 at 05:57:24PM -0400, Robert Love wrote:
| On Sat, 2003-04-12 at 11:29, David Brown wrote:
| 
| > I recently applied the preempt-kernel-rml-2.4.21-pre1-1.patch from
| > kernel.org to BenH's stable tree from rsync.penguinppc.org.
| 
| Oh, one other thing.  An updated patch for 2.4.20 is up:
| 
| http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-2.4.20-2.patch
| 
| It has a couple fixes for proper protection of per-CPU data, including
| some PPC-specific ones.


Hi Robert:

AFAICT, the leak is still there. I'll be looking at that in a bit. I
used the following to get it to compile on the PPC box. I'm not sure if
it's 100% correct, but it appears to work:


diff -ur linux-2.4.20-preempt/arch/ppc/kernel/mk_defs.c linux-2.4.20-ben/arch/ppc/kernel/mk_defs.c
--- linux-2.4.20-preempt/arch/ppc/kernel/mk_defs.c	2003-04-12 02:57:31.000000000 -0400
+++ linux-2.4.20-ben/arch/ppc/kernel/mk_defs.c	2003-04-13 13:57:00.000000000 -0400
@@ -44,6 +44,7 @@
 	DEFINE(MM, offsetof(struct task_struct, mm));
 #ifdef CONFIG_PREEMPT
 	DEFINE(PREEMPT_COUNT, offsetof(struct task_struct, preempt_count));
+	DEFINE(CPU, offsetof(struct task_struct, processor));
 #endif
 	DEFINE(ACTIVE_MM, offsetof(struct task_struct, active_mm));
 	DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));


It just adds a DEFINE() for the use of CPU() in arch/ppc/kernel/entry.S.


Thanks,

- Dave

