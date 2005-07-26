Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVGZVN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVGZVN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGZVIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:08:21 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:14225 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262060AbVGZVGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:06:01 -0400
Date: Tue, 26 Jul 2005 14:05:56 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: PATCH: Define auxiliary vector size, AT_VECTOR_SIZE
Message-ID: <20050726210556.GA4663@lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The size of auxiliary vector is fixed at 42 in linux/sched.h. But
it isn't very obvious when looking at linux/elf.h. This patch adds
AT_VECTOR_SIZE so that we can change it if necessary when a new
vector is added.


H.J.
--- linux/include/linux/elf.h.auxv	2004-10-18 14:53:22.000000000 -0700
+++ linux/include/linux/elf.h	2005-07-26 10:39:26.000000000 -0700
@@ -178,6 +178,8 @@ typedef __s64	Elf64_Sxword;
 
 #define AT_SECURE 23   /* secure mode boolean */
 
+#define AT_VECTOR_SIZE  42 /* Size of auxiliary table.  */
+
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
--- linux/include/linux/sched.h.auxv	2005-07-19 09:01:33.000000000 -0700
+++ linux/include/linux/sched.h	2005-07-26 10:41:08.000000000 -0700
@@ -30,6 +30,8 @@
 #include <linux/pid.h>
 #include <linux/percpu.h>
 
+#include <linux/elf.h>	/* For AT_VECTOR_SIZE */
+
 struct exec_domain;
 extern int exec_shield;
 extern int exec_shield_randomize;
@@ -238,7 +240,7 @@ struct mm_struct {
 	unsigned long rss, anon_rss, total_vm, locked_vm, shared_vm;
 	unsigned long exec_vm, stack_vm, reserved_vm, def_flags;
 
-	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
+	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:2;
 	cpumask_t cpu_vm_mask;
