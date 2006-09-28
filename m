Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWI1NJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWI1NJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 09:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbWI1NJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 09:09:09 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:31774 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161114AbWI1NJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 09:09:06 -0400
Date: Thu, 28 Sep 2006 15:09:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cborntra@de.ibm.com
Subject: [S390] config option for z9-109 code generation.
Message-ID: <20060928130904.GE1120@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <cborntra@de.ibm.com>

[S390] config option for z9-109 code generation.

Add a kernel config option for the IBM System z9. This will produce
faster code on newer compilers using the -march=z9-109 option.

Signed-off-by: Christian Borntraeger <cborntra@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig  |    8 ++++++++
 arch/s390/Makefile |    1 +
 2 files changed, 9 insertions(+)

diff -urpN linux-2.6/arch/s390/Kconfig linux-2.6-patched/arch/s390/Kconfig
--- linux-2.6/arch/s390/Kconfig	2006-09-28 14:58:55.000000000 +0200
+++ linux-2.6-patched/arch/s390/Kconfig	2006-09-28 14:58:55.000000000 +0200
@@ -153,6 +153,14 @@ config MARCH_Z990
 	  This will be slightly faster but does not work on
 	  older machines such as the z900.
 
+config MARCH_Z9_109
+	bool "IBM System z9"
+	help
+	  Select this to enable optimizations for IBM System z9-109, IBM
+	  System z9 Enterprise Class (z9 EC), and IBM System z9 Business
+	  Class (z9 BC). The kernel will be slightly faster but will not
+	  work on older machines such as the z990, z890, z900, and z800.
+
 endchoice
 
 config PACK_STACK
diff -urpN linux-2.6/arch/s390/Makefile linux-2.6-patched/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/arch/s390/Makefile	2006-09-28 14:58:55.000000000 +0200
@@ -33,6 +33,7 @@ endif
 cflags-$(CONFIG_MARCH_G5)   += $(call cc-option,-march=g5)
 cflags-$(CONFIG_MARCH_Z900) += $(call cc-option,-march=z900)
 cflags-$(CONFIG_MARCH_Z990) += $(call cc-option,-march=z990)
+cflags-$(CONFIG_MARCH_Z9_109) += $(call cc-option,-march=z9-109)
 
 #
 # Prevent tail-call optimizations, to get clearer backtraces:
