Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUBUARl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 19:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbUBUARl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 19:17:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:57259 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261444AbUBUARj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 19:17:39 -0500
Subject: Re: Fix silly thinko in sungem network driver.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "David S. Miller" <davem@redhat.com>
In-Reply-To: <1077321849.9719.32.camel@gaston>
References: <200402202307.i1KN7GBR003938@hera.kernel.org>
	 <1077321849.9719.32.camel@gaston>
Content-Type: text/plain
Message-Id: <1077322322.9623.34.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 21 Feb 2004 11:12:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-21 at 11:04, Benjamin Herrenschmidt wrote:
> On Sat, 2004-02-21 at 09:29, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1584, 2004/02/20 14:29:11-08:00, torvalds@ppc970.osdl.org
> > 
> > 	Fix silly thinko in sungem network driver.
> > 	
> 
> Argh. Actually, the patch is wrong as we are losing the 2 other
> magic bits (the RonPaul bit, dunno what it is, that's how it's
> called by Apple, end the other bugfix bit, some more apple magic).
> 
> Fixed patch on its way ... (as soon as I finish pulling, don't
> cancel that cset, I'll apply a patch on top of it)

Here it is:

--- linux-2.5/drivers/net/sungem.c	2004-02-21 11:10:33.390479384 +1100
+++ linuxppc-2.5-benh/drivers/net/sungem.c	2004-02-21 11:11:03.448909808 +1100
@@ -1837,7 +1837,8 @@
 	 * thresholds (and Apple bug fixes don't exist)
 	 */
 	if (!(readl(gp->regs + GREG_CFG) & GREG_CFG_IBURST)) {
-		cfg = ((2 << 1) & GREG_CFG_TXDMALIM);
+		cfg &= ~(GREG_CFG_TXDMALIM | GREG_CFG_TXDMALIM);
+		cfg |= ((2 << 1) & GREG_CFG_TXDMALIM);
 		cfg |= ((8 << 6) & GREG_CFG_RXDMALIM);
 		writel(cfg, gp->regs + GREG_CFG);
 	}	


