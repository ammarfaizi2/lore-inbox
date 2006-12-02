Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424100AbWLBOFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424100AbWLBOFY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 09:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424102AbWLBOFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 09:05:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:52921 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1424100AbWLBOFX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 09:05:23 -0500
Date: Sat, 2 Dec 2006 14:05:21 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202140521.GJ3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165064370.24604.36.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 01:59:30PM +0100, Thomas Gleixner wrote:
> On Fri, 2006-12-01 at 17:21 +0000, Al Viro wrote:
> > Now, there's another question: how do we get there?  Or, at least, from
> > current void (*)(unsigned long) to void (*)(void *)...
> 
> I think the real solution should be 
> 
> 	void (*function)(struct timer_list *timer);
> 
> and hand the timer itself to the callback. Most of the timers are
> embedded into data structures anyway and for the rest we can easily
> build one.

Ewwwwwww....

Let's not.  It means more cruft in callbacks for no good reason.
And more cruft in code setting it up, while we are at it.
 
> > "A fscking huge patch flipping everything at once" is obviously not an
> > answer; too much PITA merging and impossible to review.
> 
> There are ~ 500 files affected and this is in the range of cleanups we
> did recently at the end of the merge window already. I'd volunteer to
> hack this up and keep the patch up to date until the final merge. I have
> done that before and I'm not scared about it. The patches are a couple
> of lines per file and I do not agree that this is impossible to review. 

I'd rather see that as patch series, TYVM.  And no, it won't be a couple
of lines per file with your variant.

Anyway, I'm doing that series in my tree, will post when it's over...
