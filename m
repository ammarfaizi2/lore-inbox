Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbUDEJBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 05:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbUDEJBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 05:01:15 -0400
Received: from main.gmane.org ([80.91.224.249]:4510 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263171AbUDEJBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 05:01:13 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Marc Bevand <bevand_m@epita.fr>
Subject: [PATCH] x86_64 MCE handling
Date: Mon, 05 Apr 2004 11:00:34 +0200
Message-ID: <40712032.9070101@epita.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020008030802000604040109"
X-Complaints-To: usenet@sea.gmane.org
Cc: Andi Kleen <ak@suse.de>
X-Gmane-NNTP-Posting-Host: 213.41.133.51
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040326
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020008030802000604040109
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The attached patch fixes some x86_64 Machine Check Exceptions handling code.
It should apply cleanly to 2.6.5-rc3 or later.

-- 
Marc Bevand

--------------020008030802000604040109
Content-Type: text/x-patch;
 name="mce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mce.patch"

--- linux-2.6.5-rc3-libata2-speed/arch/x86_64/kernel/mce.c.orig	2004-04-04 23:13:09.263001424 +0200
+++ linux-2.6.5-rc3-libata2-speed/arch/x86_64/kernel/mce.c	2004-04-04 23:23:47.269600248 +0200
@@ -85,7 +85,7 @@
 	if (m->addr)
 		printk("ADDR %Lx ", m->addr);
 	if (m->misc)
-		printk("MISC %Lx ", m->addr); 	
+		printk("MISC %Lx ", m->misc); 	
 	printk("\n");
 }
 
@@ -160,7 +160,7 @@
 		if (m.status & MCI_STATUS_MISCV)
 			rdmsrl(MSR_IA32_MC0_MISC + i*4, m.misc);
 		if (m.status & MCI_STATUS_ADDRV)
-			rdmsrl(MSR_IA32_MC0_MISC + i*4, m.addr);
+			rdmsrl(MSR_IA32_MC0_ADDR + i*4, m.addr);
 
 		rdtscll(m.tsc);
 		wrmsrl(MSR_IA32_MC0_STATUS + i*4, 0);

--------------020008030802000604040109--

