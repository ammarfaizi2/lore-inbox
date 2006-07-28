Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWG1QHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWG1QHP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161165AbWG1QGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:06:49 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:30904 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1752028AbWG1QGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:06:44 -0400
Subject: [patch 2/5] Add the Kconfig option for the stackprotector feature
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1154102546.6416.9.camel@laptopd505.fenrus.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 18:03:46 +0200
Message-Id: <1154102627.6416.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch 2/5] Add the Kconfig option for the stackprotector feature
From: Arjan van de Ven <arjan@linux.intel.com>

This patch adds the config options for -fstack-protector.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
CC: Andi Kleen <ak@suse.de>

---
 arch/x86_64/Kconfig |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

Index: linux-2.6.18-rc2-git5-stackprot/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.18-rc2-git5-stackprot.orig/arch/x86_64/Kconfig
+++ linux-2.6.18-rc2-git5-stackprot/arch/x86_64/Kconfig
@@ -522,6 +522,31 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config CC_STACKPROTECTOR
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
+	  NOTE 
+	  This feature requires gcc version 4.2 or above, or a distribution
+	  gcc with the feature backported. For older gcc versions, this is a NOP.
+
+config CC_STACKPROTECTOR_ALL
+	bool "Use stack-protector for all functions"
+	depends on CC_STACKPROTECTOR
+	default n
+	help
+	  Normally, GCC only inserts the canary value protection for
+	  functions that use large-ish on-stack buffers. By enabling
+	  this option, GCC will be asked to do this for ALL functions.
+
 source kernel/Kconfig.hz
 
 config REORDER

