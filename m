Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290968AbSAaGQW>; Thu, 31 Jan 2002 01:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290969AbSAaGQN>; Thu, 31 Jan 2002 01:16:13 -0500
Received: from bitmover.com ([192.132.92.2]:1711 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290968AbSAaGP4>;
	Thu, 31 Jan 2002 01:15:56 -0500
Date: Wed, 30 Jan 2002 22:15:55 -0800
From: Larry McVoy <lm@bitmover.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Larry McVoy <lm@bitmover.com>, Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130221555.J18381@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Alexander Viro <viro@math.psu.edu>, Larry McVoy <lm@bitmover.com>,
	Rob Landley <landley@trommello.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Eli Carter <eli.carter@inet.com>,
	Georg Nikodym <georgn@somanetworks.com>,
	Ingo Molnar <mingo@elte.hu>, Rik van Riel <riel@conectiva.com.br>,
	Tom Rini <trini@kernel.crashing.org>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020130210835.F21235@work.bitmover.com> <Pine.GSO.4.21.0201310039340.15689-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.21.0201310039340.15689-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Jan 31, 2002 at 01:02:53AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 01:02:53AM -0500, Alexander Viro wrote:
> I don't want A (or entire old path) to disappear.  What I want is ability
> to have two paths leading to the same point + ability to mark one of
> them as "more interesting".
> 
> I.e. the result I want is _two_ sets of changesets with the same compositions.

Ahh, you want LODs.  And they neatly solve the problem you described.
And a bunch of others.  Think of a LOD as a revision history graph.
Imagine being able to create a new, empty (or partially populated)
"container".  That container is a LOD.  You can do set operations from
one LOD to the other.  They are a lot like branches except that they
themselves can branch & merge.

The way that we'd do what you wanted is you'd create a new LOD, 
stick B, C, D, E into it, and make it the default LOD in your 
repository.  

LODs have some very nice attributes - each change is a set element, the
LOD is nothing more than a recorded history of what set elements are in
this LOD, and you can cherry pick from one LOD to the other.  Out of
order, sparsely, whatever.

The only restriction is that you have to have all the changes in your
graph.  There is no concept of a sparse graph.  You can trim off stuff
that happens after some point but you can't remove points in the middle,
even if they are in the other LOD.  Is that OK?

Linus first sounded like he'd accept this as an answer and then later it
fell out of favor because even though he could hide a bad changeset in
another LOD, he didn't want it in the graph at all.  I don't know how
to do that.

The other gotcha is that LODs are only partially implemented and are 
going to stay that way until we achieve concensus on how BK should
work for you.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
