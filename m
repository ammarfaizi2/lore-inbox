Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263837AbTFPMqf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 08:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbTFPMqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 08:46:34 -0400
Received: from dp.samba.org ([66.70.73.150]:50355 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263837AbTFPMqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 08:46:33 -0400
Date: Mon, 16 Jun 2003 22:57:09 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: irq consolidation
Message-ID: <20030616125709.GB10330@krispykreme>
References: <20030607040515.GB28914@krispykreme> <20030607044803.GE28914@krispykreme> <20030607101848.A22665@flint.arm.linux.org.uk> <20030612113405.GH1195@krispykreme> <20030616120912.GA11652@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030616120912.GA11652@pazke>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> May be I missed the point, but it isn't flat.
> 
> You can define HAVE_ARCH_IRQ_DESC and provide your own irq_desc(irq)
> function which will translate irq number to the corresponding 
> irq_desc_t structure. You are free to implement any irq mappings
> behind the irq_desc(). NR_IRQS is used only as maximal irq number.
> So what is the problem ?

We have been discussing passing an opaque value into request_irq like
sparc64 does. It could be a pointer to the irq descriptor. rmk was
interested in it since he can have heavily nested interrupt controllers
and partitioning the NR_IRQS space is a pain in this case.

This will work on 32bit archs since we store irqs as ints everywhere, but
will break on 64bit unless we do some tricks (like sparc64 is currently
doing)

Anton
