Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129485AbQKVXLV>; Wed, 22 Nov 2000 18:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129645AbQKVXLL>; Wed, 22 Nov 2000 18:11:11 -0500
Received: from mgw-x2.nokia.com ([131.228.20.22]:15765 "EHLO mgw-x2.nokia.com")
        by vger.kernel.org with ESMTP id <S129485AbQKVXK7>;
        Wed, 22 Nov 2000 18:10:59 -0500
Date: Thu, 23 Nov 2000 00:40:50 +0200 (EET)
From: Kohtala Marko <kohtala@trshp.ntc.nokia.com>
Message-Id: <200011222240.AAA09984@laurel.trs.ntc.nokia.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] for /proc/cpuinfo MHz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cat /proc/cpuinfo shows like this for 2.4.0-test11 (also in ac2)
cpu MHz         : 132.000956

The "000" seems to be excess. linux/arch/i386/kernel/time.c has it
right in time_init().

diff -u linux/arch/i386/kernel/setup.c\~ linux/arch/i386/kernel/setup.c
--- linux/arch/i386/kernel/setup.c~	Wed Nov 22 21:43:15 2000
+++ linux/arch/i386/kernel/setup.c	Thu Nov 23 00:16:32 2000
@@ -2113,7 +2113,7 @@
 			p += sprintf(p, "stepping\t: unknown\n");
 
 		if ( test_bit(X86_FEATURE_TSC, &c->x86_capability) ) {
-			p += sprintf(p, "cpu MHz\t\t: %lu.%06lu\n",
+			p += sprintf(p, "cpu MHz\t\t: %lu.%03lu\n",
 				cpu_khz / 1000, (cpu_khz % 1000));
 		}

-- 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
