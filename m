Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTJAMwG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 08:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbTJAMwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 08:52:06 -0400
Received: from intra.cyclades.com ([64.186.161.6]:25284 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262074AbTJAMwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 08:52:00 -0400
Date: Wed, 1 Oct 2003 09:51:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@localhost.localdomain
To: Santiago Garcia Mantinan <manty@manty.net>, <bridge@osdl.org>,
       <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
Subject: Re: bridge breaks loopback on 2.4.22
In-Reply-To: <20030927202200.GA612@man.beta.es>
Message-ID: <Pine.LNX.4.44.0309301531530.2511-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Stephen, 

Have you looked into this? 

Thank you 

On Sat, 27 Sep 2003, Santiago Garcia Mantinan wrote:

> Hi!
> 
> Since the change to 2.4.22 I've been experimenting problems here, after
> many tests I have seen what I think is the problem that is causing this.
> 
> The problem I'm seing is the loopback starts loosing packages, I don't know
> if this could also happen on other interfaces. I'm testing this by starting
> a:
> 	tcpdump -n -i lo port
> then a:
> 	nc -n -l port >/dev/null
> and a:
> 	nc localhost port </dev/zero
> 
> If everything is fine my cpu goes to 100% and I see the packages all the way
> in my tcpdump screen, great. But there are sometimes when this doesn't go
> smooth and the tcpdump starts to show only one or two packages each N
> seconds, till it ends up showing the resend of the last package which is
> never acknowledged, you can even see that the timings of this packages that
> are being repeated match those of tcp backoff, my cpu charge is then really
> really low, nc disconnects after a while, ...
> 
> When does this happen?
> 
> It took me a while to find this out, but it happens when you have a bridge
> interface and one of the ports of the bridge is told to drop packages, like
> when they detect a loop in the net and an interface is set to a blocking
> state.
> 
> Of course that the loopback is not a part of any bridge in any of my setups,
> and I've seen this in a couple of machines, one SMP and the other one single
> micro, 2.4.21 worked ok, at least I could not reproduce this on that one. If
> the interfaces have been in a forwarding state all the time since the bridge
> was setup, without being in a blocking state, then this problem does not
> seem to happen.
> 
> I believe that the changes the bridge went through from 2.4.21 to 2.4.22 are
> to blame on this one, but this is just a guess.
> 
> Hope we can find a fix for this so that it is integrated in 2.4.23 kernel,
> I'll be happy to make any tests you want to track this farther down.
> 
> Regards...
> 



