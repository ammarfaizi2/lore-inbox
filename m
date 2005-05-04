Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVEDAHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVEDAHs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbVEDAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 20:07:48 -0400
Received: from gate.crashing.org ([63.228.1.57]:25271 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261938AbVEDAHm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 20:07:42 -0400
Subject: Re: [PATCH] fix __mod_timer vs __run_timers deadlock.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: paulus@samba.org, jk@blackdown.de, akpm@osdl.org, oleg@tv-sign.ru,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
In-Reply-To: <20050503163916.30d64630.davem@davemloft.net>
References: <42748B75.D6CBF829@tv-sign.ru>
	 <20050501023149.6908c573.akpm@osdl.org> <87vf61kztb.fsf@blackdown.de>
	 <1115079230.6155.35.camel@gaston> <873bt5xf9v.fsf@blackdown.de>
	 <17014.59016.336852.31119@cargo.ozlabs.ibm.com>
	 <20050503115103.7461ae5e.davem@davemloft.net>
	 <1115163893.7568.49.camel@gaston>
	 <20050503163916.30d64630.davem@davemloft.net>
Content-Type: text/plain
Date: Wed, 04 May 2005 10:05:08 +1000
Message-Id: <1115165108.7567.76.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-03 at 16:39 -0700, David S. Miller wrote:
> On Wed, 04 May 2005 09:44:53 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Nothing prevents it ? well, I wouldn't be that optimistic :) The USB
> > stuff is a bit complex, it inlcudes doing DMAs, so manipulating the
> > iommu, dealing with URB queues (and thus allocating/releasing them)
> > etc... and especially in the context of xmon, that mean letting the
> > driver do a lot of these at any time whatever state the system is...
> 
> I think doing calls to the USB interrupt handler would work.
> I'm not being crazy :)

Maybe, but it will trigger all other USB drivers around and really
weird things might happen.. Oh well, I may give it a try one of
these days anyway. I could probably even do some hack to force the
OHCI to only service incoming interrupt URBs for input devices or
such things...

> But yeah we could do a micro-stack as well, but as you noted the
> transfer to/from the real USB HCI driver would be non-trivial.
> 
> I truly believe just calling the real USB HCI driver interrupt
> handler in a polling fashion is the way to go.

But it feels very fragile... Oh well, I will experiment with that one of
these days (no time right now though).

Ben.


