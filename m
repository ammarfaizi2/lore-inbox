Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWEGQFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWEGQFG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWEGQFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:05:06 -0400
Received: from waste.org ([64.81.244.121]:17068 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932190AbWEGQFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:05:05 -0400
Date: Sun, 7 May 2006 11:00:14 -0500
From: Matt Mackall <mpm@selenic.com>
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060507160013.GM15445@waste.org>
References: <20060505203436.GW15445@waste.org> <20060506115502.GB18880@thunk.org> <20060506164808.GY15445@waste.org> <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <82ecf08e0605070613o7b217a2bw4c71c3a8c33bed28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82ecf08e0605070613o7b217a2bw4c71c3a8c33bed28@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 07, 2006 at 10:13:50AM -0300, Thiago Galesi wrote:
> >Sure.
> >
> >First, since the existence of /dev/random's entropy accounting scheme
> >is predicated on the assumption that we can break the hash function at
> >will, I'll replace SHA1 with, oh, say, CRC-16. This'll be illustrative
> >until someone has a nice preimage attack against SHA1.
> >
> >Then I'll run my test on one of the various arches where HZ=~100 and
> >we don't have a TSC. Like Sparc?
> >
> >Now all the inputs are easily predictable from anywhere with <10ms
> >ping, with the occassional need to guess between a pair of timer
> >ticks. And since I can calculate preimages of CRC-16, I can now deduce
> >the state of the pool if I can watch some subset of its output, say
> >https session keys I request. And then I can start guessing future
> >outputs and breaking into other people's https sessions.
> >
> >The point of /dev/random is to -survive- SHA1 being broken by never
> >giving out more secrets than we take in.
> 
> OK, here goes...
> 
> 1 - by eliminating feeding enthopy from network cards you are

Keep up, folks, I dropped that position in the very first round of replies.
 
> 2 - some platforms have much better enthropy sources than ethernet (or
> user input), just think hardware rngs, or even the sound card rng
> thing mentioned above

Point?

> 3 - as people said, your example (CRC-16 on specific platfoms) is
> (IMHO) an exxageration.

Yes, CRC-16 was a rhetorical device. MD4 would not have been. HZ=100
is not an exaggeration. Odds are pretty good you have such a Linux box
in the form of a router or such already. This completely invalidates
all the arguments about the hardware making the timing too
unpredictable as it does so on a timescale of microseconds or less.

-- 
Mathematics is the supreme nostalgia of our time.
