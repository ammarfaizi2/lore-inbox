Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbUKBSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbUKBSxS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbUKBSxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:53:17 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31922 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261320AbUKBSxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:53:07 -0500
Date: Tue, 2 Nov 2004 13:55:46 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __GFP flags and kmalloc failures
Message-ID: <20041102155546.GJ32054@logos.cnet>
References: <4187AC80.6050409@drzeus.cx> <20041102144429.GG32054@logos.cnet> <4187CB93.6080405@drzeus.cx> <20041102152629.GH32054@logos.cnet> <4187D28B.5060507@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4187D28B.5060507@drzeus.cx>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 07:31:39PM +0100, Pierre Ossman wrote:
> Marcelo Tosatti wrote:
> 
> >On Tue, Nov 02, 2004 at 07:01:55PM +0100, Pierre Ossman wrote:
> > 
> >
> >>Is there any other way of increasing the chances of actually getting the 
> >>pages I need? Since it is DMA it needs to be one big block.
> >>   
> >>
> >
> >__GFP_NOFAIL, from gfp.h:
> >
> >* Action modifiers - doesn't change the zoning
> >*
> >* __GFP_REPEAT: Try hard to allocate the memory, but the allocation attempt
> >* _might_ fail.  This depends upon the particular VM implementation.
> >*
> >* __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
> >* cannot handle allocation failures.
> >*
> >* __GFP_NORETRY: The VM implementation must not retry indefinitely.
> >*/
> >
> > 
> >
> Yes, I've browsed through these. __GFP_NOFAIL seems like it can hang for 
> a very long time (I don't know if there is an upper bound on how long it 
> will have to wait for a free page). __GFP_REPEAT seems to work good 
> enough in this case.
> My question was meant to be more along the lines of "Is there anything I 
> can do without resorting to unstable/interal API:s?".

Not really. 

They are not that unstable, I shouldnt mean that.

These defines are not as stable as system calls - VM internals might change 
in v2.7 and the flags also - but for v2.6 they are very likely to remain 
untouched.

Its just like any driver API in Linux - they change.

Just keep an eye.
