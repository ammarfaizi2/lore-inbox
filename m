Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWHJTrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWHJTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWHJTq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:46:56 -0400
Received: from mail.suse.de ([195.135.220.2]:31377 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932682AbWHJTh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:26 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [126/145] i386: Make enable_local_apic static
Message-Id: <20060810193725.B178813B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:25 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Adrian Bunk <bunk@stusta.de>
enable_local_apic can now become static.

Cc: len.brown@intel.com

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andi Kleen <ak@suse.de>



---

 arch/i386/kernel/apic.c |   13 ++++++++++++-
 include/asm-i386/apic.h |   12 ------------
 2 files changed, 12 insertions(+), 13 deletions(-)

Index: linux/include/asm-i386/apic.h
===================================================================
--- linux.orig/include/asm-i386/apic.h
+++ linux/include/asm-i386/apic.h
@@ -16,20 +16,8 @@
 #define APIC_VERBOSE 1
 #define APIC_DEBUG   2
 
-extern int enable_local_apic;
 extern int apic_verbosity;
 
-static inline void lapic_disable(void)
-{
-	enable_local_apic = -1;
-	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
-}
-
-static inline void lapic_enable(void)
-{
-	enable_local_apic = 1;
-}
-
 /*
  * Define the default level of output to be very little
  * This can be turned up by using apic=verbose for more
Index: linux/arch/i386/kernel/apic.c
===================================================================
--- linux.orig/arch/i386/kernel/apic.c
+++ linux/arch/i386/kernel/apic.c
@@ -52,7 +52,18 @@ static cpumask_t timer_bcast_ipi;
 /*
  * Knob to control our willingness to enable the local APIC.
  */
-int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+static int enable_local_apic __initdata = 0; /* -1=force-disable, +1=force-enable */
+
+static inline void lapic_disable(void)
+{
+	enable_local_apic = -1;
+	clear_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
+}
+
+static inline void lapic_enable(void)
+{
+	enable_local_apic = 1;
+}
 
 /*
  * Debug level
