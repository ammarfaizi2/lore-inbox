Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290977AbSAaGho>; Thu, 31 Jan 2002 01:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290975AbSAaGh2>; Thu, 31 Jan 2002 01:37:28 -0500
Received: from bitmover.com ([192.132.92.2]:20143 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290976AbSAaGhM>;
	Thu, 31 Jan 2002 01:37:12 -0500
Date: Wed, 30 Jan 2002 22:37:11 -0800
From: Larry McVoy <lm@bitmover.com>
To: Troy Benjegerdes <hozer@drgw.net>
Cc: Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
        Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130223711.L18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Troy Benjegerdes <hozer@drgw.net>,
	Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
	Rob Landley <landley@trommello.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130195154.R22323@work.bitmover.com> <Pine.GSO.4.21.0201302335370.15689-100000@weyl.math.psu.edu> <20020130210835.F21235@work.bitmover.com> <20020131002355.X14339@altus.drgw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020131002355.X14339@altus.drgw.net>; from hozer@drgw.net on Thu, Jan 31, 2002 at 12:23:55AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Troy said:
> The real problem with this approach is it leads to information overload.
> 
> Go look at linuxppc_2_4_devel with sccstool and try to track major 
> changes over the last 6 months. 
> 
> You can't. You are completely overwhelmed by the day-to-day thrashing of 
> 'bug fix this, bug fix that', and all the lines on the screen from the 
> wacky merges we wind up doing in that tree.

I agree with this and the rest of your message.  Here's what we are doing
to address it:

a) I have a version of BK where revtool (aka sccstool) shows only the 
   tagged releases.  It's cool.  It also has a feature where you can
   select a node and ask it to color all versions which contain this
   node (seems like you'd never need that until you see a heavily used
   BK tree like Troy has).

b) part of the problem is the "merge" deltas in the ChangeSet file.
   They really need to be hidden or removed completely.  As a side
   effect of making the ChangeSet file more flexible a la Linus' 
   requests (doesn't give all that he wants but part of it), I 
   think these will go away.

c) LODs.  One thing a LOD can do for you is to allow you to have your
   private LOD into which you do a ton of changes.  Then you can do
   a "rollup include" into a public LOD, like the PPC LOD.  We then
   give you a LOD aware revtool and the information overload starts
   to go away (but preserves the information if you need it).

> I think what Linus and Viro really want is not to rewrite history
> (although there are times when it would be nice), but say "I don't think
> this change is worth looking at". Keep the data in the database, because
> you have to to maintain consistency, but don't let me see it unless I ask
> 3 times, and say please.

If we could agree that this is true, I'm ecstatic.  BK needs at least part
of what you said to be true.  If you can convince Linus that it doesn't 
matter if the data is there as long as his view is clean, that solves some
of the nasty problems.

That said, I'm sympathetic to the "I make lotso changes and I want to 
collapse them into one big change" problem.  It's certainly technically
possible to make BK do that, but then you have to *know* that nobody
else has a BK repo with your old detailed changes in it, or if they 
do, they won't ever try to push them back to you (or Linus or ...).  
It's not an error if they do, it's just that BK will view them as 
different changes and automerge them right back into the history.
So then you'll have both the collapsed version and the detailed version
which puts you worse off than when you started.

That's the whole issue with the "history rewrite".  I'll give you history
rewrite, but you need to understand what it means.  I think the current
BK users get it.  I think the BK future users don't get that it is all
one big replicated distributed slightly (or not so slightly) out of sync
database that wants to sync up when it can.  So if you rewrite history,
BK has no way of knowing that you did that.  I suppose we could teach
though so that it would reject the uncollapsed changes but that has its
own issues.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
