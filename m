Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267455AbUHJPgL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267455AbUHJPgL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267488AbUHJPf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:35:56 -0400
Received: from colin2.muc.de ([193.149.48.15]:3844 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S267455AbUHJPe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:34:57 -0400
Date: 10 Aug 2004 17:34:56 +0200
Date: Tue, 10 Aug 2004 17:34:56 +0200
From: Andi Kleen <ak@muc.de>
To: Brent Casavant <bcasavan@sgi.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] get_nodes mask miscalculation
Message-ID: <20040810153456.GA20269@muc.de>
References: <2rr7U-5xT-11@gated-at.bofh.it> <m31xifu5pn.fsf@averell.firstfloor.org> <Pine.SGI.4.58.0408100936220.23966@kzerza.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.58.0408100936220.23966@kzerza.americas.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2004 at 09:54:08AM -0500, Brent Casavant wrote:
> On Tue, 10 Aug 2004, Andi Kleen wrote:
> 
> > The idea behind this is was to make it behave like select.
> > And select passes highest valid value + 1.
> 
> Not that my opinion is worth much, but this seems a very peculiar
> interface to mimic.

It is the only system call I am aware of that passes a variable
length bitmap.  Do you know of any others? 

> > nodemask."
> 
> Actually, I worked from the following description:
> 
> mbind(3)
> 	. . .
> 	nodemask is a bit field of nodes that contains up to
> 	maxnode bits.
> 	. . .
> 
> This very clearly indicates that I should pass the number of bits
> in the nodemask field, not the number of bits plus one.

I really need to rewrite the mbind manpage - it was a quick
hack job and has several other errors.

> > Problem is that you'll break all existing libnuma binaries
> > which pass NUMA_MAX_NODES + 1. In your scheme the kernel
> > will access one bit beyond the bitmap that got passed,
> > and depending on its random value you may get a failure or not.
> 
> Well, again, not that my opinion carries much weight (nor really should
> it), but this whole off-by-one (or two) interface seems unnecessarily
> confusing.  Is there no way we can get this fixed?  The temporary pain

Sure, new system call slots would do with a small compat wrapper
for the old calls. I'm just not sure it is worth it. I personally
don't find it that confusing, but I'm probably not a good benchmark
for this. 

> of breaking the relatively new libnuma seems worth the price of getting
> this forever cleaned up.

I don't think breaking existing binaries is a good idea. Linux
has higher standards. 

-Andi
