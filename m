Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262077AbUK3N4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262077AbUK3N4N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUK3N4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:56:13 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:46226 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S262077AbUK3N4H convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:56:07 -0500
From: =?iso-8859-1?q?S=F8ren_N=F8hr_Christensen?= <snc@cs.aau.dk>
Organization: AAU
To: linux-kernel@vger.kernel.org
Subject: Syscall trouble
Date: Tue, 30 Nov 2004 14:55:19 +0100
User-Agent: KMail/1.7.1
Cc: umbrella@cs.aau.dk
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411301455.19143.snc@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I have implemented a systemcall against linux-2.6.8.1 using the following 
patches:


--- linux-2.6.8.1-clean/arch/i386/kernel/entry.S        2004-08-14 
12:55:09.000000000 +0200
+++ linux-2.6.8.1/arch/i386/kernel/entry.S      2004-11-30 14:48:36.000000000 
+0100
@@ -887,4 +887,7 @@
        .long sys_mq_getsetattr
        .long sys_ni_syscall            /* reserved for kexec */

+       .long sys_umb_set_child_restrictions

 syscall_table_size=(.-sys_call_table)


--- linux-2.6.8.1-clean/include/asm-i386/unistd.h       2004-08-14 
12:55:35.000000000 +0200
+++ linux-2.6.8.1/include/asm-i386/unistd.h     2004-11-30 14:48:36.000000000 
+0100
@@ -290,8 +290,13 @@
 #define __NR_mq_getsetattr     (__NR_mq_open+5)
 #define __NR_sys_kexec_load    283

-#define NR_syscalls 284
-
+#define __NR_umb_set_child_restrictions       284
+
+#define NR_syscalls 285

 /* user-visible error numbers are in the range -1 - -124: see 
<asm-i386/errno.h> */

 #define __syscall_return(type, res) \


This works like a charm. If i apply this to linux-2.6.9 it does not work 
anymore. The syscall is in kallsyms, but nothing happens when I call it.


Any suggestions?

What am I missing?

//snc


----------------
Søren Nøhr Christensen
Computer Science @ AAU
snc@cs.aau.dk
