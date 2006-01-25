Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWAYHJe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWAYHJe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 02:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWAYHJe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 02:09:34 -0500
Received: from ns.intellilink.co.jp ([61.115.5.249]:52646 "EHLO
	mail.intellilink.co.jp") by vger.kernel.org with ESMTP
	id S1750746AbWAYHJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 02:09:33 -0500
Subject: [PATCH] Compilation of kexec/kdump broken in Linux 2.6.16-rc1
	(x86_64)
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: fastboot@lists.osdl.org
Cc: vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Wed, 25 Jan 2006 16:09:12 +0900
Message-Id: <1138172952.2370.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The compilation of kexec/kdump seems to be broken for x86_64.
Remove the dependency of kexec on CONFIG_IA32_EMULATION.

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.16-rc1-orig/include/asm-x86_64/kexec.h linux-2.6.16-rc1/include/asm-x86_64/kexec.h
--- linux-2.6.16-rc1-orig/include/asm-x86_64/kexec.h	2006-01-19 17:51:45.000000000 +0900
+++ linux-2.6.16-rc1/include/asm-x86_64/kexec.h	2006-01-19 17:41:13.000000000 +0900
@@ -1,8 +1,9 @@
 #ifndef _X86_64_KEXEC_H
 #define _X86_64_KEXEC_H
 
+#include <linux/string.h>
+
 #include <asm/page.h>
-#include <asm/proto.h>
 #include <asm/ptrace.h>
 
 /*
diff -urNp linux-2.6.16-rc1-orig/include/linux/elfcore.h linux-2.6.16-rc1/include/linux/elfcore.h
--- linux-2.6.16-rc1-orig/include/linux/elfcore.h	2006-01-03 12:21:10.000000000 +0900
+++ linux-2.6.16-rc1/include/linux/elfcore.h	2006-01-19 17:40:11.000000000 +0900
@@ -5,6 +5,7 @@
 #include <linux/signal.h>
 #include <linux/time.h>
 #include <linux/user.h>
+#include <linux/ptrace.h>
 
 struct elf_siginfo
 {


