Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265134AbSKRWTb>; Mon, 18 Nov 2002 17:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSKRWTM>; Mon, 18 Nov 2002 17:19:12 -0500
Received: from adedition.com ([216.209.85.42]:53004 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S265140AbSKRWSE>;
	Mon, 18 Nov 2002 17:18:04 -0500
Date: Mon, 18 Nov 2002 17:32:14 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Grant Taylor <gtaylor+lkml_cjiia111802@picante.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] epoll interface change and glibc bits ...
Message-ID: <20021118223214.GC14649@mark.mielke.cc>
References: <200211182204.gAIM47mU030748@habanero.picante.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211182204.gAIM47mU030748@habanero.picante.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2002 at 05:04:07PM -0500, Grant Taylor wrote:
> OTOH, I really hate the "user pointer in struct epollfd" thing...

Are you saying you see no way of using the 'user pointer in struct epollfd'
to accelerate event dispatching?

For a perfectly good example of a use for it that has nothing to do
with pointers, consider the possibility that the structure could hold
a priority number. Sure the FD could be used as an index into an array
(taking up lots of cache memory, btw) or an index into a hash (more
expensive to process), but wouldn't it be useful to sort high priority
events before low priority events without having to dereference every
single fd? I would even tend to delay executing low priority events
until epoll_wait(0) stopped telling me about high priority events.

An opaque field gives me, the event loop designer, freedom. No opaque
field because a few event loop designers are convinced that it will be
used as a data pointer, and they believe this to be wrong, is a
limitation. epoll provides a very efficient alternative to poll. Forcing
epoll to look like poll somewhat defeats the purpose. I don't mind having
a bigger event loop, or two different event loops (one used when epoll is
available, and one used when epoll isn't).

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

