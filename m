Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292288AbSBTUcY>; Wed, 20 Feb 2002 15:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292285AbSBTUcV>; Wed, 20 Feb 2002 15:32:21 -0500
Received: from bitmover.com ([192.132.92.2]:48849 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292288AbSBTUbI>;
	Wed, 20 Feb 2002 15:31:08 -0500
Date: Wed, 20 Feb 2002 12:31:05 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ed Tomlinson <tomlins@cam.org>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] struct page, new bk tree
Message-ID: <20020220123105.J27423@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ed Tomlinson <tomlins@cam.org>, Larry McVoy <lm@bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.33L.0202192044140.7820-100000@imladris.surriel.com> <20020219155706.H26350@work.bitmover.com> <20020220201716.45A574E2E@oscar.casa.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020220201716.45A574E2E@oscar.casa.dyndns.org>; from tomlins@cam.org on Wed, Feb 20, 2002 at 03:17:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 03:17:12PM -0500, Ed Tomlinson wrote:
> In my opinion the idea of cset -x (while usefull) is fundamentally
> broken.  The result of this is that ideas like blacklist need to be
> considered.  I would propose instead an undo -x, that would
> generate a cset to reverse the one following the -x.  This might
> lead to conflicts - these would be resolved the normal bk fashion.
> If bk handled ¯bad¯ csets in this manner there would be no need for
> blacklists - it is more robust in that you can always used undo -x.

First of all, cset -x is functionally equivalent to what you call
undo -x.  They do the same thing.  Second of all, cset -x is _much_
better.  It does the same thing without introducing any new diffs
into the history.  Go get a test tree, make a changeset, clone
the tree, cset -x the changeset, and diff the revision history files.
All you will see is something like this:

^As 00000/00000/00455
^Ad D 1.32 02/02/20 09:50:05 lm 33 32
^Ax 32
^Ac Exclude
^AcC
^AcK50774
^Ae

The "^Ax 32" line says "exclude the change who's serial number is 32".
No reverse diffs applied to the file.  Much nicer.  Merges work like
this too, in reverse, it just includes the branch deltas.

But all of this misses the real point - Linus, with justification, doesn't
want the revision history cluttered up with

	Idea 1.

	Remove Idea 1.

	Idea 2.

	Remove Idea 2.

But we need some way to let changes get into the system so others can review
them, test them, merge them with their stuff and test, etc.  But then when
they are found to be wanting, we need a way to tell other people that those
csets are verboten.

I'm open to suggestions, this is a much harder problem than it appears 
because of the fact that the revision histories are all replicas 
possibly with local data.  Unlike CVS, there is no one place to go to
edit the RCS files and obliterate some change.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
