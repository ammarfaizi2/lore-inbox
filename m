Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWJERRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWJERRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 13:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbWJERRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 13:17:06 -0400
Received: from twin.jikos.cz ([213.151.79.26]:2482 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1750988AbWJERRF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 13:17:05 -0400
Date: Thu, 5 Oct 2006 19:16:14 +0200 (CEST)
From: Jiri Kosina <jikos@jikos.cz>
To: keith mannthey <kmannth@us.ibm.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] make mach-generic/summit.c compile on UP
Message-ID: <Pine.LNX.4.64.0610051913010.12556@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

arch/i386/mach-generic/summit.c doesn't compile (neither in current 
mainline git tree, nor in 2.6.18-mm3) when CONFIG_SMP is not set:

In file included from arch/i386/mach-generic/summit.c:17:
include/asm/mach-summit/mach_apic.h: In function 'apicid_to_node':
include/asm/mach-summit/mach_apic.h:91: error: 'apicid_2_node' undeclared (first use in this function)
include/asm/mach-summit/mach_apic.h:91: error: (Each undeclared identifier is reported only once
include/asm/mach-summit/mach_apic.h:91: error: for each function it appears in.)

Is the patch below correct?

Signed-off-by: Jiri Kosina <jikos@jikos.cz>

--- a/include/asm-i386/mach-summit/mach_apic.h
+++ b/include/asm-i386/mach-summit/mach_apic.h
@@ -88,7 +88,11 @@ static inline void clustered_apic_check(
 
 static inline int apicid_to_node(int logical_apicid)
 {
+#ifdef CONFIG_SMP
 	return apicid_2_node[hard_smp_processor_id()];
+#else
+	return 0;
+#endif
 }
 
 /* Mapping from cpu number to logical apicid */
diff --git a/include/asm-i386/smp.h b/include/asm-i386/smp.h

-- 
Jiri Kosina
