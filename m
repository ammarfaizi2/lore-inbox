Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWDNX7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWDNX7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 19:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWDNX7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 19:59:53 -0400
Received: from xenotime.net ([66.160.160.81]:32725 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751296AbWDNX7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 19:59:53 -0400
Date: Fri, 14 Apr 2006 17:02:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, hpa@zytor.com
Subject: [PATCH] x86 cpuid and msr notifier callback section mismatches
Message-Id: <20060414170219.5de714de.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Fix section mismatch warnings in x86 cpuid and msr
notifier callback functions.
We can't have these as init (discarded) code.

WARNING: arch/x86_64/kernel/cpuid.o - Section mismatch: reference to .init.text: from .data between 'cpuid_class_cpu_notifier' (at offset 0x0) and 'cpuid_fops'
WARNING: arch/x86_64/kernel/msr.o - Section mismatch: reference to .init.text: from .data between 'msr_class_cpu_notifier' (at offset 0x0) and 'msr_fops'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 arch/i386/kernel/cpuid.c |    2 +-
 arch/i386/kernel/msr.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2617-rc1g8.orig/arch/i386/kernel/cpuid.c
+++ linux-2617-rc1g8/arch/i386/kernel/cpuid.c
@@ -168,7 +168,7 @@ static int cpuid_class_device_create(int
 	return err;
 }
 
-static int __devinit cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+static int cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
 
--- linux-2617-rc1g8.orig/arch/i386/kernel/msr.c
+++ linux-2617-rc1g8/arch/i386/kernel/msr.c
@@ -251,7 +251,7 @@ static int msr_class_device_create(int i
 	return err;
 }
 
-static int __devinit msr_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
+static int msr_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
 {
 	unsigned int cpu = (unsigned long)hcpu;
 


---
