Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264389AbUHBXo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbUHBXo6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 19:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUHBXo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 19:44:57 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:10671 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264389AbUHBXon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 19:44:43 -0400
Date: Mon, 02 Aug 2004 16:44:04 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mikael Pettersson <mikpe@csd.uu.se>, Andrew Morton <akpm@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc2-mm2 warning on NUMA-Q
Message-ID: <154410000.1091490244@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch-i386-kernel-smpc-gcc341-inlining-fix.patch seems to cause
the following warning:

include/asm-i386/mach-numaq/mach_ipi.h:4: warning: static declaration for `send_
IPI_mask_sequence' follows non-static. 

This should fix it (and make it match the other subarches):

diff -purN -X /home/mbligh/.diff.exclude mm2/include/asm-i386/mach-numaq/mach_ipi.h send_IPI_mask_sequence/include/asm-i386/mach-numaq/mach_ipi.h
--- mm2/include/asm-i386/mach-numaq/mach_ipi.h	Wed Dec 17 18:59:16 2003
+++ send_IPI_mask_sequence/include/asm-i386/mach-numaq/mach_ipi.h	Mon Aug  2 15:55:27 2004
@@ -1,7 +1,7 @@
 #ifndef __ASM_MACH_IPI_H
 #define __ASM_MACH_IPI_H
 
-static inline void send_IPI_mask_sequence(cpumask_t, int vector);
+inline void send_IPI_mask_sequence(cpumask_t, int vector);
 
 static inline void send_IPI_mask(cpumask_t mask, int vector)
 {

