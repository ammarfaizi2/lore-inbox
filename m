Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261807AbTC0IU3>; Thu, 27 Mar 2003 03:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261810AbTC0IU3>; Thu, 27 Mar 2003 03:20:29 -0500
Received: from holomorphy.com ([66.224.33.161]:4266 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261807AbTC0IU2>;
	Thu, 27 Mar 2003 03:20:28 -0500
Date: Thu, 27 Mar 2003 00:31:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: missing sched.h comments
Message-ID: <20030327083124.GN1350@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy up sched.h a bit.

(1) ->personality has a "???" comment sitting above it. Comment it.
(2) a comment referring to the nonexistent field ->father from before
	the pidhash merge persists. Remove the comment. The replacements
	are all already commented.
(3) ->did_exec, ->leader, ->used_math, and ->keep_capabilities are all
	boolean, and may fit into the same word. Also comment them.

 sched.h |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)


diff -urpN merge-2.5.66-9/include/linux/sched.h merge-2.5.66-10/include/linux/sched.h
--- merge-2.5.66-9/include/linux/sched.h	2003-03-24 14:00:00.000000000 -0800
+++ merge-2.5.66-10/include/linux/sched.h	2003-03-26 23:52:38.000000000 -0800
@@ -344,21 +344,16 @@ struct task_struct {
 	struct linux_binfmt *binfmt;
 	int exit_code, exit_signal;
 	int pdeath_signal;  /*  The signal sent when the parent dies  */
-	/* ??? */
-	unsigned long personality;
-	int did_exec:1;
+	unsigned long personality; /* personality, which ABI to emulate */
 	pid_t pid;
 	pid_t pgrp;
 	pid_t tty_old_pgrp;
 	pid_t session;
 	pid_t tgid;
-	/* boolean value for session group leader */
-	int leader;
-	/* 
-	 * pointers to (original) parent process, youngest child, younger sibling,
-	 * older sibling, respectively.  (p->father can be replaced with 
-	 * p->parent->pid)
-	 */
+	unsigned int leader:1,		/* the task is a session leader */
+		keep_capabilities:1,	/* keep caps after dropping uid 0 */
+		used_math:1,		/* whether the FPU was used */
+		did_exec:1;		/* has the process exec()'d */
 	struct task_struct *real_parent; /* real parent process (when being debugged) */
 	struct task_struct *parent;	/* parent process */
 	struct list_head children;	/* list of my children */
@@ -388,11 +383,9 @@ struct task_struct {
 	int ngroups;
 	gid_t	groups[NGROUPS];
 	kernel_cap_t   cap_effective, cap_inheritable, cap_permitted;
-	int keep_capabilities:1;
 	struct user_struct *user;
 /* limits */
 	struct rlimit rlim[RLIM_NLIMITS];
-	unsigned short used_math;
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
