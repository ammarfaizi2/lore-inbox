Return-Path: <linux-kernel-owner+w=401wt.eu-S1751236AbXAIJms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbXAIJms (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 04:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbXAIJmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 04:42:47 -0500
Received: from pxy2nd.nifty.com ([202.248.175.14]:28302 "HELO pxy2nd.nifty.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751236AbXAIJmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 04:42:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=pxy2nd-default; d=mbf.nifty.com;
  b=Uus65zLS3DNCdYDb0gXnN1RkKL/Rdr9HiMamp5ui1I/hBWOcM3SgcckVgT78con0HhNHC+PgrPxPC1nuTz/abg==  ;
Date: Tue, 09 Jan 2007 18:41:56 +0900 (JST)
Message-Id: <20070109.184156.260789378.takada@mbf.nifty.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: fix typo in geode_configre()@cyrix.c
From: takada <takada@mbf.nifty.com>
X-Mailer: Mew version 5.1 on Emacs 22.0.92 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In kernel 2.6, write back wrong register when configure Geode processor.
Instead of storing to CCR4, it stores to CCR3.

--- linux-2.6.19/arch/i386/kernel/cpu/cyrix.c.orig	2007-01-09 16:45:21.000000000 +0900
+++ linux-2.6.19/arch/i386/kernel/cpu/cyrix.c	2007-01-09 17:10:13.000000000 +0900
@@ -173,7 +173,7 @@ static void __cpuinit geode_configure(vo
 	ccr4 = getCx86(CX86_CCR4);
 	ccr4 |= 0x38;		/* FPU fast, DTE cache, Mem bypass */
 	
-	setCx86(CX86_CCR3, ccr3);
+	setCx86(CX86_CCR4, ccr4);
 	
 	set_cx86_memwb();
 	set_cx86_reorder();	
