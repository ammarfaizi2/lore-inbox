Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbUBUA0Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbUBUA0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:26:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:61611 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261449AbUBUAYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:24:50 -0500
Subject: Re: Fix silly thinko in sungem network driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <1077322322.9623.34.camel@gaston>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	 <1077321849.9719.32.camel@gaston>  <1077322322.9623.34.camel@gaston>
Content-Type: text/plain
Message-Id: <1077322751.10864.3.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:19:13 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Here it is:
>
> .../...

And here's the version without the typo 

(I shall not code before having breakfast...)

--- linux-2.5/drivers/net/sungem.c	2004-02-21 11:10:33.390479384 +1100
+++ linuxppc-2.5-benh/drivers/net/sungem.c	2004-02-21 11:18:23.396027680 +1100
@@ -1837,7 +1837,8 @@
 	 * thresholds (and Apple bug fixes don't exist)
 	 */
 	if (!(readl(gp->regs + GREG_CFG) & GREG_CFG_IBURST)) {
-		cfg = ((2 << 1) & GREG_CFG_TXDMALIM);
+		cfg &= ~(GREG_CFG_TXDMALIM | GREG_CFG_RXDMALIM);
+		cfg |= ((2 << 1) & GREG_CFG_TXDMALIM);
 		cfg |= ((8 << 6) & GREG_CFG_RXDMALIM);
 		writel(cfg, gp->regs + GREG_CFG);
 	}	


