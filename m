Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbWD0EHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbWD0EHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 00:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbWD0EHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 00:07:49 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:11268 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964921AbWD0EHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 00:07:49 -0400
Date: Thu, 27 Apr 2006 06:07:23 +0200
From: Willy Tarreau <willy@w.ods.org>
To: kyle@pbx.org
Cc: Davide Libenzi <davidel@xmailserver.org>, Heikki Orsila <shd@zakalwe.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: accept()ing socket connections with level triggered epoll
Message-ID: <20060427040723.GG13027@w.ods.org>
References: <20060426205557.GA5483@www.t3inc.us> <Pine.LNX.4.64.0604261411460.16727@alien.or.mcafeemobile.com> <20060427000520.GA10880@www.t3inc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060427000520.GA10880@www.t3inc.us>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 06:05:20PM -0600, kyle@pbx.org wrote:
> On Wed, Apr 26, 2006 at 03:14:16PM -0700, Davide Libenzi wrote:
> > 
> > Correct, if it's LT you have to get the event because before returning from 
> > epoll_wait(), the event is automatically re-armed if f_op->poll() returns it. 
> > Can you post the *minimal* test code for this case?
> > 
> > - Davide
> > 
> 
> I tried reducing the code I have to the minimum necessary to demonstrate the
> problem.  It went away, I'm afraid.  Since I'm already aware of a workaround
> (call accept in a loop until you get EAGAIN), I guess I'll just forget about
> it.  Unfortunately I can't post the full code, not that you'd want to dig
> through all of it anyway.

Sorry, I misunderstood you the first time. I thought that it was *when*
your accept looped that you encountered the problem. If you need performance,
I *really* encourage you to loop on accept() as much as you can. Missing an
accept() and reading EAGAIN is cheap, while looping through all your event
loop is usually more expensive. In haproxy, I had performance problems 5
years ago, I could not get above 1500-2000 sessions/s because I was doing
one accept at a time. After putting a small "while" loop around, it
immediately jumped over 10000.

Regards,
Willy

