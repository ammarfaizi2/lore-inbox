Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVDLOQT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVDLOQT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 10:16:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVDLLI6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:08:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:26826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262252AbVDLKdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:13 -0400
Message-Id: <200504121032.j3CAWxmE005736@shell0.pdx.osdl.net>
Subject: [patch 147/198] cpuset: remove function attribute const
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, benoit.boissinot@ens-lyon.org,
       pj@sgi.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

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
Acked-by: Paul Jackson <pj@sgi.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/linux/cpuset.h |    2 +-
 25-akpm/kernel/cpuset.c        |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff -puN include/linux/cpuset.h~cpuset-remove-function-attribute-const include/linux/cpuset.h
--- 25/include/linux/cpuset.h~cpuset-remove-function-attribute-const	2005-04-12 03:21:38.639262840 -0700
+++ 25-akpm/include/linux/cpuset.h	2005-04-12 03:21:38.644262080 -0700
@@ -18,7 +18,7 @@ extern int cpuset_init(void);
 extern void cpuset_init_smp(void);
 extern void cpuset_fork(struct task_struct *p);
 extern void cpuset_exit(struct task_struct *p);
-extern const cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
+extern cpumask_t cpuset_cpus_allowed(const struct task_struct *p);
 void cpuset_init_current_mems_allowed(void);
 void cpuset_update_current_mems_allowed(void);
 void cpuset_restrict_to_mems_allowed(unsigned long *nodes);
diff -puN kernel/cpuset.c~cpuset-remove-function-attribute-const kernel/cpuset.c
--- 25/kernel/cpuset.c~cpuset-remove-function-attribute-const	2005-04-12 03:21:38.641262536 -0700
+++ 25-akpm/kernel/cpuset.c	2005-04-12 03:21:38.645261928 -0700
@@ -1432,7 +1432,7 @@ void cpuset_exit(struct task_struct *tsk
  * tasks cpuset.
  **/
 
-const cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
+cpumask_t cpuset_cpus_allowed(const struct task_struct *tsk)
 {
 	cpumask_t mask;
 
_
