Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265519AbUADNN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 08:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUADNN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 08:13:57 -0500
Received: from pD952652A.dip.t-dialin.net ([217.82.101.42]:34949 "EHLO
	fred.muc.de") by vger.kernel.org with ESMTP id S265519AbUADNNy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 08:13:54 -0500
Date: Sun, 4 Jan 2004 14:13:50 +0100
From: Andi Kleen <ak@muc.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Remove Intel check in i386 HPET code
Message-ID: <20040104131350.GA21508@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The i386 HPET time setup code would explicitely check for the Intel
vendor ID. That is bogus because other chipset vendors (like AMD) 
are implementing HPET too. 

Remove this check.

-Andi

diff -u linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c~ linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c
--- linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c~	2004-01-04 14:10:59.000000000 +0100
+++ linux-2.6.1rc1-bk3-ia32/arch/i386/kernel/time_hpet.c	2004-01-04 14:10:59.000000000 +0100
@@ -91,10 +91,6 @@
 	    !(id & HPET_ID_LEGSUP))
 		return -1;
 
-	if (((id & HPET_ID_VENDOR) >> HPET_ID_VENDOR_SHIFT) !=
-				HPET_ID_VENDOR_8086)
-		return -1;
-
 	hpet_period = hpet_readl(HPET_PERIOD);
 	if ((hpet_period < HPET_MIN_PERIOD) || (hpet_period > HPET_MAX_PERIOD))
 		return -1;
