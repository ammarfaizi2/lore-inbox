Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbUKKH1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUKKH1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbUKKH1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:27:07 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:53907 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262178AbUKKH07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:26:59 -0500
Subject: Re: [PATCH 3/11] oprofile: i386 support for stack trace sampling
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: OProfile List <oprofile-list@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041110230347.7138f9d1.akpm@osdl.org>
References: <1099996693.1985.785.camel@hole.melbourne.sgi.com>
	 <20041110230347.7138f9d1.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-h1sYoCA6WbzaGDpz/eHI"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1100157990.5769.163.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 11 Nov 2004 18:26:30 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h1sYoCA6WbzaGDpz/eHI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2004-11-11 at 18:03, Andrew Morton wrote:
> Greg Banks <gnb@melbourne.sgi.com> wrote:
> >
> >  oprofile i386 arch updates, including some internal
> >  API changes and support for stack trace sampling.
> 
> It needs this to compile and link on x86_64.  No idea if it works...

Clearly, there has been zero testing on x86_64.  How about
we just disable the backtrace code on that platform until
it's been tested?

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-h1sYoCA6WbzaGDpz/eHI
Content-Disposition: attachment; filename=oprofile-callgraph-x86_64
Content-Type: text/plain; name=oprofile-callgraph-x86_64; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Disable the oprofile backtrace feature pulled into x86_64 from
i386 code, until it has been tested on x86_64.

Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>
---
 arch/i386/oprofile/init.c     |    4 ++++
 arch/x86_64/oprofile/Makefile |    1 +
 2 files changed, 5 insertions(+)

Index: linux/arch/x86_64/oprofile/Makefile
===================================================================
--- linux.orig/arch/x86_64/oprofile/Makefile	2004-10-19 07:53:43.%N +1000
+++ linux/arch/x86_64/oprofile/Makefile	2004-11-11 18:19:37.%N +1100
@@ -1,6 +1,7 @@
 #
 # oprofile for x86-64.
 # Just reuse the one from i386. 
+# Except for the backtrace code, which is not yet tested
 #
 
 obj-$(CONFIG_OPROFILE) += oprofile.o
Index: linux/arch/i386/oprofile/init.c
===================================================================
--- linux.orig/arch/i386/oprofile/init.c	2004-11-10 20:53:24.%N +1100
+++ linux/arch/i386/oprofile/init.c	2004-11-11 18:20:13.%N +1100
@@ -18,8 +18,10 @@
 extern int nmi_init(struct oprofile_operations * ops);
 extern int nmi_timer_init(struct oprofile_operations * ops);
 extern void nmi_exit(void);
+#ifndef CONFIG_X86_64
 extern void x86_backtrace(struct pt_regs * const regs, struct task_struct *,
     	    	    	  unsigned int depth);
+#endif
 
 
 void __init oprofile_arch_init(struct oprofile_operations * ops)
@@ -33,7 +35,9 @@ void __init oprofile_arch_init(struct op
 	if (ret < 0)
 		ret = nmi_timer_init(ops);
 #endif
+#ifndef CONFIG_X86_64
 	ops->backtrace = x86_backtrace;
+#endif
 }
 
 

--=-h1sYoCA6WbzaGDpz/eHI--

