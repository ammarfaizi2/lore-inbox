Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262000AbVCLTEI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262000AbVCLTEI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 14:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVCLTEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 14:04:07 -0500
Received: from 166.Red-80-36-134.pooles.rima-tde.net ([80.36.134.166]:53802
	"EHLO 166.Red-80-36-134.pooles.rima-tde.net") by vger.kernel.org
	with ESMTP id S262000AbVCLTEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 14:04:01 -0500
Date: Sat, 12 Mar 2005 20:03:58 +0100
From: "Juan M. de la Torre" <jmtorre@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.11 does not handle IRQ #0 on IXP4xx ARM platforms
Message-ID: <20050312190358.GA14440@mobile>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


 The original get_irqnr_and_bse macro leave Z flag set when the IRQ
 being handled is #0, but the correct behaviour is to clear the flag
 when there is at least one IRQ to handle.
 
PS: Please CC me in the reply because i'm not subscribed to the list

-- 
/jm

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ixp4xx-irq0.patch"

--- linux-2.6.11/include/asm-arm/arch-ixp4xx/entry-macro.S	2005-03-12 19:53:03.000000000 +0100
+++ linux-2.6.11-new/include/asm-arm/arch-ixp4xx/entry-macro.S	2005-03-12 19:54:18.000000000 +0100
@@ -18,7 +18,7 @@
 		beq	1001f
 		clz     \irqnr, \irqstat
 		mov     \base, #31
-		subs    \irqnr, \base, \irqnr
+		sub     \irqnr, \base, \irqnr
 
 1001:
 		/*

--Q68bSM7Ycu6FN28Q--
