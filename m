Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751978AbWCGAYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWCGAYk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 19:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064AbWCGAYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 19:24:40 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35499
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751978AbWCGAYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 19:24:39 -0500
Date: Mon, 06 Mar 2006 16:24:44 -0800 (PST)
Message-Id: <20060306.162444.107249907.davem@davemloft.net>
To: bcrl@kvack.org
Cc: drepper@gmail.com, da-x@monatomic.org, linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060306233300.GR20768@kvack.org>
References: <20060306211854.GM20768@kvack.org>
	<a36005b50603061453w36f5d49cs7bac0c186aee30b3@mail.gmail.com>
	<20060306233300.GR20768@kvack.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin LaHaise <bcrl@kvack.org>
Date: Mon, 6 Mar 2006 18:33:00 -0500

> On Mon, Mar 06, 2006 at 02:53:07PM -0800, Ulrich Drepper wrote:
> > I don't think the POSIX AIO nor the kernel AIO interfaces are suitable
> > for sockets, at least the way we can expect network traffic to be
> > handled in the near future.  Some more radical approaches are needed. 
> > I'll have some proposals which will be part of the talk I have at OLS.
> 
> Oh?  I've always envisioned that network AIO would be able to use O_DIRECT 
> style zero copy transmit, and something like I/O AT on the receive side.  
> The in kernel API provides a lightweight event mechanism that should work 
> ideally for this purpose.

I think something like net channels will be more effective on receive.

We shouldn't be designing things for the old and inefficient world
where the work is done in software and hardware interrupt context, it
should be moved as close as possible to the compute entities and that
means putting the work all the way into the app itself, if not very
close.

To me, it is not a matter of if we put the networking stack at least
partially into some userland library, but when.

Eveyone has their brains wrapped around how OS support for networking
has always been done, and assuming that particular model is erroneous
(and net channels show good hard evidence that it is) this continued
thought process merely continues the error.

I really dislike it when non-networking people work on these
interfaces.  They've all frankly stunk, and they've had several
opportunities to try and get it right.

I want a bonafide networking person to work on any high performance
networking API we every decide to actually use.

This is why I going to sit and wait patiently for Van Jacobson's work
to get published and mature, because it's the only light in the tunnel
since Multics.

Yes, since Multics, that's how bad the existing models for doing these
things are.
