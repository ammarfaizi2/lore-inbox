Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932911AbWCVWjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932911AbWCVWjw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 17:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932899AbWCVWgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 17:36:21 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:63537 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S932888AbWCVWfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 17:35:45 -0500
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Bob Picco <bob.picco@hp.com>, Andrew Morton <akpm@osdl.org>,
       IWAMOTO Toshihiro <iwamoto@valinux.co.jp>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Christoph Lameter <christoph@lameter.com>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Rik van Riel <riel@redhat.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-Id: <20060322223511.12658.80845.sendpatchset@twins.localnet>
In-Reply-To: <20060322223107.12658.14997.sendpatchset@twins.localnet>
References: <20060322223107.12658.14997.sendpatchset@twins.localnet>
Subject: [PATCH 24/34] mm: sum_cpu_var.patch
Date: Wed, 22 Mar 2006 23:35:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peter Zijlstra <a.p.zijlstra@chello.nl>

Much used per_cpu op by the additional policies.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

---

 include/linux/percpu.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: linux-2.6/include/linux/percpu.h
===================================================================
--- linux-2.6.orig/include/linux/percpu.h	2006-03-13 20:38:20.000000000 +0100
+++ linux-2.6/include/linux/percpu.h	2006-03-13 20:45:24.000000000 +0100
@@ -15,6 +15,11 @@
 #define get_cpu_var(var) (*({ preempt_disable(); &__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
 
+#define __sum_cpu_var(type, var) ({ __typeof__(type) sum = 0; \
+                                 int cpu; \
+                                 for_each_cpu(cpu) sum += per_cpu(var, cpu); \
+                                 sum; })
+
 #ifdef CONFIG_SMP
 
 struct percpu_data {
