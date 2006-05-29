Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWE2Vjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWE2Vjf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 17:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWE2VZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 17:25:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:45266 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751334AbWE2VYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 17:24:36 -0400
Date: Mon, 29 May 2006 23:24:57 +0200
From: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: [patch 22/61] lock validator:  add per_cpu_offset()
Message-ID: <20060529212457.GV3155@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529212109.GA2058@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Molnar <mingo@elte.hu>

add the per_cpu_offset() generic method. (used by the lock validator)

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 include/asm-generic/percpu.h |    2 ++
 include/asm-x86_64/percpu.h  |    2 ++
 2 files changed, 4 insertions(+)

Index: linux/include/asm-generic/percpu.h
===================================================================
--- linux.orig/include/asm-generic/percpu.h
+++ linux/include/asm-generic/percpu.h
@@ -7,6 +7,8 @@
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
+#define per_cpu_offset(x) (__per_cpu_offset[x])
+
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
Index: linux/include/asm-x86_64/percpu.h
===================================================================
--- linux.orig/include/asm-x86_64/percpu.h
+++ linux/include/asm-x86_64/percpu.h
@@ -14,6 +14,8 @@
 #define __per_cpu_offset(cpu) (cpu_pda(cpu)->data_offset)
 #define __my_cpu_offset() read_pda(data_offset)
 
+#define per_cpu_offset(x) (__per_cpu_offset(x))
+
 /* Separate out the type, so (int[3], foo) works. */
 #define DEFINE_PER_CPU(type, name) \
     __attribute__((__section__(".data.percpu"))) __typeof__(type) per_cpu__##name
