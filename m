Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278770AbRKEAKC>; Sun, 4 Nov 2001 19:10:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280060AbRKEAJv>; Sun, 4 Nov 2001 19:09:51 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:9195 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S278770AbRKEAJn>; Sun, 4 Nov 2001 19:09:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Mon, 5 Nov 2001 01:10:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jakob ?stergaard <jakob@unthought.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        John Levon <moz@compsoc.man.ac.uk>, linux-kernel@vger.kernel.org,
        Tim Jansen <tim@tjansen.de>
In-Reply-To: <Pine.GSO.4.21.0111041841480.21449-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0111041841480.21449-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105000933Z17055-18972+28@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 12:42 am, Alexander Viro wrote:
> On Sun, 4 Nov 2001, Daniel Phillips wrote:
> 
> > Doing 'top -d .1' eats 18% of a 1GHz cpu, which is abominable.  A kernel
> > profile courtesy of sgi's kernprof shows that scanning pages does not move
> > the needle, whereas sprintf does.  Notice that the biggest chunk of time
> 
> Huh?  Scanning pages is statm_pgd_range().  I'd say that it takes
> seriously more than vsnprintf() - look at your own results.

Yes, true, 2.6 seconds for the statm_pgd_range vs 1.2 for sprintf.  Still, 
sprintf is definitely burning cycles, pretty much the whole 1.2 seconds would 
be recovered with a binary interface.

Now look at the total time we spend in the kernel: 10.4 seconds, 4 times the 
page scanning overhead.  This is really wasteful.

For top does it really matter?  (yes, think slow computer)  What happens when 
proc stabilizes and applications start relying on it heavily as a kernel 
interface?  If we're still turning in this kind of stunningly poor 
performance, it won't be nice.

It's not that it doesn't work, it's just that it isn't the best.

--
Daniel
