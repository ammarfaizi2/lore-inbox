Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293716AbSCKMTx>; Mon, 11 Mar 2002 07:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293717AbSCKMTn>; Mon, 11 Mar 2002 07:19:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30240 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293716AbSCKMTa>; Mon, 11 Mar 2002 07:19:30 -0500
Date: Mon, 11 Mar 2002 13:20:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Kurt Garloff <garloff@suse.de>,
        Linux kernel list <linux-kernel@vger.kernel.org>,
        "S. Chandra Sekharan" <sekharan@us.ibm.com>
Subject: Re: [PATCH] Support for assymmetric SMP
Message-ID: <20020311132053.G10413@dualathlon.random>
In-Reply-To: <20020311043421.D2346@nbkurt.etpnet.phys.tue.nl> <20020311052954.R8949@dualathlon.random> <20020311122549.I2346@nbkurt.etpnet.phys.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311122549.I2346@nbkurt.etpnet.phys.tue.nl>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 12:25:49PM +0100, Kurt Garloff wrote:
> Hi Andrea,
> 
> On Mon, Mar 11, 2002 at 05:29:54AM +0100, Andrea Arcangeli wrote:
> > the only problem is if you happen to get the timer irq always in the
> > same cpu for a few seconds, then the last_tsc_low will wrap around and
> > gettimeofday will be wrong. And even if you snapshot the full 64bit of the
> > tsc you'll run into some trouble if the timer irq will be delivered only
> > to the same cpu for a long time (for example if you use irq bindings).
> > you'd lose precision and you'll run into the measuration errors of
> > fast_gettimeoffset_quotient. The right support for asynchronous TSC
> > handling is a bit more complicated unfortunately.
> 
> If your APIC works, your CPUs should get the timer IRQs in alternating order.

Maybe I remeber wrong, but AFIK the io-apic isn't required to scale the
irq load in alternating order, it is perfectly allowed to deliver the
irq always to the same cpu for several seconds. I know the probability
for that to happen is low but it can happen.

Andrea
