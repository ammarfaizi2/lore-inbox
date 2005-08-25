Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbVHYFVs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbVHYFVs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 01:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbVHYFVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 01:21:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1740 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751544AbVHYFVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 01:21:36 -0400
To: geert@linux-m68k.org, torvalds@osdl.org
Subject: [PATCH] (12/22) broken constraints on mulu.l
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Message-Id: <E1E8AED-0005cx-EY@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Thu, 25 Aug 2005 06:24:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

too permissive constraint on mulu.l - the first argument should not be
an a-register.  Fixed by replacing "g" with "dm"; with older gcc we got
lucky and it had never attempted mulu.l %a0, %d1:%d0.  These days it
does, with predictable objections from as(1).

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc7-m68k-reset/arch/m68k/math-emu/multi_arith.h RC13-rc7-m68k-mul/arch/m68k/math-emu/multi_arith.h
--- RC13-rc7-m68k-reset/arch/m68k/math-emu/multi_arith.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc7-m68k-mul/arch/m68k/math-emu/multi_arith.h	2005-08-25 00:54:13.000000000 -0400
@@ -366,7 +366,7 @@
 
 #define fp_mul64(desth, destl, src1, src2) ({				\
 	asm ("mulu.l %2,%1:%0" : "=d" (destl), "=d" (desth)		\
-		: "g" (src1), "0" (src2));				\
+		: "dm" (src1), "0" (src2));				\
 })
 #define fp_div64(quot, rem, srch, srcl, div)				\
 	asm ("divu.l %2,%1:%0" : "=d" (quot), "=d" (rem)		\
