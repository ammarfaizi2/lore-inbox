Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTBFJRG>; Thu, 6 Feb 2003 04:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTBFJRG>; Thu, 6 Feb 2003 04:17:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:13198 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265806AbTBFJRF>;
	Thu, 6 Feb 2003 04:17:05 -0500
Date: Thu, 6 Feb 2003 10:26:28 +0100
From: Jens Axboe <axboe@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Con Kolivas <conman@kolivas.net>
Subject: Re: [PATCH] ide write barriers
Message-ID: <20030206092628.GA31566@suse.de>
References: <20030205151859.GK31566@suse.de> <200302051628.48803.m.c.p@wolk-project.de> <20030205163352.GQ31566@suse.de> <200302052047.11823.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302052047.11823.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05 2003, Marc-Christian Petersen wrote:
> On Wednesday 05 February 2003 17:33, Jens Axboe wrote:
> 
> Hi Jens,
> 
> > Sure, I had that one already. BTW, I discovered that the default io
> thank you :)
> 
> > scheduler forgets to honor the cmd_flags, it's supposed to break like
> > the noop does (see very first hunk in very first file). Must have
> > removed that by mistake some time ago... This applies both to the
> > 2.4.21-pre4 patch posted and this one.
> well, I am impressed, really!
> 
> As you described in the patch:
> 
> + *   For journalled file systems, doing ordered writes on a commit
> + *   block instead of explicitly doing wait_on_buffer (which is bad
> + *   for performance) can be a big win. Block drivers supporting this
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I don't have benchmarks handy yet but as far as I can _feel_, this is
> a _MUST_ (I repeat: a _MUST_ for 2.4.21). And I am very good in
> feeling slowdowns for interactivity :)
> 
> I am running it for quite some hours now with 2.4.20. Well, maybe the 
> nr_requests = 16 and read/write passovers changes in the elevator code give 
> us more smoothness than w/o but in my theoretical mind, this should drop 
> throughput. I also noticed, these changes aren't in your 2.4.21 patch. Can 
> you explain why it is in 2.4.20 patch or why it isn't in 2.4.21 patch ? :)

There are not in the 2.4.21-pre patch, because the 2.4.20 got mixed with
another patch. The limiting of number of queue requests is a different
patch, and it's quite likely it will provide better interactiveness for
you. But it will also considerably drop throughput, depends on the work
load whether that's the case or not.

I don't think ext3 will show a performance boost with the supplied
patch, but the stuff for reiser that Christ did definitely will.

-- 
Jens Axboe

