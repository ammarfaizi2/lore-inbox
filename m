Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161187AbWJDJkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161187AbWJDJkn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 05:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161191AbWJDJkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 05:40:43 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10707 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161187AbWJDJkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 05:40:42 -0400
Date: Wed, 4 Oct 2006 11:40:40 +0200
From: Jan Blunck <jblunck@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: [PATCH,TRIVIAL] Fix typo in "syntax error if percpu macros are incorrectly used" patch
Message-ID: <20061004094040.GB3137@hasse.suse.de>
MIME-Version: 1.0
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: inline; filename="percpu-simple-identifier-error-typo.diff"
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial typo fix in the "syntax error if percpu macros are incorrectly used"
patch. I misspelled "identifier" in all places. D'Oh!

Thanks to Dirk Mueller to point this out.

Signed-off-by: Jan Blunck <jblunck@suse.de>
---
 include/asm-generic/percpu.h |    2 +-
 include/asm-s390/percpu.h    |    4 ++--
 include/asm-x86_64/percpu.h  |    6 +++---
 include/linux/percpu.h       |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

Index: linux-2.6/include/asm-generic/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-generic/percpu.h
+++ linux-2.6/include/asm-generic/percpu.h
@@ -15,7 +15,7 @@ extern unsigned long __per_cpu_offset[NR
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*({				\
-	extern int simple_indentifier_##var(void);	\
+	extern int simple_identifier_##var(void);	\
 	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset[cpu]); }))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
 #define __raw_get_cpu_var(var) per_cpu(var, raw_smp_processor_id())
Index: linux-2.6/include/asm-s390/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-s390/percpu.h
+++ linux-2.6/include/asm-s390/percpu.h
@@ -16,7 +16,7 @@
 #if defined(__s390x__) && defined(MODULE)
 
 #define __reloc_hide(var,offset) (*({			\
-	extern int simple_indentifier_##var(void);	\
+	extern int simple_identifier_##var(void);	\
 	unsigned long *__ptr;				\
 	asm ( "larl %0,per_cpu__"#var"@GOTENT"		\
 	    : "=a" (__ptr) : "X" (per_cpu__##var) );	\
@@ -25,7 +25,7 @@
 #else
 
 #define __reloc_hide(var, offset) (*({				\
-	extern int simple_indentifier_##var(void);		\
+	extern int simple_identifier_##var(void);		\
 	unsigned long __ptr;					\
 	asm ( "" : "=a" (__ptr) : "0" (&per_cpu__##var) );	\
 	(typeof(&per_cpu__##var)) (__ptr + (offset)); }))
Index: linux-2.6/include/asm-x86_64/percpu.h
===================================================================
--- linux-2.6.orig/include/asm-x86_64/percpu.h
+++ linux-2.6/include/asm-x86_64/percpu.h
@@ -32,13 +32,13 @@
 
 /* var is in discarded region: offset to particular copy we want */
 #define per_cpu(var, cpu) (*({				\
-	extern int simple_indentifier_##var(void);	\
+	extern int simple_identifier_##var(void);	\
 	RELOC_HIDE(&per_cpu__##var, __per_cpu_offset(cpu)); }))
 #define __get_cpu_var(var) (*({				\
-	extern int simple_indentifier_##var(void);	\
+	extern int simple_identifier_##var(void);	\
 	RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()); }))
 #define __raw_get_cpu_var(var) (*({			\
-	extern int simple_indentifier_##var(void);	\
+	extern int simple_identifier_##var(void);	\
 	RELOC_HIDE(&per_cpu__##var, __my_cpu_offset()); }))
 
 /* A macro to avoid #include hell... */
Index: linux-2.6/include/linux/percpu.h
===================================================================
--- linux-2.6.orig/include/linux/percpu.h
+++ linux-2.6/include/linux/percpu.h
@@ -19,7 +19,7 @@
  * we force a syntax error here if it isn't.
  */
 #define get_cpu_var(var) (*({				\
-	extern int simple_indentifier_##var(void);	\
+	extern int simple_identifier_##var(void);	\
 	preempt_disable();				\
 	&__get_cpu_var(var); }))
 #define put_cpu_var(var) preempt_enable()
