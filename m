Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265180AbSKSDuQ>; Mon, 18 Nov 2002 22:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265184AbSKSDuQ>; Mon, 18 Nov 2002 22:50:16 -0500
Received: from adedition.com ([216.209.85.42]:23567 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265180AbSKSDuP>;
	Mon, 18 Nov 2002 22:50:15 -0500
Date: Mon, 18 Nov 2002 23:04:28 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Grant Taylor <gtaylor+lkml_abbje111802@picante.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119040428.GB16798@mark.mielke.cc>
References: <20021118223125.GB14649@mark.mielke.cc> <200211190023.gAJ0NZmU001209@habanero.picante.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211190023.gAJ0NZmU001209@habanero.picante.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 07:23:35PM -0500, Grant Taylor wrote:
> >>>>> Mark Mielke <mark@mark.mielke.cc> writes:
> > I would even tend to delay executing low priority events until
> > epoll_wait(0) stopped telling me about high priority events.
> ...for this to work, you have to stow events over epoll calls.  The
> sensible place to store these is in your per-fd structure.  So you
> still don't save the access to your per-event structure, just the one
> array index lookup.

This isn't necessarily true. For a minimal example a stack or list of
undispatched events can be kept. Also, if all high priority events are
processed, I would not be so worried about low priority events taking
a longer time to be dispatched. Is it not my freedom as an event loop
designer to make these decisions?

> If you do priorities, you *must* do this; otherwise you will be
> processing all events as they arrive in userspace.  Merely doing them
> in priority order will produce a slightly reduced but still O(n)
> latency for high priority events, rather than roughly bounded latency
> as is usually the intent.

Overall throughput is not significant. Some events require lower latency
than other events. An event loop that assumes that all events should have
equal latency may be satisfactory for some applications, but will result
in problems for others.

> BTW it is also possible to implement event prioritization in
> kernelspace.  You just [e]poll several sets of epolled fd's and take
> the most interesting set of events each time.  Unless, that is, the
> new syscall interface broke this...

I'm asking for a little freedom to innovate when the times comes. You are
suggesting that I shouldn't have this freedom, and that my ability to
innovate should be limited to what you or I can imagine at the current
point in time. We're talking about one extra field to a data structure.

I could have asked for epoll to implement a priority scheme internally...
I didn't... :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

