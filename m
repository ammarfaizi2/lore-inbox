Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTFDLsA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 07:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTFDLsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 07:48:00 -0400
Received: from ns.suse.de ([213.95.15.193]:17418 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263258AbTFDLr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 07:47:58 -0400
Date: Wed, 4 Jun 2003 14:00:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Georg Nikodym <georgn@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
Subject: Re: -rc7   Re: Linux 2.4.21-rc6
Message-ID: <20030604120053.GQ4853@suse.de>
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva> <200306041235.07832.m.c.p@wolk-project.de> <20030604104215.GN4853@suse.de> <200306041246.21636.m.c.p@wolk-project.de> <20030604104825.GR3412@x30.school.suse.de> <3EDDDEBB.4080209@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EDDDEBB.4080209@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04 2003, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >On Wed, Jun 04, 2003 at 12:46:33PM +0200, Marc-Christian Petersen wrote:
> >
> >>On Wednesday 04 June 2003 12:42, Jens Axboe wrote:
> >>
> >>Hi Jens,
> >>
> >>
> >>>>>the issue with batching in 2.4, is that it is blocking at 0 and waking
> >>>>>at batch_requests. But it's not blocking new get_request to eat
> >>>>>requests in the way back from 0 to batch_requests. I mean, there are
> >>>>>two directions, when we move from batch_requests to 0 get_requests
> >>>>>should return requests. in the way back from 0 to batch_requests the
> >>>>>get_request should block (and it doesn't in 2.4, that is the problem)
> >>>>>
> >>>>do you see a chance to fix this up in 2.4?
> >>>>
> >>>Nick posted a patch to do so the other day and asked people to test.
> >>>
> >>Silly mcp. His mail was CC'ed to me :( ... F*ck huge inbox.
> >>
> >
> >I was probably not CC'ed, I'll search for the email (and I was
> >travelling the last few days so I didn't read every single l-k email yet
> >sorry ;)
> >
> >
> The patch I sent is actually against 2.4.20, contrary to my
> babling. Reports I have had say it helps, but maybe not so
> much as Andrew'ss fixes. Then Matthias Mueller ported my patch
> to 2.4.21-rc6 which include Andrew's fixes.
> 
> It seems that they might be fixing two different problems.
> It looks promising though.

It is a different problem I think, yours will fix the starvation of
writers (of readers, writers is much much easier to trigger though)
where someone will repeatedly get cheaten by the request allocator.

The other problem is still not clear to anyone. I doubt this patch would
make any difference (apart from a psychological one) in this case,
since you have a single writer and maybe a reader or two. The single
writer cannot starve anyone else.

-- 
Jens Axboe

