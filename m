Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVBBUTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVBBUTF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262606AbVBBUMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:12:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5586 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262662AbVBBT6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:58:31 -0500
Date: Wed, 2 Feb 2005 14:49:36 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, Mel Gorman <mel@csn.ul.ie>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] Helping prezoring with reduced fragmentation allocation
Message-ID: <20050202164936.GA23718@logos.cnet>
References: <20050201171641.CC15EE5E8@skynet.csn.ul.ie> <Pine.LNX.4.58.0502011110560.3436@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0502011929020.16992@skynet> <Pine.LNX.4.58.0502011604130.5406@schroedinger.engr.sgi.com> <Pine.LNX.4.58.0502020026040.16992@skynet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502020026040.16992@skynet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Andrew,

What are your thoughts about inclusion of Mel's allocator work on -mm ?

On Wed, Feb 02, 2005 at 12:31:36AM +0000, Mel Gorman wrote:
> On Tue, 1 Feb 2005, Christoph Lameter wrote:
> 
> > On Tue, 1 Feb 2005, Mel Gorman wrote:
> >
> > > > Would it not be better to zero the global 2^MAX_ORDER pages by the scrub
> > > > daemon and have a global zeroed page list? That way you may avoid zeroing
> > > > when splitting pages?
> > > >
> > >
> > > Maybe, but right now when there are no 2^MAX_ORDER pages, the scrub daemon
> > > is going to be doing nothing which is why I think it needs to look at the
> > > free pages of lower orders.
> > >
> > > That is solveable though in one of two ways. One, the scrub daemon can
> > > zero pages from the global list and then add them to the USERZERO pool. It
> > > has the advantage of requiring no more memory and is simple. The second is
> > > to create a second global list. However, I think it only makes sense to
> > > have this as part of the scrub daemon patch (I can write it if thats a
> > > problem) rather than a standalone patch from me.
> >
> > Approach one is fine and I will do an update the remaining prezero patches
> > to do just that.
> 
> There is another problem with approach one. Assuming all 2^MAX_ORDER pages
> have been zeroed and in USERZERO pool and there are no other free pages,
> an allocation for the USERRCLM pool would search all the other pools
> before finding the zerod pages. This could really slow things up but it is
> not a problem approach two suffers from.
> 
> > When will your patches be in Linus tree? ;-)
> >
> 
> Your guess is as good as mine :) . I am fairly sure the allocator is
> somewhere in Andrew's list of patches to look at to consider for inclusion
> into -mm so I suppose it'll get a spin in that tree when he feels it's
> ready.
