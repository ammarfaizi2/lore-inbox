Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261876AbTCLVvP>; Wed, 12 Mar 2003 16:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261944AbTCLVvP>; Wed, 12 Mar 2003 16:51:15 -0500
Received: from bitmover.com ([192.132.92.2]:34994 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261876AbTCLVvO>;
	Wed, 12 Mar 2003 16:51:14 -0500
Date: Wed, 12 Mar 2003 14:01:56 -0800
From: Larry McVoy <lm@bitmover.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312220156.GE30788@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
References: <20030312211832.GA6587@work.bitmover.com> <Pine.LNX.4.44.0303121541190.19251-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303121541190.19251-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 03:45:39PM -0600, Kai Germaschewski wrote:
> On Wed, 12 Mar 2003, Larry McVoy wrote:
> 
> > > Larry, this brings up something I was meaning to ask you before this
> > > thread exploded.  What happens to those "logical change" numbers over
> > > time?
> > 
> > They are stable in the CVS tree because the CVS tree isn't distributed.
> > So "Logical change 1.900" in the context of the exported CVS tree is 
> > always the same thing.  That's one advantage centralized has, things
> > don't shift around on you.
> 
> Isn't there a more general problem, though? (I hope I'm wrong)
> 
> You want to update the CVS tree near-realtime. However, the longest-path
> through your graph may change with new merges, but CVS of course cannot
> cope with already committed data changing (already committed csets may 
> all of a sudden not be in the longest path anymore)? This is a CVS 
> limitation, of course, but still a problem AFAICS.

Yup, you're right, there is a tradeoff between real time updates and 
best path.  We've already seen it in incremental updates.

We were talking about this internally when your mail came in.  I suspect
it isn't really a problem in practice because we can always redo the
entire export from scratch and get an optimal path.

Wayne pointed out that in the cases where it collapses a pile of csets
that is usually because Linus pulled some wad from somebody and one could
argue the collapse is a good thing.  But it depends, sometimes it is and
sometimes it isn't.  Our commercial users have frequently asked for a
way to "collapse the tree and clean up the noise in the graphs", in fact,
one called this morning and said "that BK to CVS thing, could that be a BK
to cleaner-BK thing?" so opinions vary on what is the perfect granularity.

My belief is that the real time updates is something that people value
more than the granularity.  You guys can vote and if you reach agreement
we'll do what you want.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
