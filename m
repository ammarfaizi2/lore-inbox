Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUDGR1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 13:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263826AbUDGR1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 13:27:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:11243
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263840AbUDGR1L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 13:27:11 -0400
Date: Wed, 7 Apr 2004 19:27:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Eric Whiting <ewhiting@amis.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mmX 4G patches feedback [numbers: how much performance impact]
Message-ID: <20040407172709.GH26888@dualathlon.random>
References: <40718B2A.967D9467@amis.com> <20040405174616.GH2234@dualathlon.random> <4071D11B.1FEFD20A@amis.com> <20040405221641.GN2234@dualathlon.random> <20040406115539.GA31465@elte.hu> <20040406155925.GW2234@dualathlon.random> <20040406192549.GA14869@elte.hu> <20040406202548.GI2234@dualathlon.random> <20040407060330.GB26888@dualathlon.random> <20040407064629.GA31338@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407064629.GA31338@elte.hu>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 08:46:29AM +0200, Ingo Molnar wrote:
> 4:4 patch) but a __flush_tlb() added before and after do_IRQ(), in

I added __flush_tlb_global on entry to better simulate the effect of
4:4. I doubt it makes a difference though.

--- x/arch/i386/kernel/irq.c.~1~	2004-03-11 08:27:22.000000000 +0100
+++ x/arch/i386/kernel/irq.c	2004-04-07 19:23:21.735733664 +0200
@@ -427,6 +427,7 @@ asmlinkage unsigned int do_IRQ(struct pt
 	struct irqaction * action;
 	unsigned int status;
 
+	__flush_tlb_global();
 	irq_enter();
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
@@ -507,6 +508,7 @@ out:
 	spin_unlock(&desc->lock);
 
 	irq_exit();
+	__flush_tlb();
 
 	return 1;
 }
