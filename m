Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316779AbSEUX24>; Tue, 21 May 2002 19:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316783AbSEUX2z>; Tue, 21 May 2002 19:28:55 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:51725 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316779AbSEUX2x>; Tue, 21 May 2002 19:28:53 -0400
Date: Tue, 21 May 2002 16:28:21 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 IDE 65
In-Reply-To: <20020521220854.A12368@ucw.cz>
Message-ID: <Pine.LNX.4.33.0205211626530.22624-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 May 2002, Vojtech Pavlik wrote:
> > 
> > They aren't there to be respected by the ll_rw_blk layer - if some layer
> > above it has created a request larger than the hard sector size, THAT is
> > the problem, and there is nothing ll_rw_blk can do (except maybe BUG() on
> > it, but I don't think we've ever really seen those kinds of bugs).
> 
> Hum, I'm confused here - shouldn't that be "if some layer above it has
> created a request SMALLER than the hard sector size"? Or better a
> request that is not a multiple of hard sector size?

Yes, yes, you're obviously right, and I just had a brainfart when writing
it. It should be basically: "higher levels must make sure on their own
that all requests are nice integer multiples of the hw sector-size", and 
ll_rw_blk should never have to care.

		Linus "neurons dying left and right" Torvalds

