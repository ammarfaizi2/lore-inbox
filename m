Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281126AbRKENCF>; Mon, 5 Nov 2001 08:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281127AbRKENB4>; Mon, 5 Nov 2001 08:01:56 -0500
Received: from holomorphy.com ([216.36.33.161]:9155 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S281126AbRKENBl>;
	Mon, 5 Nov 2001 08:01:41 -0500
Date: Mon, 5 Nov 2001 05:00:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] repair bootmem memory leak
Message-ID: <20011105050021.D26577@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While developing my fresh bootmem, the testing I did to ensure there
were no memory leaks discovered a caller leaking memory:


diff -urN linux-virgin/arch/i386/kernel/setup.c linux/arch/i386/kernel/setup.c
--- linux-virgin/arch/i386/kernel/setup.c	Fri Oct  5 14:45:00 2001
+++ linux/arch/i386/kernel/setup.c	Sat Oct 27 12:57:39 2001
@@ -926,7 +926,7 @@
 	 * bootmem allocator with an invalid RAM area.
 	 */
 	reserve_bootmem(HIGH_MEMORY, (PFN_PHYS(start_pfn) +
-			 bootmap_size + PAGE_SIZE-1) - (HIGH_MEMORY));
+			 		bootmap_size) - (HIGH_MEMORY));
 
 	/*
 	 * reserve physical page 0 - it's a special BIOS page on many boxes,

reserve_boootmem_core() already ensures that the endpoint of the
interval to reserve is rounded up to a page boundary, and so this
(demonstrably) leaks a page whenever
	PFN_PHYS(start_pfn) + bootmap_size + PAGE_SIZE -1
is not page-aligned.


Cheers,
Bill
-----------------
willir@us.ibm.com
