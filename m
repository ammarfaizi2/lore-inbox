Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268190AbTB1VfO>; Fri, 28 Feb 2003 16:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268198AbTB1VeY>; Fri, 28 Feb 2003 16:34:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48368 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268192AbTB1VdO>; Fri, 28 Feb 2003 16:33:14 -0500
Date: Fri, 28 Feb 2003 13:34:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 6/7 need PIT timer available for NUMA-Q
Message-ID: <361450000.1046468056@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This simple patch just makes sure the PIT code is available for NUMA-Q
(as its TSCs are not synced).

Has been tested in my tree for over a month on UP, SMP, and NUMA and 
compile tested against a variety of different configs.


diff -urpN -X /home/fletch/.diff.exclude 014-no_kirq/arch/i386/Kconfig 015-notsc/arch/i386/Kconfig
--- 014-no_kirq/arch/i386/Kconfig	Tue Feb 25 23:03:43 2003
+++ 015-notsc/arch/i386/Kconfig	Fri Feb 28 08:05:36 2003
@@ -337,11 +337,6 @@ config X86_ALIGNMENT_16
 	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
 	default y
 
-config X86_TSC
-	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2
-	default y
-
 config X86_GOOD_APIC
 	bool
 	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
@@ -493,6 +488,11 @@ config DISCONTIGMEM
 config HAVE_ARCH_BOOTMEM_NODE
 	bool
 	depends on NUMA
+	default y
+
+config X86_TSC
+	bool
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
 config X86_MCE

