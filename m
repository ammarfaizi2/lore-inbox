Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbTFDK3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTFDK3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:29:33 -0400
Received: from ns.suse.de ([213.95.15.193]:63237 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263182AbTFDK3b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:29:31 -0400
Date: Wed, 4 Jun 2003 12:43:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Message-ID: <20030604104304.GQ3412@x30.school.suse.de>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <Pine.LNX.4.55L.0305291609580.14835@freak.distro.conectiva> <20030604102241.GM3412@x30.school.suse.de> <200306041235.07832.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306041235.07832.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:35:07PM +0200, Marc-Christian Petersen wrote:
> On Wednesday 04 June 2003 12:22, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > are you really sure that it is the right fix?
> > I mean, the batching has a basic problem (I was discussing it with Jens
> > two days ago and he said he's already addressed in 2.5, I wonder if that
> > could also have an influence on the fact 2.5 is so much better in
> > fariness)
> > the issue with batching in 2.4, is that it is blocking at 0 and waking
> > at batch_requests. But it's not blocking new get_request to eat requests
> > in the way back from 0 to batch_requests. I mean, there are two
> > directions, when we move from batch_requests to 0 get_requests should
> > return requests. in the way back from 0 to batch_requests the
> > get_request should block (and it doesn't in 2.4, that is the problem)
> do you see a chance to fix this up in 2.4?

sure, it's just a matter of adding a bit to the blkdev structure.
However I'm not 100% sure that it is the real thing that could make the
difference, but overall the exclusive wakeup FIFO in theory should
provide even an higher degree of fariness, so at the very least the
"fix" 2 from Andrew makes very little sense to me, and it seems just an
hack meant to hide a real problem in the algorithm.

I mean, going wakeall (LIFO btw) rather than wake-one FIFO if something
should make things worse unless it is hiding some other issue.

As for 1 and 3 they were just included in my tree for ages.

BTW, Chris recently spotted a nearly impossible to trigger SMP-only race
in the fix pausing patch [great spotting Chris] (to trigger it would
need an intersection of two races at the same time), it'll be fixed in
my next tree, however nobody ever reproduced it and you certainly can
ignore it in practice so it can't explain any issue.

Andrea
