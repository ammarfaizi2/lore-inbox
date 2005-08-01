Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVHARB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVHARB0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 13:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbVHARBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 13:01:25 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53258 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261294AbVHARBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 13:01:24 -0400
Date: Mon, 1 Aug 2005 18:01:20 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3: cache flush missing from somewhere
Message-ID: <20050801180119.E14401@flint.arm.linux.org.uk>
Mail-Followup-To: Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20050729161343.A18249@flint.arm.linux.org.uk> <20050730.124052.104057695.davem@davemloft.net> <tnxzms1c0bf.fsf@arm.com> <20050801174030.C14401@flint.arm.linux.org.uk> <tnxzms1a986.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <tnxzms1a986.fsf@arm.com>; from catalin.marinas@arm.com on Mon, Aug 01, 2005 at 05:54:33PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 05:54:33PM +0100, Catalin Marinas wrote:
> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > On Mon, Aug 01, 2005 at 01:24:04PM +0100, Catalin Marinas wrote:
> >> "David S. Miller" <davem@davemloft.net> wrote:
> >> > If one cpu stores, does it get picked up in the other cpu's I-cache?
> >> 
> >> It only gets picked up by the other CPU's D-cache (which is fully
> >> coherent between cores). The I-cache needs to be invalidated on each
> >> CPU.
> >
> > Are you sure about this requirement?  I see no evidence of it in Harry's
> > patch set.
> 
> I asked the people that know more about this architecture than me and
> they confirmed that this is a requirement. I will double check
> tomorrow with the people that did the initial Linux support.
> 
> I haven't checked the original patch but it might work (by luck)
> without the I-cache invalidation (and without stressing it too
> much). This is because you might do a full mm flush when a process
> exits and the I-cache would be clean for newly allocated pages (only
> the D-cache needs flushing). If you don't overload memory, you don't
> get pages swapped-out/removed and the code in a page for a given
> process might remain unchanged until the process exits.

Given that it's sometimes going wrong as early as the first process, I
doubt this is what's happening.  The i-cache will be clean at this point
for the userspace programs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
