Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266935AbTGGJly (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 05:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266939AbTGGJly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 05:41:54 -0400
Received: from m239.net195-132-57.noos.fr ([195.132.57.239]:138 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S266935AbTGGJlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 05:41:52 -0400
Date: Mon, 7 Jul 2003 11:56:12 +0200
From: Stelian Pop <stelian@popies.net>
To: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2.4.22-pre3] Export 'acpi_disabled' symbol to modules...
Message-ID: <20030707095612.GA1507@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	acpi-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

'acpi_disabled' is not exported by the current 2.4-pre kernel, but
is used by at least the sonypi module.

I have submitted a similar patch for 2.5 some weeks ago (and it got
applied) but for some reason the 2.4 ACPI branch don't have it.

Andy, Marcelo, please apply.

(Alan, a similar change is needed for -ac, but the current patch will
not apply on top of the ac tree. Do you want me to send you a patch
correcting this or you'll do the change by hand ?)

Thanks,

Stelian.

===== arch/i386/kernel/setup.c 1.68 vs edited =====
--- 1.68/arch/i386/kernel/setup.c	Mon Jun 23 08:41:25 2003
+++ edited/arch/i386/kernel/setup.c	Mon Jul  7 09:28:46 2003
@@ -107,6 +107,7 @@
 #include <linux/seq_file.h>
 #include <asm/processor.h>
 #include <linux/console.h>
+#include <linux/module.h>
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -175,10 +176,11 @@
 static u32 disabled_x86_caps[NCAPINTS] __initdata = { 0 };
 
 #ifdef CONFIG_ACPI_HT_ONLY
-int acpi_disabled __initdata = 1;
+int acpi_disabled = 1;
 #else
-int acpi_disabled __initdata = 0;
+int acpi_disabled = 0;
 #endif
+EXPORT_SYMBOL(acpi_disabled);
 
 extern int blk_nohighio;
 
===== arch/i386/kernel/Makefile 1.6 vs edited =====
--- 1.6/arch/i386/kernel/Makefile	Fri Jun 13 09:01:12 2003
+++ edited/arch/i386/kernel/Makefile	Mon Jul  7 09:28:57 2003
@@ -14,7 +14,7 @@
 
 O_TARGET := kernel.o
 
-export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o
+export-objs     := mca.o mtrr.o msr.o cpuid.o microcode.o i386_ksyms.o time.o setup.o
 
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o i8259.o ioport.o ldt.o setup.o time.o sys_i386.o \
-- 
Stelian Pop <stelian@popies.net>
