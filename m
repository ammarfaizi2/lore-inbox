Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272577AbTHKNor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272592AbTHKNnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:43:46 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:28555 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S272589AbTHKNk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:40:56 -0400
To: torvalds@transmeta.com
From: davej@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Enable OOSTORE on Geode.
Message-Id: <E19mCuO-0003dC-00@tetrachloride>
Date: Mon, 11 Aug 2003 14:40:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Hiroshi Miura <miurahr@nttdata.co.jp>

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/cyrix.c linux-2.5/arch/i386/kernel/cpu/cyrix.c
--- bk-linus/arch/i386/kernel/cpu/cyrix.c	2003-04-10 06:01:09.000000000 +0100
+++ linux-2.5/arch/i386/kernel/cpu/cyrix.c	2003-07-13 06:03:44.000000000 +0100
@@ -109,7 +109,6 @@ static void __init check_cx686_slop(stru
 
 static void __init set_cx86_reorder(void)
 {
-#ifdef CONFIG_OOSTORE
 	u8 ccr3;
 
 	printk(KERN_INFO "Enable Memory access reorder on Cyrix/NSC processor.\n");
@@ -118,12 +117,9 @@ static void __init set_cx86_reorder(void
 
 	/* Load/Store Serialize to mem access disable (=reorder it)  */
 	setCx86(CX86_PCR0, getCx86(CX86_PCR0) & ~0x80);
-#ifdef CONFIG_NOHIGHMEM
 	/* set load/store serialize from 1GB to 4GB */
 	ccr3 |= 0xe0;
-#endif
 	setCx86(CX86_CCR3, ccr3);
-#endif	
 }
 
 static void __init set_cx86_memwb(void)
