Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268902AbTBWTWJ>; Sun, 23 Feb 2003 14:22:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268920AbTBWTWJ>; Sun, 23 Feb 2003 14:22:09 -0500
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:63725 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S268902AbTBWTWI>; Sun, 23 Feb 2003 14:22:08 -0500
Date: Sun, 23 Feb 2003 20:05:08 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [ak@suse.de: Re: iosched: impact of streaming read on read-many-files]
Message-ID: <20030223200508.N21727@nightmaster.csn.tu-chemnitz.de>
References: <20030222054307.GA22074@wotan.suse.de> <20030221230716.630934cf.akpm@digeo.com> <20030222145728.L629@nightmaster.csn.tu-chemnitz.de> <20030223154002.GG29467@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030223154002.GG29467@dualathlon.random>; from andrea@suse.de on Sun, Feb 23, 2003 at 04:40:02PM +0100
X-Spam-Score: -3.3 (---)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18n1rG-0000Mp-00*jhFzb/HOLo6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 04:40:02PM +0100, Andrea Arcangeli wrote:
> On Sat, Feb 22, 2003 at 02:57:28PM +0100, Ingo Oeser wrote:
> > What about implementing io-requests, which can time out? So if it will
> > not be serviced in time or we know, that it will not be serviced
> > in time, we can skip that.
> 
> that works only if the congestion cames from multimedia apps that are
> willing to cancel the timed out (now worthless) I/O, that is never the
> case normally due the low I/O load they generate (usually it's apps not
> going to cancel the I/O that congest the blkdev layer).
 
I would put it to loads, where it doesn't matter that all streams
will be serviced all the time and where it does matter more, that
we stay responsive and show the latest frames available.

> still, it's a good idea, you're basically asking to implement the cancel
> aio api and I doubt anybody could disagree with that ;).

I'm aware of these, but if we are so heavily busy, that the
applications looses IO frames already, then calling into an
application (which might be swapped out) to traverse its
AIO overhead the cancel makes no sense any more.

I want a deadline attached to them and have them automatically
cancelled after this deadline. (that's why I quoted the relevant
part of my e-mail again).

I can see many uses besides multi media applications. Also http
or ftp server could do this, if they are busier as expected or if
a connection dropped.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
