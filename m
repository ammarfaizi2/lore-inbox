Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262034AbTCLU47>; Wed, 12 Mar 2003 15:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262013AbTCLUzb>; Wed, 12 Mar 2003 15:55:31 -0500
Received: from crack.them.org ([65.125.64.184]:24218 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262005AbTCLUyi>;
	Wed, 12 Mar 2003 15:54:38 -0500
Date: Wed, 12 Mar 2003 16:05:13 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312210513.GA6948@nevyn.them.org>
Mail-Followup-To: Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030312174244.GC13792@work.bitmover.com> <Pine.LNX.4.44.0303121324510.14172-100000@xanadu.home> <20030312195120.GB7275@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030312195120.GB7275@work.bitmover.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 11:51:20AM -0800, Larry McVoy wrote:
> Well, I agree that they should be able to get at the information in a 
> neutral way.  I guess it was unrealistic, but I was expecting that people
> would go download the CVS tree and poke around and see if it is what they
> wanted.  We could have had a nice technical discussion about what was 
> missing, if anything.  If the discussion had happened, they would have 
> found out that even for the missing deltas we captured the information.
> 
> Here's an example.  Suppose the graph is like
> 
> 	1.1 (torvalds) -> 1.2 (alan) -> 1.3 (sct) -> 1.4 (torvalds) 
> 	             \                             /
> 		      \-> 1.1.1.1 (davej) --------/
> 
> and we picked the straight 1.1 to 1.4 path.  When we created the CVS 1.4
> delta, we knew that it was a merge delta and we needed to capture the 
> data off on the branch.  We already capture the contents, the missing part
> is what davej may have typed in as comments.  We capture that as well, it
> looks like this:
> 
>     revision 1.342
>     date: 2003/03/07 15:39:16;  author: torvalds;  state: Exp;  lines: +7 -1
>     [PATCH] kbuild: Smart notation for non-verbose output
> 
>     2003/03/05 19:50:27-06:00 kai
>     kbuild: Make build stop on vmlinux link error
> 
>     (Logical change 1.8166)
> 
> That particular example is from the top level Makefile, Linus merged
> in Kai's work and we added the "kbuild: Make build stop on vmlinux link
> error" comments from the merged in delta.  If there were more than one
> delta, they get merged as well, so the rlog output is completely accurate.

Larry, this brings up something I was meaning to ask you before this
thread exploded.  What happens to those "logical change" numbers over
time?

My understanding (since you mentioned ~ 3 minute latency on BK pushes,
not five hour latency) was that future changes would go into CVS
incrementally.  As far as I understand the "revision numbers" that BK
uses, they're subject to change.  Based on what trees Linus merges
from, a revision number in his repository may not always have the same
number.  So the comments will become out-of-date and inaccurate.

Or am I wrong about the potential for change within a single
repository?


-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
