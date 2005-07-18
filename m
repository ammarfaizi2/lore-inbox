Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVGRPGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVGRPGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 11:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVGRPGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 11:06:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:59785 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261458AbVGRPGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 11:06:38 -0400
Date: Mon, 18 Jul 2005 17:06:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Steven Rostedt <rostedt@goodmis.org>
cc: Tom Zanussi <zanussi@us.ibm.com>, richardj_moore@uk.ibm.com,
       varap@us.ibm.com, karim@opersys.com, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Merging relayfs?
In-Reply-To: <1121697406.12862.32.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0507181653570.3728@scrub.home>
References: <17107.6290.734560.231978@tut.ibm.com>  <20050712022537.GA26128@infradead.org>
  <20050711193409.043ecb14.akpm@osdl.org>  <Pine.LNX.4.61.0507131809120.3743@scrub.home>
  <17110.32325.532858.79690@tut.ibm.com>  <Pine.LNX.4.61.0507171551390.3728@scrub.home>
  <17114.32450.420164.971783@tut.ibm.com>  <1121694275.12862.23.camel@localhost.localdomain>
  <Pine.LNX.4.61.0507181607410.3743@scrub.home> <1121697406.12862.32.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 18 Jul 2005, Steven Rostedt wrote:

> > What exactly would be slowed down?
> > It would just move around some code and even avoid the overwrite mode 
> > check.
> 
> Yes, you're adding a jump to another function via a function pointer,
> that would kill the cache line of execution, to avoid a simple check, or
> some other way of handling it.

RTFS. (deliver_default_callback)

> Since I don't want to know the internals
> of relayfs,

You have to anyway, currently relayfs client need some knowledge about how 
buffers are managed.

> the overwrite mode could be implemented in a more officient way.

I wouldn't call the buffer switch routine efficient, yet.

> > > I don't see the problem with having an overwrite mode or not. Why
> > > can't relayfs know this?
> > 
> > The point is to design a simple and flexible relayfs layer, which means 
> > not every possible function has to be done in the relayfs layer, as long 
> > it's flexible enough to build additional functionality on top of it (for 
> > which it can again provide some library functions).
> 
> The overwrite mode isn't that complex.  You don't want to make something
> so flexible that it becomes more complex.  Assembly is more flexible
> than C but I wouldn't want to code a lot with it.  A library function
> for me is out of the question, since what I build on top of relayfs is
> mostly in the kernel.  The overwrite mode would then have to be
> implemented through another kernel activity.  I might as well keep my
> own ring buffers and forget about using relayfs, and all my points in
> which I argue for it being merged is mute.

I must admit I have no clue, what you're talking about here...
The keywords above are "_simple_ _and_ _flexible_".

bye, Roman
