Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263225AbUC3GBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 01:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263240AbUC3GBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 01:01:14 -0500
Received: from gate.crashing.org ([63.228.1.57]:60565 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263225AbUC3GBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 01:01:13 -0500
Subject: [PATCH] ppc64: More incorrect syscall error test
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080626458.1213.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 16:00:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, there was two different code path affected by this
bug (strace and normal) and I fixed only one. Here's the
other one:

===== arch/ppc64/kernel/entry.S 1.34 vs edited =====
--- 1.34/arch/ppc64/kernel/entry.S	Tue Mar 30 14:53:28 2004
+++ edited/arch/ppc64/kernel/entry.S	Tue Mar 30 15:59:43 2004
@@ -194,7 +194,7 @@
 _GLOBAL(ret_from_syscall_2)
 	std	r3,RESULT(r1)	/* Save result */	
 	li	r10,-_LAST_ERRNO
-	cmpl	0,r3,r10
+	cmpld	0,r3,r10
 	blt	60f
 	neg	r3,r3
 57:	ld	r10,_CCR(r1)	/* Set SO bit in CR */


