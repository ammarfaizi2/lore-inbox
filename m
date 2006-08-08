Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWHHESD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWHHESD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 00:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWHHESD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 00:18:03 -0400
Received: from koto.vergenet.net ([210.128.90.7]:11405 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932478AbWHHESA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 00:18:00 -0400
Date: Tue, 8 Aug 2006 12:46:47 +0900
From: Horms <horms@verge.net.au>
To: Russell King <rmk@arm.linux.org.uk>, Tony Luck <tony.luck@intel.com>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Andi Kleen <ak@suse.de>, Chris Zankel <chris@zankel.net>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linuxppc-dev@ozlabs.org, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Change panic_on_oops message to "Fatal exception"
Message-ID: <20060808034645.GA7658@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change panic_on_oops message to "Fatal exception"

Previously the message was "Fatal exception: panic_on_oops", as introduced
in a recent patch whith removed a somewhat dangerous call to ssleep() in
the panic_on_oops path.  However, Paul Mackerras suggested that this was
somewhat confusing, leadind people to believe that it was panic_on_oops
that was the root cause of the fatal exception. On his suggestion, this
patch changes the message to simply "Fatal exception".  A suitable oops
message should already have been displayed.

Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/kernel/traps.c     |    2 +-
 arch/i386/kernel/traps.c    |    2 +-
 arch/ia64/kernel/traps.c    |    2 +-
 arch/powerpc/kernel/traps.c |    2 +-
 arch/x86_64/kernel/traps.c  |    2 +-
 arch/xtensa/kernel/traps.c  |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 4e29dd0..aeeed80 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -233,7 +233,7 @@ NORET_TYPE void die(const char *str, str
 	spin_unlock_irq(&die_lock);
 
 	if (panic_on_oops)
-		panic("Fatal exception: panic_on_oops");
+		panic("Fatal exception");
 
 	do_exit(SIGSEGV);
 }
diff --git a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
index 0d4005d..82e0fd0 100644
--- a/arch/i386/kernel/traps.c
+++ b/arch/i386/kernel/traps.c
@@ -454,7 +454,7 @@ #endif
 		panic("Fatal exception in interrupt");
 
 	if (panic_on_oops)
-		panic("Fatal exception: panic_on_oops");
+		panic("Fatal exception");
 
 	oops_exit();
 	do_exit(SIGSEGV);
diff --git a/arch/ia64/kernel/traps.c b/arch/ia64/kernel/traps.c
index 5a04204..fffa9e0 100644
--- a/arch/ia64/kernel/traps.c
+++ b/arch/ia64/kernel/traps.c
@@ -118,7 +118,7 @@ die (const char *str, struct pt_regs *re
 	spin_unlock_irq(&die.lock);
 
 	if (panic_on_oops)
-		panic("Fatal exception: panic_on_oops");
+		panic("Fatal exception");
 
   	do_exit(SIGSEGV);
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 2105767..05682a2 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -151,7 +151,7 @@ #endif
 		panic("Fatal exception in interrupt");
 
 	if (panic_on_oops)
-		panic("Fatal exception: panic_on_oops");
+		panic("Fatal exception");
 
 	do_exit(err);
 
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index 4e9938d..14052f0 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -529,7 +529,7 @@ void __kprobes oops_end(unsigned long fl
 		/* Nest count reaches zero, release the lock. */
 		spin_unlock_irqrestore(&die_lock, flags);
 	if (panic_on_oops)
-		panic("Fatal exception: panic_on_oops");
+		panic("Fatal exception");
 }
 
 void __kprobes __die(const char * str, struct pt_regs * regs, long err)
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 9734960..ce077d6 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -488,7 +488,7 @@ #endif
 		panic("Fatal exception in interrupt");
 
 	if (panic_on_oops)
-		panic("Fatal exception: panic_on_oops");
+		panic("Fatal exception");
 
 	do_exit(err);
 }
-- 
1.4.1.gd3ba6

