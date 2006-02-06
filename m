Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWBFXH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWBFXH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWBFXH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 18:07:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:1555 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964800AbWBFXH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 18:07:58 -0500
Date: Mon, 6 Feb 2006 23:07:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Akinobu Mita <mita@miraclelinux.com>, linux-kernel@vger.kernel.org,
       Chris Zankel <chris@zankel.net>, Keith Owens <kaos@sgi.com>
Subject: Re: [patch 05/44] generic {,test_and_}{set,clear,change}_bit()
Message-ID: <20060206230750.GC9388@flint.arm.linux.org.uk>
Mail-Followup-To: Akinobu Mita <mita@miraclelinux.com>,
	linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
	Keith Owens <kaos@sgi.com>
References: <20060201090224.536581000@localhost.localdomain> <20060201090322.252374000@localhost.localdomain> <20060203095536.GO11002@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203095536.GO11002@admingilde.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 10:55:36AM +0100, Martin Waitz wrote:
> On Wed, Feb 01, 2006 at 06:02:29PM +0900, Akinobu Mita wrote:
> > +static __inline__ void set_bit(int nr, volatile unsigned long *addr)
> > +{
> > +	unsigned long mask = BITOP_MASK(nr);
> > +	unsigned long *p = ((unsigned long *)addr) + BITOP_WORD(nr);
> > +	unsigned long flags;
> > +
> > +	_atomic_spin_lock_irqsave(p, flags);
> > +	*p  |= mask;
> > +	_atomic_spin_unlock_irqrestore(p, flags);
> > +}
> 
> You could even use your new generic non-atomic bitops to implement these

Depends - to do so would increase the amount of code within the
locked region, which raises the probability of contention since the
locked time becomes longer.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
