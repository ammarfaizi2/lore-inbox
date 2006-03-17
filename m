Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030211AbWCQQSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbWCQQSD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:18:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWCQQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:17:45 -0500
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:49294 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1030204AbWCQQRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:17:25 -0500
Subject: [Patch 3 of 8] Introduce a config option for stack-protector
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1142611850.3033.100.camel@laptopd505.fenrus.org>
References: <1142611850.3033.100.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Mar 2006 17:13:01 +0100
Message-Id: <1142611981.3033.105.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the config options for -fstack-protector

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>

---
 arch/x86_64/Kconfig |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: linux-2.6.16-rc6-stack-protector/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.16-rc6-stack-protector.orig/arch/x86_64/Kconfig
+++ linux-2.6.16-rc6-stack-protector/arch/x86_64/Kconfig
@@ -462,6 +462,31 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config STACK_PROTECTOR
+	bool "Enable -fstack-protector buffer overflow detection (EXPRIMENTAL)"
+	depends on EXPERIMENTAL
+	default n
+	help
+	  This option turns on the -fstack-protector GCC feature that is new
+	  in GCC version 4.1. This feature puts, at the beginning of
+	  critical functions, a canary value on the stack just before the return
+	  address, and validates the value just before actually returning.
+	  Stack based buffer overflows that need to overwrite this return
+	  address now also overwrite the canary, which gets detected.
+
+	  NOTE NOTE NOTE
+	  At this point this requires a special, patched GCC compiler!
+	  Do not enable this unless you are using such a compiler.
+
+config STACK_PROTECTOR_ALL
+	bool "Use stack-protector for all functions"
+	depends on STACK_PROTECTOR
+	default n
+	help
+	  Normally, GCC only inserts the canary value protection for
+	  functions that use large-ish on-stack buffers. By enabling
+	  this option, GCC will be asked to do this for ALL functions.
+
 source kernel/Kconfig.hz
 
 endmenu

