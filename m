Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262585AbUEKI4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUEKI4h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 04:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbUEKI4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 04:56:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:41093 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262499AbUEKIyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 04:54:04 -0400
Date: Tue, 11 May 2004 01:53:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, torvalds@osdl.org, marcelo.tosatti@cyclades.com
Subject: [PATCH 6/11] remove unused queued_signals global accounting
Message-ID: <20040511015357.E21045@build.pdx.osdl.net>
References: <20040511014232.Y21045@build.pdx.osdl.net> <20040511014524.Z21045@build.pdx.osdl.net> <20040511014639.A21045@build.pdx.osdl.net> <20040511014833.B21045@build.pdx.osdl.net> <20040511015015.C21045@build.pdx.osdl.net> <20040511015219.D21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040511015219.D21045@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, May 11, 2004 at 01:52:20AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused queued_signals global accounting.

===== kernel/signal.c 1.115 vs edited =====
--- 1.115/kernel/signal.c	Mon May 10 03:04:00 2004
+++ edited/kernel/signal.c	Mon May 10 16:16:13 2004
@@ -31,9 +31,6 @@
 
 static kmem_cache_t *sigqueue_cachep;
 
-atomic_t nr_queued_signals;
-int max_queued_signals = 1024;
-
 /*
  * In POSIX a signal is sent either to a specific thread (Linux task)
  * or to the process as a whole (Linux thread group).  How the signal
===== kernel/sysctl.c 1.72 vs edited =====
--- 1.72/kernel/sysctl.c	Mon May 10 04:25:53 2004
+++ edited/kernel/sysctl.c	Mon May 10 16:16:13 2004
@@ -53,8 +53,6 @@
 extern int sysctl_overcommit_memory;
 extern int sysctl_overcommit_ratio;
 extern int max_threads;
-extern atomic_t nr_queued_signals;
-extern int max_queued_signals;
 extern int sysrq_enabled;
 extern int core_uses_pid;
 extern char core_pattern[];
@@ -429,22 +427,6 @@
 		.proc_handler	= &proc_dointvec,
 	},
 #endif
-	{
-		.ctl_name	= KERN_RTSIGNR,
-		.procname	= "rtsig-nr",
-		.data		= &nr_queued_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0444,
-		.proc_handler	= &proc_dointvec,
-	},
-	{
-		.ctl_name	= KERN_RTSIGMAX,
-		.procname	= "rtsig-max",
-		.data		= &max_queued_signals,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
 #ifdef CONFIG_SYSVIPC
 	{
 		.ctl_name	= KERN_SHMMAX,

