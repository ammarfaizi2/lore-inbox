Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316742AbSERBeA>; Fri, 17 May 2002 21:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316743AbSERBd7>; Fri, 17 May 2002 21:33:59 -0400
Received: from ns.suse.de ([213.95.15.193]:58126 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316742AbSERBd7>;
	Fri, 17 May 2002 21:33:59 -0400
Date: Sat, 18 May 2002 03:33:58 +0200
From: Dave Jones <davej@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel
Message-ID: <20020518033358.A15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Andrea Arcangeli <andrea@suse.de>, Keith Owens <kaos@ocs.com.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.44.0205030131470.11340-100000@epic7.Stanford.EDU> <11840.1020427634@ocs3.intra.ocs.com.au> <20020518011410.GD29509@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2002 at 03:14:10AM +0200, Andrea Arcangeli wrote:
 > you're right if we need a make clean it's because the buildsystem is
 > broken. However one thing that happens all the time to me, is that I
 > change an header like mm.h or sched.h and ~everything needs to be
 > rebuilt then.

Yep. Our includes dependancies suck bigtime.  Some work has been
done already in untangling the mess, but a lot more needs to be
done to really make a real difference.

Whats scary is that if you look at the dependancy graphs[1] of the
'best of the worst' includes, it's the same ugly mess we've
come to know and expect, and yet this is *after* some cleanups
already happened.

The 'dump everything into sched.h and friends' things really
needs splitting up some more, but it's a lot of work, and I don't
think kbuild2.5 alone is going to make that much difference
in this regard. Pulling out the component parts of the bigger
includes is probably the only way around this.

A driver that needs 'jiffies' defined should not be
inadvertantly pulling in a hundred include files.

    Dave.


[1] ftp://ftp.kernel.org/pub/linux/kernel/people/davej/misc/graphs/

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
