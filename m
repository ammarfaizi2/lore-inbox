Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264982AbUETHG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264982AbUETHG5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265015AbUETHG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:06:57 -0400
Received: from ozlabs.org ([203.10.76.45]:38540 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264982AbUETHGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:06:55 -0400
Date: Thu, 20 May 2004 17:05:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Trivial ppc64 cleanup
Message-ID: <20040520070540.GH32471@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

The ppc64 head.S contains an enable_32b_mode function which is used
nowhere.  This patch removes it.

Index: working-2.6/arch/ppc64/kernel/head.S
===================================================================
--- working-2.6.orig/arch/ppc64/kernel/head.S	2004-05-20 12:57:52.000000000 +1000
+++ working-2.6/arch/ppc64/kernel/head.S	2004-05-20 16:37:58.061146128 +1000
@@ -1955,21 +1955,6 @@
 	isync
 	blr
 
-/*
- * This subroutine clobbers r11, r12 and the LR
- */
-_GLOBAL(enable_32b_mode)
-	mfmsr   r11                      /* grab the current MSR */
-	li      r12,1
-	rldicr  r12,r12,MSR_SF_LG,(63-MSR_SF_LG)
-	andc	r11,r11,r12
-	li      r12,1
-	rldicr  r12,r12,MSR_ISF_LG,(63-MSR_ISF_LG)
-	andc	r11,r11,r12
-	mtmsrd  r11
-	isync
-	blr
-
 #ifdef CONFIG_PPC_PSERIES
 /*
  * This is where the main kernel code starts.



-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
