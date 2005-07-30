Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263049AbVG3KeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263049AbVG3KeZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 06:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVG3KeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 06:34:25 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:44682 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263050AbVG3Kcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 06:32:42 -0400
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: local_irq_enable() in __do_softirq()?
From: Peter Osterlund <petero2@telia.com>
Date: 30 Jul 2005 12:32:30 +0200
Message-ID: <m3slxwmvnl.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The change "x86_64: Switch to the interrupt stack when running a
softirq in local_bh ..." (ed6b676ca8b50e0b538e61c283d52fd04f007abf)
contains this:

--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -86,7 +86,7 @@ restart:
 	/* Reset the pending bitmask before enabling irqs */
 	local_softirq_pending() = 0;
 
-	local_irq_enable();
+	//local_irq_enable();
 
 	h = softirq_vec;
 
@@ -99,7 +99,7 @@ restart:
 		pending >>= 1;
 	} while (pending);
 
-	local_irq_disable();
+	//local_irq_disable();
 
 	pending = local_softirq_pending();
 	if (pending && --max_restart)

Is that intentional? If so, shouldn't the code be removed instead of
commented out?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
