Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264560AbUH3WXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264560AbUH3WXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264571AbUH3WXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:23:13 -0400
Received: from smtp3.libero.it ([193.70.192.127]:6024 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id S264560AbUH3WXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:23:11 -0400
Date: Tue, 31 Aug 2004 00:24:14 +0200
From: Daniele Pala <dandario@libero.it>
To: linux-kernel@vger.kernel.org
Subject: [PPC] Trivial patch
Message-ID: <20040830222414.GA1612@SuperSoul>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem: 

arch/ppc/syslib/open_pic.c: In function `openpic_mapirq':
arch/ppc/syslib/open_pic.c:779: array index in non-array initializer
arch/ppc/syslib/open_pic.c:779: (near initialization for `irqdest')
arch/ppc/syslib/open_pic.c:779: warning: missing braces around initializer
arch/ppc/syslib/open_pic.c:779: warning: (near initialization for `irqdest.bits')
make[1]: *** [arch/ppc/syslib/open_pic.o] Error 1
make: *** [arch/ppc/syslib] Error 2

the fix:

--- open_pic.c	Mon Aug 30 11:16:07 2004
+++ open_pic_mod.c	Mon Aug 30 11:15:39 2004
@@ -776,7 +776,7 @@
 	if (ISR[irq] == 0)
 		return;
 	if (!cpus_empty(keepmask)) {
-		cpumask_t irqdest = { .bits[0] = openpic_read(&ISR[irq]->Destination) };
+		cpumask_t irqdest = { irqdest.bits[0] = openpic_read(&ISR[irq]->Destination) };
 		cpus_and(irqdest, irqdest, keepmask);
 		cpus_or(physmask, physmask, irqdest);
 	}


Please CC me privately, i'm not subscribed to the list. Cheers,

	Daniele
