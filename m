Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUH1A3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUH1A3O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 20:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267872AbUH1A0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 20:26:30 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:17873 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S267867AbUH1AZ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 20:25:28 -0400
Subject: [RFC][PATCH] fix target_cpus() for summit subarch
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, James <jamesclv@us.ibm.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Content-Type: text/plain
Message-Id: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 27 Aug 2004 17:24:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hunting down a bug affecting IBM x440/x445 systems where the
floppy driver would get spurious interrupts and would not initialize
properly. 

After digging James Cleverdon pointed out that target_cpus() is routing
the interrupts to the clustered apic broadcast mask. This was causing
multiple interrupts to show up, breaking the floppy init code. 

This one-liner fix simply routes interrupts to the first cpu to resolve
this issue.

Any comments or feedback would be appreciated.

thanks
-john

===== include/asm-i386/mach-summit/mach_apic.h 1.38 vs edited =====
--- 1.38/include/asm-i386/mach-summit/mach_apic.h	2004-06-24 01:55:52 -07:00
+++ edited/include/asm-i386/mach-summit/mach_apic.h	2004-08-27 16:43:22 -07:00
@@ -19,7 +19,7 @@
 
 static inline cpumask_t target_cpus(void)
 {
-	return CPU_MASK_ALL;
+	return cpumask_of_cpu(0);
 } 
 #define TARGET_CPUS	(target_cpus())
 


