Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313914AbSEATIq>; Wed, 1 May 2002 15:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313916AbSEATIp>; Wed, 1 May 2002 15:08:45 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7950 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S313914AbSEATIp>;
	Wed, 1 May 2002 15:08:45 -0400
Date: Wed, 1 May 2002 21:08:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reworked IDE/general tagged command queueing
Message-ID: <20020501190832.GK811@suse.de>
In-Reply-To: <20020501123705.GI837@suse.de> <3CD0165D.6090901@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01 2002, Martin Dalecki wrote:
> U?ytkownik Jens Axboe napisa?:
> >Hi,
> >
> >I've rewritten parts of the IDE TCQ stuff to be, well, a lot better in
> >my oppinion. I had to accept that the ata_request and rq->special usage
> >sucked, it was just one big mess.
> >
> >So following a suggestion from Martin and Linus, I implemented some
> >basic tagged command queueing back end in the block layer. This is what
> >the new IDE TCQ core is build on, and what potentially others can use as
> >well. I'll start by describing the new API:
> 
> 
> Looking at the IDE part we can now see that pushing the
> generic functions one level up the impact on the code flow
> on the IDE side is now:
> 
> 1. Low (most of stuff is due to the ugly /proc special-ide-interface.
> 
> 2. Nicely isolated.
> 
> Great work Jens! (just my humble opinnion).

Thanks!

> However I see a note about the need
> to unify the DMA parts, so I will se what can be done on this
> side becouse I have always planned to get rid of the
> silly switch(ide_dma_function_t) on the dmaproc-path.

I'll try and get some work done on that tomorrow, right now the dmaproc
crap is a garbage bin of stuff rolled into one.

> May I ask you as well to just call ide-tcq.c simple tcq.c?
> The ide- is entierly redundant and I see no need to stick
> to the previous "convention" here. It is just a leftover from
> the days where the IDE stuff didn't sit in his own directory.
> In general  I rather prefer the prefix ata_ instead of ide_ becouse
> we are on the command level and on the host here -
> ide resides on the disk and the whole world
> outside linux calls it ata_. Finally ata_ is far better
> grep-able overall becouse the ide letter combination is very
> common :-) But that's a minor nit of course.

I agree on the ata prefixing, the ide-* has always annoyed me as well.
And you can rename it to tcq.c if you want, I have no oppinion on that.

-- 
Jens Axboe

