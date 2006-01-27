Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWA0KlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWA0KlM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 05:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030299AbWA0KlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 05:41:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51009 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030298AbWA0KlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 05:41:10 -0500
Date: Fri, 27 Jan 2006 11:43:21 +0100
From: Jens Axboe <axboe@suse.de>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127104321.GE4311@suse.de>
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D9F705.5000403@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27 2006, Pierre Ossman wrote:
> Jens Axboe wrote:
> > On Fri, Jan 27 2006, Pierre Ossman wrote:
> >   
> >> I'm having some problems getting high memory support to work smoothly in
> >> my driver. The documentation doesn't indicate what I might be doing
> >> wrong so I'll have to ask here.
> >>
> >> The problem seems to be that kmap & co maps a single page into kernel
> >> memory. So when I happen to cross page boundaries I start corrupting
> >> some unrelated parts of the kernel. I would prefer not having to
> >> consider page boundaries in an already messy PIO loop, so I've been
> >> trying to find either a routine to map an entire sg entry or some way to
> >> force the block layer to not give me stuff crossing pages.
> >>
> >> As you can guess I have not found anything that can do what I want, so
> >> some pointers would be nice.
> >>     
> >
> > Honestly, just don't bother if you are doing PIO anyways. Just tell the
> > block layer that you want io bounced for you instead.
> >
> >   
> 
> This is the MMC layer so there is some separation between the block
> layer and the drivers. Also, the transfers won't necessarily be from the
> block layer so a generic solution is desired. I don't suppose there is
> some way of accessing the bounce buffer routines in a non-bio context?

Only the mapping routines are appropriate at that point, or things get
complicated. You could still do a two-page mapping, if you are careful
about using different KMAP_ types.

-- 
Jens Axboe

