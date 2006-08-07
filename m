Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbWHGPtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWHGPtp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWHGPtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:49:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:8975 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932186AbWHGPto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:49:44 -0400
Date: Mon, 7 Aug 2006 17:49:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: [-mm patch] make arch/i386/kernel/apic.c:enable_local_apic static
Message-ID: <20060807154942.GD3691@stusta.de>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060806030809.2cfb0b1e.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

enable_local_apic can now become static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/kernel/apic.c |   13 ++++++++++++-
 include/asm-i386/apic.h |   12 ------------
 2 files changed, 12 insertions(+), 13 deletions(-)

--- linux-2.6.18-rc3-mm2-full/include/asm-i386/apic.h.old	2006-08-07 16:10:45.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/include/asm-i386/apic.h	2006-08-07 16:12:37.000000000 +0200
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
--- linux-2.6.18-rc3-mm2-full/arch/i386/kernel/apic.c.old	2006-08-07 16:11:08.000000000 +0200
+++ linux-2.6.18-rc3-mm2-full/arch/i386/kernel/apic.c	2006-08-07 16:12:57.000000000 +0200
@@ -52,7 +52,18 @@
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

