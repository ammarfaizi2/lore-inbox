Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVL3Xs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVL3Xs3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVL3Xs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:48:28 -0500
Received: from waste.org ([64.81.244.121]:20648 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964961AbVL3Xs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:48:27 -0500
Date: Fri, 30 Dec 2005 17:44:00 -0600
From: Matt Mackall <mpm@selenic.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, Roland Dreier <rdreier@cisco.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
Message-ID: <20051230234400.GM3356@waste.org>
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> <adazmmmc9hl.fsf@cisco.com> <1135780804.1527.82.camel@serpentine.pathscale.com> <20051228145114.GL3356@waste.org> <20051230234628.GB3811@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051230234628.GB3811@stusta.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 12:46:28AM +0100, Adrian Bunk wrote:
> On Wed, Dec 28, 2005 at 08:51:14AM -0600, Matt Mackall wrote:
> > On Wed, Dec 28, 2005 at 06:40:03AM -0800, Bryan O'Sullivan wrote:
> > > On Tue, 2005-12-27 at 17:10 -0800, Roland Dreier wrote:
> > > 
> > > > I think the principle of least surprise calls for memcpy_toio32 to be
> > > > ordered the same way memcpy_toio is.  In other words there should be a
> > > > wmb() after the loop.
> > > 
> > > Will do.
> > > 
> > > > Also, no need for the { } for the while loop.
> > > 
> > > Fine.  There doesn't seem to be much consistency in whether to use
> > > curlies for single-line blocks.
> > 
> > We've been very consistent in discouraging it in new code. Enforcement
> > of fine points of coding style is a post-2.5 phenomenon, so it hasn't
> > hit all the tree yet.
> > 
> > > > You're adding this symbol and exporting it even if the arch will
> > > > supply its own version.  So this is pure kernel .text bloat...
> > > 
> > > I don't know what you'd prefer, so let me enumerate a few alternatives,
> > > and you can either tell me which you'd prefer, or point out something
> > > I've missed that would be even better.  I'm entirely flexible on this.
> > > 
> > >       * Use the __HAVE_ARCH_* mechanism that include/asm-*/string.h
> > >         uses.  Caveat: Linus has lately come out as hating this style.
> > >         It makes for the smallest patch, though.
> > >       * Define the generic code in lib/, and have each arch that really
> > >         uses it export it.
> > 
> > I'd favor this, at least for this case. If it becomes more widely
> > used, we'll relocate the export.
> >...
> 
> I don't like this for two reasons:
> - we are moving exports to the actual functions and steadily killing all
>   *syms* files
> - the lib-y approach has the disadvantage of completely omitting the
>   function if it's used only in modules resulting in non-working
>   modules
> 
> Where's the problem with the __HAVE_ARCH_* mechanism?

The head penguin peed on it last week.

-- 
Mathematics is the supreme nostalgia of our time.
