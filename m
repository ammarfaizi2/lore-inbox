Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUIIVEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUIIVEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 17:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbUIIVCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 17:02:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13834 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266196AbUIIVAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 17:00:13 -0400
Date: Thu, 9 Sep 2004 22:00:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Scott Wood <scott@timesys.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-ID: <20040909220004.F6434@flint.arm.linux.org.uk>
Mail-Followup-To: Scott Wood <scott@timesys.com>,
	Arjan van de Ven <arjanv@redhat.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0409080938470.15087@montezuma.fsmlabs.com> <1094652572.2800.14.camel@laptop.fenrus.com> <20040908182509.GA6009@elte.hu> <20040908211415.GA20168@elte.hu> <20040909175748.A12336@infradead.org> <20040909172401.GA28376@elte.hu> <20040909175314.GD3106@holomorphy.com> <20040909175441.GA25686@devserv.devel.redhat.com> <20040909211038.E6434@flint.arm.linux.org.uk> <20040909205153.GA1014@yoda.timesys>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040909205153.GA1014@yoda.timesys>; from scott@timesys.com on Thu, Sep 09, 2004 at 04:51:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 04:51:53PM -0400, Scott Wood wrote:
> On Thu, Sep 09, 2004 at 09:10:38PM +0100, Russell King wrote:
> > If it uses irq_desc then ARM won't use it.  irq_desc is part of the
> > far-too-restrictive x86 IRQ handlign code which is unsuitable for
> > ARM platforms.
> 
> What does ARM need that irq_desc doesn't provide, and which could not
> be added?  IMHO, it'd be better to fix the generic code than maintain
> completely separate implementations.

Unfortunately, to deal with this issue would mean breaking off from
planned work, so I'm not going to be in a position to do an element
by element comparison of the structures for some time.

Maybe I can look at it after the weekend though.

However, I think if you just compare:

linux/include/linux/irq.h
linux/include/asm-arm/mach/irq.h

you'll realise how inadequate the "generic" IRQ code is for ARM.

Note that IRQ handling on ARM is a multi-level affair where we have
multiple levels of interrupt controllers which need to be traversed
in software.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
