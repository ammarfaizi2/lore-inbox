Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263964AbRFHLZ0>; Fri, 8 Jun 2001 07:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263965AbRFHLZR>; Fri, 8 Jun 2001 07:25:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56331 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263964AbRFHLZL>;
	Fri, 8 Jun 2001 07:25:11 -0400
Date: Fri, 8 Jun 2001 13:19:36 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Patrick Mochel <mochel@transmeta.com>, Alan Cox <alan@redhat.com>,
        "David S. Miller" <davem@redhat.com>,
        MOLNAR Ingo <mingo@chiara.elte.hu>, Richard Henderson <rth@cygnus.com>,
        Kanoj Sarcar <kanoj@google.engr.sgi.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 32-bit dma memory zone
Message-ID: <20010608131936.X506@suse.de>
In-Reply-To: <20010607153119.H1522@suse.de> <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0106071402480.6604-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Jun 07, 2001 at 02:22:10PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07 2001, Linus Torvalds wrote:
> 
> On Thu, 7 Jun 2001, Jens Axboe wrote:
> > 
> > I'd like to push this patch from the block highmem patch set, to prune
> > it down and make it easier to include it later on :-)
> > 
> > This patch implements a new memory zone, ZONE_DMA32. It holds highmem
> > pages that are below 4GB, as we can do I/O on those directly. Also if we
> > do need to bounce a > 4GB page, we can use pages from this zone and not
> > always resort to < 960MB pages.
> 
> Patrick Mochel has another patch that adds another zone on x86: the "low
> memory" zone for the 0-1MB area, which is special for some things, notably
> real mode bootstrapping (ie the SMP stuff could use it instead of the
> current special-case allocations, and Pat needs it for allocating low
> memory pags for suspend/resumt).
> 
> I'd like to see what these two look like together.

Not a problem, would be easy to add 'one more zone'.

> But even more I'd like to see a more dynamic zone setup: we already have

[snip]

Sure this looks pretty sane. Is this really what you want for 2.4? How
about just adding the DMA32 and 1M zone right now, and postpone the
bigger zone changes to 2.5. To be honest, I already started implementing
your specified interface -- most of the changes aren't too bad, but
still...

-- 
Jens Axboe

