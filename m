Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263166AbUFCMR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbUFCMR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 08:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUFCMR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 08:17:29 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:43018 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S263166AbUFCMRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 08:17:11 -0400
Date: Thu, 3 Jun 2004 22:17:04 +1000
To: davej@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [CPUFREQ] Make powernow-k7 work with CONFIG_ACPI_PROCESSOR == m
Message-ID: <20040603121704.GB8164@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The last round of updates to powernow-k7.c broke it when
CONFIG_ACPI_PROCESSOR is built as a module.  This patch
fixes that.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== arch/i386/kernel/cpu/cpufreq/powernow-k7.c 1.51 vs edited =====
--- 1.51/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-05-08 00:34:07 +10:00
+++ edited/arch/i386/kernel/cpu/cpufreq/powernow-k7.c	2004-06-03 22:11:08 +10:00
@@ -28,7 +28,7 @@
 #include <asm/io.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 #include <linux/acpi.h>
 #include <acpi/processor.h>
 #endif
@@ -63,7 +63,7 @@
 	u8 numpstates;
 };
 
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 union powernow_acpi_control_t {
 	struct {
 		unsigned long fid:5,
@@ -293,7 +293,7 @@
 }
 
 
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 
 struct acpi_processor_performance *acpi_processor_perf;
 
@@ -642,7 +642,7 @@
 
 static void __exit powernow_exit (void)
 {
-#ifdef CONFIG_ACPI_PROCESSOR
+#if defined(CONFIG_ACPI_PROCESSOR) || defined(CONFIG_ACPI_PROCESSOR_MODULE)
 	if (acpi_processor_perf) {
 		acpi_processor_unregister_performance(acpi_processor_perf, 0);
 		kfree(acpi_processor_perf);

--O5XBE6gyVG5Rl6Rj--
