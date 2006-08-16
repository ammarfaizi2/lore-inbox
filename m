Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWHPRLF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWHPRLF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWHPRKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:10:44 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:36574 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932114AbWHPRKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:10:41 -0400
Subject: [patch 2/5] -fstack-protector feature: Add the Kconfig option
From: Arjan van de Ven <arjan@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, ak@suse.de
In-Reply-To: <1155746902.3023.63.camel@laptopd505.fenrus.org>
References: <1155746902.3023.63.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 18:50:38 +0200
Message-Id: <1155747038.3023.67.camel@laptopd505.fenrus.org>
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
 arch/x86_64/Kconfig |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

Index: linux-2.6.18-rc4-stackprot/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.18-rc4-stackprot.orig/arch/x86_64/Kconfig
+++ linux-2.6.18-rc4-stackprot/arch/x86_64/Kconfig
@@ -522,6 +522,30 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config CC_STACKPROTECTOR
+	bool "Enable -fstack-protector buffer overflow detection (EXPRIMENTAL)"
+	depends on EXPERIMENTAL
+	help
+         This option turns on the -fstack-protector GCC feature. This
+	  feature puts, at the beginning of critical functions, a canary
+	  value on the stack just before the return address, and validates
+	  the value just before actually returning.  Stack based buffer
+	  overflows (that need to overwrite this return address) now also
+	  overwrite the canary, which gets detected and the attack is then
+	  neutralized via a kernel panic.
+
+	  This feature requires gcc version 4.2 or above, or a distribution
+	  gcc with the feature backported. Older versions are automatically
+	  detected and for those versions, this configuration option is ignored.
+
+config CC_STACKPROTECTOR_ALL
+	bool "Use stack-protector for all functions"
+	depends on CC_STACKPROTECTOR
+	help
+	  Normally, GCC only inserts the canary value protection for
+	  functions that use large-ish on-stack buffers. By enabling
+	  this option, GCC will be asked to do this for ALL functions.
+
 source kernel/Kconfig.hz
 
 config REORDER

