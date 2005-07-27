Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVG0A2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVG0A2J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbVG0A2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:28:03 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:61524 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262403AbVG0A0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:26:13 -0400
Date: Tue, 26 Jul 2005 17:26:08 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: akpm@osdl.org
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: define-auxiliary-vector-size-at_vector_size.patch added to -mm tree
Message-ID: <20050727002608.GA7469@lucon.org>
References: <200507262144.j6QLiJVC015284@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <200507262144.j6QLiJVC015284@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 26, 2005 at 02:46:20PM -0700, akpm@osdl.org wrote:
> 
> The patch titled
> 
>      Define auxiliary vector size, AT_VECTOR_SIZE
> 
> has been added to the -mm tree.  Its filename is
> 
>      define-auxiliary-vector-size-at_vector_size.patch
> 
> Patches currently in -mm which might be from hjl@lucon.org are
> 
> define-auxiliary-vector-size-at_vector_size.patch
> 
> 

My patch breaks x86_64 build. This patch will fix x86_64 build. I am
also enclosing the updated full patch.


H.J.
----
--- linux/arch/x86_64/ia32/ia32_binfmt.c.auxv	2005-07-08 11:50:04.000000000 -0700
+++ linux/arch/x86_64/ia32/ia32_binfmt.c	2005-07-26 16:13:58.312017331 -0700
@@ -9,6 +9,7 @@
 #include <linux/config.h> 
 #include <linux/stddef.h>
 #include <linux/rwsem.h>
+#define __ASM_X86_64_ELF_H 1
 #include <linux/sched.h>
 #include <linux/compat.h>
 #include <linux/string.h>
@@ -181,10 +182,7 @@ struct elf_prpsinfo
 
 #define user user32
 
-#define __ASM_X86_64_ELF_H 1
 #define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
-//#include <asm/ia32.h>
-#include <linux/elf.h>
 
 typedef struct user_i387_ia32_struct elf_fpregset_t;
 typedef struct user32_fxsr_struct elf_fpxregset_t;

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.6.12-auxv-1.patch"

--- linux/arch/x86_64/ia32/ia32_binfmt.c.auxv	2005-07-08 11:50:04.000000000 -0700
+++ linux/arch/x86_64/ia32/ia32_binfmt.c	2005-07-26 16:13:58.312017331 -0700
@@ -9,6 +9,7 @@
 #include <linux/config.h> 
 #include <linux/stddef.h>
 #include <linux/rwsem.h>
+#define __ASM_X86_64_ELF_H 1
 #include <linux/sched.h>
 #include <linux/compat.h>
 #include <linux/string.h>
@@ -181,10 +182,7 @@ struct elf_prpsinfo
 
 #define user user32
 
-#define __ASM_X86_64_ELF_H 1
 #define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))
-//#include <asm/ia32.h>
-#include <linux/elf.h>
 
 typedef struct user_i387_ia32_struct elf_fpregset_t;
 typedef struct user32_fxsr_struct elf_fpxregset_t;
--- linux/include/linux/elf.h.auxv	2005-03-01 23:37:49.000000000 -0800
+++ linux/include/linux/elf.h	2005-07-26 16:13:24.185651900 -0700
@@ -181,6 +181,8 @@ typedef __s64	Elf64_Sxword;
 
 #define AT_SECURE 23   /* secure mode boolean */
 
+#define AT_VECTOR_SIZE  42 /* Size of auxiliary table.  */
+
 typedef struct dynamic{
   Elf32_Sword d_tag;
   union{
--- linux/include/linux/sched.h.auxv	2005-07-08 11:50:09.000000000 -0700
+++ linux/include/linux/sched.h	2005-07-26 16:13:24.204648764 -0700
@@ -35,6 +35,8 @@
 #include <linux/topology.h>
 #include <linux/seccomp.h>
 
+#include <linux/elf.h>	/* For AT_VECTOR_SIZE */
+
 struct exec_domain;
 
 /*
@@ -243,7 +245,7 @@ struct mm_struct {
 	mm_counter_t _rss;
 	mm_counter_t _anon_rss;
 
-	unsigned long saved_auxv[42]; /* for /proc/PID/auxv */
+	unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/auxv */
 
 	unsigned dumpable:1;
 	cpumask_t cpu_vm_mask;

--BXVAT5kNtrzKuDFl--
