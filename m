Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVCCQSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVCCQSF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 11:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbVCCQRj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:17:39 -0500
Received: from aun.it.uu.se ([130.238.12.36]:21975 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261937AbVCCQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:17:27 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16935.14471.919379.826792@alkaid.it.uu.se>
Date: Thu, 3 Mar 2005 17:17:11 +0100
To: paulus@samba.org, geert@linux-m68k.org
Cc: linuxppc-dev@ozlabs.org, linux-m68k@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][2.6.11] gcc4 fix for <asm-m68k/setup.h>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc4 generates compile errors when it sees declarations
of arrays of incomplete element types. <asm-m68k/setup.h>
has one such declaration, which unfortunately breaks ppc32
since <asm-ppc/setup.h> #includes <asm-m68k/setup.h>.

The fix in this case is to simply move the array declaration
to after the corresponding element type declaration.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -rupN linux-2.6.11/include/asm-m68k/setup.h linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h
--- linux-2.6.11/include/asm-m68k/setup.h	2004-12-25 12:16:22.000000000 +0100
+++ linux-2.6.11.gcc4-fixes-v2/include/asm-m68k/setup.h	2005-03-02 19:36:26.000000000 +0100
@@ -362,12 +362,13 @@ extern int m68k_is040or060;
 #ifndef __ASSEMBLY__
 extern int m68k_num_memory;		/* # of memory blocks found (and used) */
 extern int m68k_realnum_memory;		/* real # of memory blocks found */
-extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 
 struct mem_info {
 	unsigned long addr;		/* physical address of memory chunk */
 	unsigned long size;		/* length of memory chunk (in bytes) */
 };
+
+extern struct mem_info m68k_memory[NUM_MEMINFO];/* memory description */
 #endif
 
 #endif /* __KERNEL__ */
