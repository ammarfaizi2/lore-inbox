Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTFLLXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 07:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTFLLXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 07:23:39 -0400
Received: from dp.samba.org ([66.70.73.150]:22185 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262164AbTFLLXi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 07:23:38 -0400
Date: Thu, 12 Jun 2003 21:34:06 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: irq consolidation
Message-ID: <20030612113405.GH1195@krispykreme>
References: <20030607040515.GB28914@krispykreme> <20030607044803.GE28914@krispykreme> <20030607101848.A22665@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030607101848.A22665@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I believe Andrey's IRQ consolidation provides a single flat IRQ
> structure.  Unfortunately, this doesn't reflect the reality that we
> have on many ARM platforms - it remains the case that we need to
> decode IRQs on a multi-level basis.

Yes its still a flat structure. On ppc32/64 we offset the interrupts on
the main controller to provide a space for ISA interrupts to go. Not
great but it works for us.

One thing Paul suggested was to have a flag to mark an interrupt as a
cascade in the irq descriptor. If its set then we also provide a
get_irq() method (perhaps stashed away in the ->action field). That gives
us nested interrupt handling in generic code. (assuming you can
partition your irq numbers somehow)

Anton
