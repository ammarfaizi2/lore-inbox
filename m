Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbULKBLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbULKBLD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 20:11:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbULKBLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 20:11:03 -0500
Received: from waste.org ([209.173.204.2]:58822 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261900AbULKBKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 20:10:54 -0500
Date: Fri, 10 Dec 2004 17:10:15 -0800
From: Matt Mackall <mpm@selenic.com>
To: Adam Heath <doogie@debian.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Bernard Normier <bernard@zeroc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041211011014.GX8876@waste.org>
References: <20041208192126.GA5769@thunk.org> <20041208215614.GA12189@waste.org> <20041209015705.GB6978@thunk.org> <20041209212936.GO8876@waste.org> <20041210044759.GQ8876@waste.org> <20041210163558.GB10639@thunk.org> <20041210182804.GT8876@waste.org> <20041210212815.GB25409@thunk.org> <20041210222306.GV8876@waste.org> <Pine.LNX.4.58.0412101821330.2173@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0412101821330.2173@gradall.private.brainfood.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 06:22:37PM -0600, Adam Heath wrote:
> On Fri, 10 Dec 2004, Matt Mackall wrote:
> 
> > On Fri, Dec 10, 2004 at 04:28:15PM -0500, Theodore Ts'o wrote:
> > > On Fri, Dec 10, 2004 at 10:28:04AM -0800, Matt Mackall wrote:
> > > >
> > > > Fair enough. s/__add/mix/, please.
> > > >
> > >
> > > Why?  Fundamentally, it's all about adding entropy to the pool.  I
> > > don't have an strong objection to calling it __mix_entropy_words, but
> > > if we're going to change it, we should change the non-__ variant for
> > > consistency's sake, and I'd much rather do that in a separate patch if
> > > we're going to do it all.  I don't see the point of the rename,
> > > though.
> >
> > I suppose I don't really care. The __add is no longer just add, and
> > mix was the word that came to mind. But it doesn't really describe it
> > well either.
> >
> > > Still, I'd feel better if we did initialize more data via
> > > init_std_data(), and then cranked the LFSR some number of times so
> > > that we don't have to worry about analyzing the case where a good
> > > portion of the pool might contain consecutive zero values.  But yeah,
> > > we can save that for another patch, as it's not absolutely essential.
> > >
> > > Are we converging here?
> >
> > I'm gonna call this last iteration done. Repasted below for akpm's
> > benefit. Urgency: medium-ish.
> 
> Actually, I think this is a security issue.  Since any plain old program can
> read from /dev/urandom at any time, an attacker could attempt to read from
> that device at the same moment some other program is doing so, and thereby
> gain some knowledge as to the other program's state.

It is indeed a security issue. Some interesting non-tin-foil remote
attacks may even be possible, but they're still at the handwaving
stage. It should be fixed and soon, but I'm also aware that 2.6.10 is
imminent.

Unfortunately, the 2.6 development methodology is not well suited to
timely security fixes, unless we get serious about this 2.6.x.y
strategy.

-- 
Mathematics is the supreme nostalgia of our time.
