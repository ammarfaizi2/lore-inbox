Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVDIMk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDIMk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 08:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVDIMk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 08:40:59 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:25063 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261338AbVDIMkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 08:40:51 -0400
Date: Sat, 9 Apr 2005 14:40:49 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Paul Jackson <pj@engr.sgi.com>
Subject: [PATCH] cpuset: remove function attribute const
Message-ID: <20050409124048.GD8908@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-4 warns with 
include/linux/cpuset.h:21: warning: type qualifiers ignored on function
return type

cpuset_cpus_allowed is declared with const
extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);

First const should be __attribute__((const)), but the gcc manual
explains that:

"Note that a function that has pointer arguments and examines the data
pointed to must not be declared const. Likewise, a function that calls a
non-const function usually must not be const. It does not make sense for
a const function to return void."

The following patch remove const from the function declaration.

Signed-off-by: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- ./kernel/cpuset.c.orig	2005-04-09 14:14:23.000000000 +0200
+++ ./kernel/cpuset.c	2005-04-09 14:15:19.000000000 +0200
@@ -1432,7 +1432,7 @@ void cpuset_exit(struct task_struct *tsk
  * tasks cpuset.
  **/
 
-const cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
+cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
 {
 	cpumask_t mask;
 
--- ./include/linux/cpuset.h.orig	2005-04-09 14:14:32.000000000 +0200
+++ ./include/linux/cpuset.h	2005-04-09 14:15:30.000000000 +0200
@@ -18,7 +18,7 @@ extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
-extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_current_mems_allowed(void);
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
