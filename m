Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290012AbSA3Qe0>; Wed, 30 Jan 2002 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290045AbSA3QeO>; Wed, 30 Jan 2002 11:34:14 -0500
Received: from bitmover.com ([192.132.92.2]:45733 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S290017AbSA3Qcz>;
	Wed, 30 Jan 2002 11:32:55 -0500
Date: Wed, 30 Jan 2002 08:32:54 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130083254.H23269@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>, Ingo Molnar <mingo@elte.hu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020130080308.D18381@work.bitmover.com> <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0201301408540.11594-100000@imladris.surriel.com>; from riel@conectiva.com.br on Wed, Jan 30, 2002 at 02:14:52PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 02:14:52PM -0200, Rik van Riel wrote:
> On Wed, 30 Jan 2002, Larry McVoy wrote:
> > On Wed, Jan 30, 2002 at 08:42:33AM -0700, Tom Rini wrote:
> > > On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> > > It does in some ways anyhow.  Following things downstream is rather
> > > painless, but one of the things we in the PPC tree hit alot is when we
> > > have a new file in one of the sub trees and want to move it up to the
> > > 'stable' tree
> >
> > Summary: only an issue because Linus isn't using BK.
> 
> Bitkeeper also seems to have some problems applying out-of-order
> changesets or applying them partially.

It does indeed and I think this is a far more serious issue than, for
example, the shouting SCCS subdirectories.  So let's discuss it.

> Changesets sent by 'bk send' are also much harder to read than
> unidiffs ;)

Yeah but if you do a bk send -d it prefixes them with unidiffs or 
you can do 
	
	cat patch | bk receive /home/bk/vmtree
	cd /home/bk/vmtree/RESYNC
	bk csets

and you are looking at the changes in the changeset viewer which most
people think is nicer than unidiffs.

> I think for bitkeeper to be useful for the kernel we really need:
> 
> 1) 'bk send' format Linus can read easily

That's done.

> 2) the ability to send individual changes (for example, the
>    foo_net.c fixes from 1.324 and 1.350) in one nice unidiff

That's possible now but not a really good idea.

> 3) the ability for Linus to apply patches that are slightly
>    "out of order" - a direct consequence of (2)

This is really the main point.  There are two issues, one is out of order
and the other is what we call "false dependencies".  I think it is the 
latter that bites you most of the time.  The reason you want out of order
is because of the false dependencies, at least that is my belief, let
me tell you what they are and you tell me.

Suppose that you make 3 changes, a driver change, a vm change, and a 
networking change.  Suppose that you want to send the networking change
to Linus.  With patch, you just diff 'em and send and hope that patch
can put it together on the other end.  With BK as it stands today, there
is a linear dependency between all three changes and if you want to send
the networking change, you also have to send the other 2.

How much of the out order stuff goes away if you could send changes out
of order as long as they did not overlap (touch the same files)?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
