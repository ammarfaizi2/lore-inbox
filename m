Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbTAXIIk>; Fri, 24 Jan 2003 03:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbTAXIIk>; Fri, 24 Jan 2003 03:08:40 -0500
Received: from adedition.com ([216.209.85.42]:13075 "EHLO mark.mielke.cc")
	by vger.kernel.org with ESMTP id <S267578AbTAXIIj>;
	Fri, 24 Jan 2003 03:08:39 -0500
Date: Fri, 24 Jan 2003 03:26:10 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Dan Kegel <dank@kegel.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
Subject: Re: debate on 700 threads vs asynchronous code
Message-ID: <20030124082610.GA12781@mark.mielke.cc>
References: <Pine.LNX.4.44.0301232144470.8203-100000@coffee.psychology.mcmaster.ca> <3E30F79D.6050709@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E30F79D.6050709@kegel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 12:21:49AM -0800, Dan Kegel wrote:
> In any case, benchmarking's the only way to go.  No amount of talk will
> substitute for a good real-life measurement.  That's what convinced
> me that epoll was faster than sigio, and that sigio was
> sometimes slower than select() !

Also, anybody can write a poor implementation of each, so even
benchmarks are suspect...

My personal favourite model currently is switched I/O, but prioritized
threads per expected event frequency or event priority. For example,
events that won't likely occur for some time, or have a low priority,
can all be pushed to a low priority thread. Not only does this keep
the operating system free to give the CPU's to higher priority
threads, but the higher priority threads have fewer resources to
manage, leading to more efficient operation. Also, event handling code
that may take some time to complete should be moved to its own thread
in a thread pool, allowing the dispatching to fully complete without
needing to actually execute all of the (expensive) handlers.

> And, for what it's worth, programmer productivity is sometimes
> more important than all the above.  I happen to work
> at a place where performance is worth a lot of extra effort,
> but other shops prefer to throw hardware at the problem and
> not worry about that last 10%.

Definately an argument for the one thread per connection model. :-)

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

