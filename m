Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265212AbUHHKwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265212AbUHHKwd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 06:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265247AbUHHKwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 06:52:33 -0400
Received: from darwin.snarc.org ([81.56.210.228]:44254 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S265212AbUHHKwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 06:52:30 -0400
Date: Sun, 8 Aug 2004 12:52:36 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESENT] remove hardcoded offsets from ppc asm
Message-ID: <20040808105236.GB13798@snarc.org>
References: <20040807151838.GA6760@snarc.org> <1091921531.14102.2.camel@gaston> <20040808102512.GA13798@snarc.org> <1091960741.14105.22.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091960741.14105.22.camel@gaston>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040803i
From: Vincent Hanquez <tab@snarc.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 08, 2004 at 08:25:42PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2004-08-08 at 20:25, Vincent Hanquez wrote:
> 
> > Hi Benjamin, it seems to be the 'convention'. I did the same comment
> > some time ago to Brian Gerst with his patch for i386.
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=108454158825656&w=2
> > 
> > But if you prefer a smaller patch, without changing the constant
> > name, I can do that too.
> 
> I don't know about this "convention", we certainly don't apply it
> on ppc, I'd suggest doing the simpler patch instead.

ok thanks, here it is:

Signed-off-by: Vincent Hanquez <tab@snarc.org>

diff -Naur linux-2.6.8-rc3.orig/arch/ppc/kernel/asm-offsets.c linux-2.6.8-rc3/arch/ppc/kernel/asm-offsets.c
--- linux-2.6.8-rc3.orig/arch/ppc/kernel/asm-offsets.c	2004-08-07 16:19:55.000000000 +0200
+++ linux-2.6.8-rc3/arch/ppc/kernel/asm-offsets.c	2004-08-07 16:26:06.000000000 +0200
@@ -129,6 +129,13 @@
 	DEFINE(CPU_SPEC_FEATURES, offsetof(struct cpu_spec, cpu_features));
 	DEFINE(CPU_SPEC_SETUP, offsetof(struct cpu_spec, cpu_setup));
 
+	DEFINE(TI_TASK, offsetof(struct thread_info, task));
+	DEFINE(TI_EXECDOMAIN, offsetof(struct thread_info, exec_domain));
+	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
+	DEFINE(TI_LOCAL_FLAGS, offsetof(struct thread_info, local_flags));
+	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
+	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
+	
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 	return 0;
 }
diff -Naur linux-2.6.8-rc3.orig/include/asm-ppc/thread_info.h linux-2.6.8-rc3/include/asm-ppc/thread_info.h
--- linux-2.6.8-rc3.orig/include/asm-ppc/thread_info.h	2004-08-07 16:20:00.000000000 +0200
+++ linux-2.6.8-rc3/include/asm-ppc/thread_info.h	2004-08-07 16:26:06.000000000 +0200
@@ -65,16 +65,6 @@
  */
 #define THREAD_SIZE		8192	/* 2 pages */
 
-/*
- * Offsets in thread_info structure, used in assembly code
- */
-#define TI_TASK		0
-#define TI_EXECDOMAIN	4
-#define TI_FLAGS	8
-#define TI_LOCAL_FLAGS	12
-#define TI_CPU		16
-#define TI_PREEMPT	20
-
 #define PREEMPT_ACTIVE		0x4000000
 
 /*
