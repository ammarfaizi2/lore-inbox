Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161020AbWHJFDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbWHJFDR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWHJFDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:03:17 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:21129 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161020AbWHJFDR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:03:17 -0400
Date: Thu, 10 Aug 2006 00:59:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: annotate the rest of entry.s::nmi
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@suse.de>, Jan Beulich <jbeulich@novell.com>
Message-ID: <200608100101_MC3-1-C796-F8CA@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part of the NMI handler is missing annotations.  Just moving
the RING0_INT_FRAME macro fixes it.  And additional comments
should warn anyone changing this to recheck the annotations.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.18-rc4-nb.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc4-nb/arch/i386/kernel/entry.S
@@ -750,6 +750,7 @@ ENTRY(nmi)
 	cmpl $sysenter_entry,12(%esp)
 	je nmi_debug_stack_check
 nmi_stack_correct:
+	/* We have a RING0_INT_FRAME here */
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
@@ -760,9 +761,12 @@ nmi_stack_correct:
 	CFI_ENDPROC
 
 nmi_stack_fixup:
+	RING0_INT_FRAME
 	FIX_STACK(12,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
+
 nmi_debug_stack_check:
+	/* We have a RING0_INT_FRAME here */
 	cmpw $__KERNEL_CS,16(%esp)
 	jne nmi_stack_correct
 	cmpl $debug,(%esp)
@@ -773,8 +777,10 @@ nmi_debug_stack_check:
 	jmp nmi_stack_correct
 
 nmi_16bit_stack:
-	RING0_INT_FRAME
-	/* create the pointer to lss back */
+	/* We have a RING0_INT_FRAME here.
+	 *
+	 * create the pointer to lss back
+	 */
 	pushl %ss
 	CFI_ADJUST_CFA_OFFSET 4
 	pushl %esp
-- 
Chuck
