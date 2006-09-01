Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWIAUoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWIAUoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 16:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWIAUoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 16:44:08 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37387 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750794AbWIAUoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 16:44:06 -0400
Date: Fri, 1 Sep 2006 21:43:43 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Roland Dreier <rdreier@cisco.com>, Adrian Bunk <bunk@stusta.de>,
       Tom Tucker <tom@opengridcomputing.com>,
       Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: 2.6.18-rc5-mm1: drivers/infiniband/hw/amso1100/c2.c compile error
Message-ID: <20060901204343.GA4979@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Roland Dreier <rdreier@cisco.com>, Adrian Bunk <bunk@stusta.de>,
	Tom Tucker <tom@opengridcomputing.com>,
	Steve Wise <swise@opengridcomputing.com>,
	Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, "David S. Miller" <davem@davemloft.net>
References: <20060901015818.42767813.akpm@osdl.org> <20060901160023.GB18276@stusta.de> <20060901101340.962150cb.akpm@osdl.org> <adak64nij8f.fsf@cisco.com> <20060901112312.5ff0dd8d.akpm@osdl.org> <ada8xl3ics4.fsf@cisco.com> <20060901130444.48f19457.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060901130444.48f19457.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:04:44PM -0700, Andrew Morton wrote:
> On Fri, 01 Sep 2006 12:53:47 -0700
> Roland Dreier <rdreier@cisco.com> wrote:
> > Yes, I agree that's a good plan, especially the documentation part.
> > However I would argue that what's in drivers/infiniband/hw/mthca/mthca_doorbell.h 
> > is legitimate: the driver uses __raw_writeq() when it exists and uses
> > two __raw_writel()s properly serialized with a device-specific lock to
> > get exactly the atomicity it needs on 32-bit archs.
> 
> No, driver-specific workarounds are not legitimate, sorry.
> 
> The driver should simply fail to compile on architectures which do not
> implement __raw_writeq().

So, what you're basically saying is that on architectures which can _NOT_
implement an atomic __raw_writeq(), certain drivers simply will not be
available?

> We can speed up the process by sending helpful emails to architecture
> maintainers, but they'll notice either way.

I think you're completely wrong in the context of the message you're
replying to - it's talking about an _atomic_ 64-bit write.

Sure, if you want a _non-atomic_ 64-bit write then that's possible,
but many 32-bit architectures can't do a 64-bit atomic IO write and
that isn't something they can "fix".

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core

-- 
VGER BF report: H 5.55112e-17
