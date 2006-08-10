Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWHJUNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWHJUNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751535AbWHJUMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:12:39 -0400
Received: from ns1.suse.de ([195.135.220.2]:45200 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932617AbWHJTgX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:23 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [66/145] x86_64: Use BUILD_BUG_ON in apic.c build sanity checking
Message-Id: <20060810193622.0A4F913B90@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:21 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

Makes code a little shorter.

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/apic.c |    5 +----
 1 files changed, 1 insertion(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/apic.c
===================================================================
--- linux.orig/arch/x86_64/kernel/apic.c
+++ linux/arch/x86_64/kernel/apic.c
@@ -265,8 +265,6 @@ void __init sync_Arb_IDs(void)
 				| APIC_DM_INIT);
 }
 
-extern void __error_in_apic_c (void);
-
 /*
  * An initial setup of the virtual wire mode.
  */
@@ -313,8 +311,7 @@ void __cpuinit setup_local_APIC (void)
 
 	value = apic_read(APIC_LVR);
 
-	if ((SPURIOUS_APIC_VECTOR & 0x0f) != 0x0f)
-		__error_in_apic_c();
+	BUILD_BUG_ON((SPURIOUS_APIC_VECTOR & 0x0f) != 0x0f);
 
 	/*
 	 * Double-check whether this APIC is really registered.
