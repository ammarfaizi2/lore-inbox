Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUFIUtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUFIUtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUFIUtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 16:49:55 -0400
Received: from aun.it.uu.se ([130.238.12.36]:14777 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265966AbUFIUtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 16:49:53 -0400
Date: Wed, 9 Jun 2004 22:49:32 +0200 (MEST)
Message-Id: <200406092049.i59KnW9D000615@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-rc3-mm1] CPU_MASK_NONE fix
Cc: linux-kernel@vger.kernel.org, pj@sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.7-rc3-mm1 changed CPU_MASK_NONE into something that isn't
a valid rvalue (it only works inside struct initializers).
This caused compile-time errors in perfctr in UP x86 builds.

Fix below.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.7-rc3-mm1/include/linux/cpumask.h linux-2.6.7-rc3-mm1.cpu_mask_none-fix/include/linux/cpumask.h
--- linux-2.6.7-rc3-mm1/include/linux/cpumask.h	2004-06-09 19:38:39.000000000 +0200
+++ linux-2.6.7-rc3-mm1.cpu_mask_none-fix/include/linux/cpumask.h	2004-06-09 22:01:28.470416000 +0200
@@ -248,9 +248,9 @@
 #endif
 
 #define CPU_MASK_NONE							\
-{ {									\
+((cpumask_t) { {							\
 	[0 ... BITS_TO_LONGS(NR_CPUS)-1] =  0UL				\
-} }
+} })
 
 #define cpus_addr(src) ((src).bits)
 
