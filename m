Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317305AbSGIFSx>; Tue, 9 Jul 2002 01:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSGIFSw>; Tue, 9 Jul 2002 01:18:52 -0400
Received: from bitmover.com ([192.132.92.2]:2944 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S317305AbSGIFSv>;
	Tue, 9 Jul 2002 01:18:51 -0400
Date: Mon, 8 Jul 2002 22:21:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: BKL removal
Message-ID: <20020708222127.G11300@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rick Lindsley <ricklind@us.ibm.com>, Greg KH <greg@kroah.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Thunder from the hill <thunder@ngforever.de>,
	kernel-janitor-discuss <kernel-janitor-discuss@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <20020708021228.GA19336@kroah.com> <200207090146.g691kD429646@eng4.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207090146.g691kD429646@eng4.beaverton.ibm.com>; from ricklind@us.ibm.com on Mon, Jul 08, 2002 at 06:46:12PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem is, of course, that to responsibly use the BKL, you must
> fully understand ALL the code that utilizes it, so that you know your
> new use of it doesn't conflict or interfere with existing code and
> usage.  

Indeed.

       v
> With a narrowly defined and used lock, it is much less difficult to
       ^

If you were talking about replacing a big lock with one lock, you
might have a point.  But you aren't.  You can't be, because by
definition if you take out the big lock you have to put in lots
of little locks.  And then you get discover all the problems that
the BKL was hiding that you just exposed by removing it.

If you think that managing those is easier than managing the BKL,
you don't understand the first thing about threading.

I think the kernel crowd is starting to sense how complex things
are getting and are pushing back a bit.  Don't fight them, this
isn't IRIX/Dynix/PTX/AIX/Solaris.  It's Linux and part of the
appeal, part of the reason you are here, is that it is (was) simple.
All you are doing is suggesting that it should be more complex.
I don't agree at all.

> So can you define for me under what conditions the BKL is appropriate
> to use?  

Can you tell me for sure that there are no races introduced by your
proposed change?

Can you tell me the list of locks and what they cover in the last 
multi threaded OS you worked in?  I thought not.  Nobody could.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
