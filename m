Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbVENPdP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbVENPdP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 11:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbVENPdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 11:33:15 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16409
	"EHLO g5.random") by vger.kernel.org with ESMTP id S261418AbVENPdJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 11:33:09 -0400
Date: Sat, 14 May 2005 17:33:07 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matt Mackall <mpm@selenic.com>, Andy Isaacson <adi@hexapodia.org>,
       Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050514153307.GA6695@g5.random>
References: <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain> <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <20050513234406.GG13846@redhat.com> <1116056238.7360.9.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116056238.7360.9.camel@mindpipe>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 03:37:18AM -0400, Lee Revell wrote:
> The apps that bother to use rdtsc vs. gettimeofday need a cheap high res
> timer more than a correct one anyway - it's not guaranteed that rdtsc
> provides a reliable time source at all, due to SMP and frequency scaling
> issues.

On x86-64 the cost of gettimeofday is the same of the tsc, turning off
tsc on x86-64 is not nice (even if we usually have HPET there, so
perhaps it wouldn't be too bad). TSC is something only the kernel (or a
person with some kernel/hardware knowledge) can do safely knowing it'll
work fine. But on x86-64 parts of the kernel runs in userland...

Preventing tasks with different uid to run on the same physical cpu was
my first idea, disabled by default via sysctl, so only if one is
paranoid can enable it.

But before touching the kernel in any way it would be really nice if
somebody could bother to demonstrate this is real because I've an hard
time to believe this is not purely vapourware. On artificial
environments a computer can recognize the difference between two faces
too, no big deal, but that doesn't mean the same software is going to
recognize million of different faces at the airport too. So nothing has
been demonstrated in practical terms yet.

Nobody runs openssl -sign thousand of times in a row on a pure idle
system without noticing the 100% load on the other cpu for months (and
he's not root so he can't hide his runaway 100% process, if he was root
and he could modify the kernel or ps/top to hide the runaway process,
he'd have faster ways to sniff).

So to me this sounds a purerly theoretical problem. Cache covert
channels are possible too as the paper states, next time somebody will
find how to sniff a letter out of a pdf document on a UP no-HT system by
opening and closing it some million of times on a otherwise idle system.
We're sure not going to flush the l2 cache because of that (at least not
by default ;).

This was an interesting read, but in practice I'd rate this to have
severity 1 on a 0-100 scale, unless somebody bothers to demonstrate it
in a remotely realistic environment.

Even if this would be real if they sniff a openssl key, unless they also
crack the dns the browser will complain (not very different from not
having a certificate authority signature on a fake key). And if the
server is remotely serious they'll notice the 100% runaway process way
before he can sniff the whole key (the 100% runaway load cannot be
hidden). Most servers have some statistics so a 100% load for weeks or
months isn't very likely to be overlooked.
