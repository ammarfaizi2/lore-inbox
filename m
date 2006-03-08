Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbWCHVvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbWCHVvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 16:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWCHVvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 16:51:05 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:43238 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S1750841AbWCHVvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 16:51:03 -0500
Date: Thu, 9 Mar 2006 00:51:01 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Mathieu Chouquet-Stringer <mchouque@free.fr>, linux-kernel@vger.kernel.org,
       linux-alpha@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Problem on Alpha with "convert to generic irq framework"
Message-ID: <20060309005101.B9651@jurassic.park.msu.ru>
References: <20060304111219.GA10532@localhost> <20060306155114.A8425@jurassic.park.msu.ru> <20060306135434.GA12829@localhost> <20060306191324.A1502@jurassic.park.msu.ru> <20060306163142.GA19833@localhost> <20060308142857.A4851@jurassic.park.msu.ru> <20060308175652.GA28296@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060308175652.GA28296@twiddle.net>; from rth@twiddle.net on Wed, Mar 08, 2006 at 09:56:52AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 09:56:52AM -0800, Richard Henderson wrote:
> This will need commenting if it's to go in.

Agreed. What about this?

Ivan.

--- 2.6.16-rc5/arch/alpha/kernel/irq.c	Mon Mar  6 11:57:58 2006
+++ linux/arch/alpha/kernel/irq.c	Thu Mar  9 00:38:53 2006
@@ -151,8 +151,13 @@ handle_irq(int irq, struct pt_regs * reg
 	}
 
 	irq_enter();
+	/*
+	 * __do_IRQ() must be called with IPL_MAX. Note that we do not
+	 * explicitly enable interrupts afterwards - some MILO PALcode
+	 * (namely LX164 one) seems to have severe problems with RTI
+	 * at IPL 0.
+	 */
 	local_irq_disable();
 	__do_IRQ(irq, regs);
-	local_irq_enable();
 	irq_exit();
 }
