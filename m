Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129742AbRALDgL>; Thu, 11 Jan 2001 22:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130069AbRALDgB>; Thu, 11 Jan 2001 22:36:01 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:6796 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129742AbRALDf6>; Thu, 11 Jan 2001 22:35:58 -0500
Message-ID: <3A5E7B98.D575EF40@haque.net>
Date: Thu, 11 Jan 2001 22:35:52 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch[ 2.4.1-pre3 HAVE_XMM compile error
Content-Type: multipart/mixed;
 boundary="------------5BEF60DFBBBB4FBF6AD6D380"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------5BEF60DFBBBB4FBF6AD6D380
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

patch to let 2.4.1-pre3 compile on PIII
we are moving from HAVE_XMM to cpu_has_xmm right?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
--------------5BEF60DFBBBB4FBF6AD6D380
Content-Type: text/plain; charset=us-ascii;
 name="xmm-fix.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="xmm-fix.diff"

--- linux/include/asm-i386/xor.h.orig	Thu Jan 11 21:55:49 2001
+++ linux/include/asm-i386/xor.h	Thu Jan 11 22:22:18 2001
@@ -843,7 +843,7 @@
 	do {						\
 		xor_speed(&xor_block_8regs);		\
 		xor_speed(&xor_block_32regs);		\
-	        if (HAVE_XMM)				\
+	        if (cpu_has_xmm)				\
 			xor_speed(&xor_block_pIII_sse);	\
 	        if (md_cpu_has_mmx()) {			\
 	                xor_speed(&xor_block_pII_mmx);	\
@@ -855,4 +855,4 @@
    We may also be able to load into the L1 only depending on how the cpu
    deals with a load to a line that is being prefetched.  */
 #define XOR_SELECT_TEMPLATE(FASTEST) \
-	(HAVE_XMM ? &xor_block_pIII_sse : FASTEST)
+	(cpu_has_xmm ? &xor_block_pIII_sse : FASTEST)

--------------5BEF60DFBBBB4FBF6AD6D380--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
