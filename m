Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318100AbSFTCTD>; Wed, 19 Jun 2002 22:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318099AbSFTCTC>; Wed, 19 Jun 2002 22:19:02 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:49864 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S318098AbSFTCTA>;
	Wed, 19 Jun 2002 22:19:00 -0400
Date: Thu, 20 Jun 2002 12:18:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Trivial Kernel Patches <trivial@rustcorp.com.au>, davidm@hpl.hp.com
Subject: [PATCH] dup_task_struct can be static
Message-Id: <20020620121813.4d1e075f.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

[There may be lots of these depending on how bored I get :-)]

dup_task_struct is defined and used only in kernel/fork.c.

[This is not quite true, as arch/ia64/kernel/process.c also
defines a global dup_task_struct function, but I don't know
how it could ever be called.]

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.23/kernel/fork.c 2.5.23-sfr.2/kernel/fork.c
--- 2.5.23/kernel/fork.c	Wed Jun 19 12:41:51 2002
+++ 2.5.23-sfr.2/kernel/fork.c	Thu Jun 20 12:03:27 2002
@@ -99,7 +99,7 @@
 	init_task.rlim[RLIMIT_NPROC].rlim_max = max_threads/2;
 }
 
-struct task_struct *dup_task_struct(struct task_struct *orig)
+static struct task_struct *dup_task_struct(struct task_struct *orig)
 {
 	struct task_struct *tsk;
 	struct thread_info *ti;
