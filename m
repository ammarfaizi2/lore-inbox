Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313717AbSDPPrt>; Tue, 16 Apr 2002 11:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313716AbSDPPrr>; Tue, 16 Apr 2002 11:47:47 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61711 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313717AbSDPPqs>; Tue, 16 Apr 2002 11:46:48 -0400
Date: Tue, 16 Apr 2002 08:43:35 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Martin Dalecki <dalecki@evision-ventures.com>,
        David Lang <david.lang@digitalinsight.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <200204161414.g3GEE5808527@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0204160837530.1167-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Apr 2002, Richard Gooch wrote:
> 
> This gratuitous removal of features in the guise of "cleanups" is why
> you got flamed earlier this year. I thought you'd learned :-/

Richard, have you looked at the IDE mess? That "feature" is a bug, the way 
it was implemented - and considering that it's implementable at a 
different level much more cleanly for the (few) people who actually need 
it...

Also note that performance is likely to _increase_ by removing that stupid
feature - using DMA to do the actual IO and them byteswapping in some
higher level than the driver is likely to be a _lot_ faster than doing PIO
(and byteswap in-place, resulting in random mmap corruption).

Do you realize that because the current bswap writeback reverses the bytes 
in place, you can actually seriously corrupt your filesystem by just being 
unlucky in timing (ie a bswap on a dirty metadata block at the same time 
another process accesses it)?

It's a BUG guys, not a feature.

		Linus

