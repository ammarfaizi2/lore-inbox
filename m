Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSBMOuP>; Wed, 13 Feb 2002 09:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285338AbSBMOt5>; Wed, 13 Feb 2002 09:49:57 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:31624 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285229AbSBMOts>;
	Wed, 13 Feb 2002 09:49:48 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>, <rwhron@earthlink.net>
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Date: Thu, 7 Feb 2002 12:32:50 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0202061936240.17850-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.33L.0202061936240.17850-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16Ymne-0000J7-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 6, 2002 10:37 pm, Rik van Riel wrote:
> On Wed, 6 Feb 2002 rwhron@earthlink.net wrote:
> > On Wed, Feb 06, 2002 at 09:44:33AM -0200, Rik van Riel wrote:
> > > Once you get over 'dbench 16' or so the whole thing basically
> > > becomes an excercise in how well the system can trigger task
> > > starvation in get_request_wait.
> >
> > It's neat you've identified that bottleneck.
> 
> Umm, there's one thing you need to remember about these
> high dbench loads though.
> 
> They run fastest when you run each of the dbench forks
> sequentially and have the others stuck in get_request_wait.
> 
> This, of course, is completely unacceptable for real-world
> server scenarios, where all users of the server need to be
> serviced fairly.

Right, and as we just discussed on irc, it's a useful effect - only if we 
control it, so that stopped or slowed processes do eventually get forcibly 
elevated in terms of IO priority so they can make progress, after being sat 
upon by more agressive/successful processes long enough.  And we can control 
this, it's just going to take a few months to get basic issues of IO queues, 
RSS accounting, etc. out of the way so we can address it.

The trouble I have with paying a lot of attention to dbench results at this 
point is - we're measuring effects of kernel behaviour that is, at this 
point, uncontrolled and effectively random.  IOW, we're not measuring the 
effects that we're interested in just now.  If we need to know IO throughput, 
we need to use benches that test exactly that, and not other randomly 
interacting effects.  As they said on Laugh-in many moons ago: 'very 
interesting, but useless'.

-- 
Daniel
