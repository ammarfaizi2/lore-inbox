Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267277AbSKSUo3>; Tue, 19 Nov 2002 15:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbSKSUoU>; Tue, 19 Nov 2002 15:44:20 -0500
Received: from mark.mielke.cc ([216.209.85.42]:36626 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267277AbSKSUnJ>;
	Tue, 19 Nov 2002 15:43:09 -0500
Date: Tue, 19 Nov 2002 15:57:33 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021119205733.GE22001@mark.mielke.cc>
References: <200211191933.gAJJXumU025156@habanero.picante.com> <Pine.LNX.4.44.0211191149220.1918-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211191149220.1918-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 11:51:40AM -0800, Davide Libenzi wrote:
> On Tue, 19 Nov 2002, Grant Taylor wrote:
> > If we're bound to poll small sets of epoll fds perhaps a bit of
> > improvement in poll would be worthwhile.  I should go look at my
> The current poll() with a number of fds you're talking about, scales
> beautifully.

For event loops that need minimal latency for high priority events
(even at the cost of higher latency for low priority events), poll()
of epoll fds may allow greater optimization opportunities, as the
epoll fd set is dynamically adjusted without extra system code
overhead.

Example: Code that expects that at least one high priority event may
be ready (for example, after dispatching events during the previous
iteration) can choose to first only poll(0) the epoll fds responsible
for the high priority event sets. Only if poll(0) returns no high
priority epoll fds, would poll(timeout) then be issued on all epoll
fds. This would result in a very short dispatch path for events for
high priority events.

What we really need is a few actual event loop implementations to test
all of these theories. I would find it especially nice if the code
could be ported to 2.4.x... :-)

For now, epoll of epoll fd is not necessary for our needs.

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

