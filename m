Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266926AbTBQHmG>; Mon, 17 Feb 2003 02:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266932AbTBQHmG>; Mon, 17 Feb 2003 02:42:06 -0500
Received: from holomorphy.com ([66.224.33.161]:44940 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266926AbTBQHmF>;
	Mon, 17 Feb 2003 02:42:05 -0500
Date: Sun, 16 Feb 2003 23:51:07 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: asm-i386/numaq.h fixes
Message-ID: <20030217075107.GA14324@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As can be seen from:

http://www-3.ibm.com/software/data/db2/benchmarks/050300.html

MAX_NUMNODES is 16 on NUMA-Q, not 8.

Also, PHYSADDR_TO_NID() needs to parenthesize its argument.

-- wli

===== include/asm-i386/numaq.h 1.5 vs edited =====
--- 1.5/include/asm-i386/numaq.h	Tue Jan  7 03:11:19 2003
+++ edited/include/asm-i386/numaq.h	Sun Feb 16 23:47:34 2003
@@ -37,8 +37,8 @@
 #define PAGES_PER_ELEMENT (16777216/256)
 
 #define pfn_to_pgdat(pfn) NODE_DATA(pfn_to_nid(pfn))
-#define PHYSADDR_TO_NID(pa) pfn_to_nid(pa >> PAGE_SHIFT)
-#define MAX_NUMNODES		8
+#define PHYSADDR_TO_NID(pa) pfn_to_nid((pa) >> PAGE_SHIFT)
+#define MAX_NUMNODES		16
 extern int pfn_to_nid(unsigned long);
 extern void get_memcfg_numaq(void);
 #define get_memcfg_numa() get_memcfg_numaq()
