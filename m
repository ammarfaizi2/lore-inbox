Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTFGJFw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTFGJFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:05:52 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22547 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262820AbTFGJFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:05:16 -0400
Date: Sat, 7 Jun 2003 10:18:48 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Anton Blanchard <anton@samba.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: irq consolidation
Message-ID: <20030607101848.A22665@flint.arm.linux.org.uk>
Mail-Followup-To: Anton Blanchard <anton@samba.org>,
	linux-kernel@vger.kernel.org
References: <20030607040515.GB28914@krispykreme> <20030607044803.GE28914@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030607044803.GE28914@krispykreme>; from anton@samba.org on Sat, Jun 07, 2003 at 02:48:03PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 07, 2003 at 02:48:03PM +1000, Anton Blanchard wrote:
> We are hoping to kill irq_desc[NR_IRQS] completely and instead allocate
> them on demand with some sort of hash to map an interrupt number to an
> irq_desc.

The same thought has crossed my mind as well for ARM; the hardware
interrupt controllers are becoming more inteligent, and there is
the possibility that system designers will mix inteligent interrupt
controllers with standard types.

Also on ARM, we're currently defining NR_IRQS on a per-platform class
and even a per-platform basis.

I've been wondering whether we even need to think about passing some
alternative identifier of an IRQ line around, instead of a number.

> Im working on top of Andrey Panin's irq consolidation patches
> in the hope that it goes in first and other architectures can benefit 
> from these changes (I think SGI's ia64 boxes have similar issues as
> well as large x86)

I believe Andrey's IRQ consolidation provides a single flat IRQ
structure.  Unfortunately, this doesn't reflect the reality that we
have on many ARM platforms - it remains the case that we need to
decode IRQs on a multi-level basis.

Given the rate which ARM has progressed and evolved during the existing
2.4 lifespan, it doesn't make much difference to us whether these
changes happen now or later.  If it happens later, it will be during
the 2.6 series of kernels, so "now" is preferable.  Reality is such
that ARM hardware moves a hell of a lot faster than x86 hardware.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

