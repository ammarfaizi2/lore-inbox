Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965134AbWHQRNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965134AbWHQRNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 13:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbWHQRNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 13:13:35 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2214 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965134AbWHQRNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 13:13:34 -0400
Date: Thu, 17 Aug 2006 22:44:05 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Beulich <jbeulich@novell.com>, jeremy@goop.org, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: [PATCH] Kprobes - x86_64 add KPROBE_END macro for .popsection
Message-ID: <20060817171405.GA7973@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replace .popsection with the KPROBE_END() macro, as
suggested by Jan Beulich similar to i386 architecture. This will
be helpful for the conversions ike the recent .section -> .pushsection
and .previous -> .popsection to be confined to the header defining
these macros, without need to touch any assembly files.

Signed-off-by: Prasanna S. P. <prasanna@in.ibm.com>


 arch/x86_64/kernel/entry.S |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff -puN arch/x86_64/kernel/entry.S~kprobes-x86_64-add-popsection-macro-for-assembly-stub arch/x86_64/kernel/entry.S
--- linux-2.6.18-rc4-mm1/arch/x86_64/kernel/entry.S~kprobes-x86_64-add-popsection-macro-for-assembly-stub	2006-08-17 12:21:28.000000000 +0530
+++ linux-2.6.18-rc4-mm1-prasanna/arch/x86_64/kernel/entry.S	2006-08-17 12:23:57.000000000 +0530
@@ -903,8 +903,7 @@ error_kernelspace:
 	cmpq $gs_change,RIP(%rsp)
         je   error_swapgs
 	jmp  error_sti
-END(error_entry)
-	.popsection
+KPROBE_END(error_entry)
 	
        /* Reload gs selector with exception handling */
        /* edi:  new selector */ 
@@ -1023,8 +1022,7 @@ ENDPROC(execve)
 
 KPROBE_ENTRY(page_fault)
 	errorentry do_page_fault
-END(page_fault)
-	.popsection
+KPROBE_END(page_fault)
 
 ENTRY(coprocessor_error)
 	zeroentry do_coprocessor_error
@@ -1045,8 +1043,7 @@ KPROBE_ENTRY(debug)
 	CFI_ADJUST_CFA_OFFSET 8		
 	paranoidentry do_debug, DEBUG_STACK
 	paranoidexit
-END(debug)
-	.popsection
+KPROBE_END(debug)
 
 	/* runs on exception stack */	
 KPROBE_ENTRY(nmi)
@@ -1060,8 +1057,7 @@ KPROBE_ENTRY(nmi)
 	jmp paranoid_exit1
  	CFI_ENDPROC
 #endif
-END(nmi)
-	.popsection
+KPROBE_END(nmi)
 
 KPROBE_ENTRY(int3)
  	INTR_FRAME
@@ -1070,8 +1066,7 @@ KPROBE_ENTRY(int3)
  	paranoidentry do_int3, DEBUG_STACK
  	jmp paranoid_exit1
  	CFI_ENDPROC
-END(int3)
-	.popsection
+KPROBE_END(int3)
 
 ENTRY(overflow)
 	zeroentry do_overflow
@@ -1119,8 +1114,7 @@ END(stack_segment)
 
 KPROBE_ENTRY(general_protection)
 	errorentry do_general_protection
-END(general_protection)
-	.popsection
+KPROBE_END(general_protection)
 
 ENTRY(alignment_check)
 	errorentry do_alignment_check

_
-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
