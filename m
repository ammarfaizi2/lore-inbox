Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbTKEPYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 10:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTKEPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 10:24:25 -0500
Received: from ns.suse.de ([195.135.220.2]:13520 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262971AbTKEPYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 10:24:23 -0500
Date: Wed, 5 Nov 2003 16:23:19 +0100
From: Jens Axboe <axboe@suse.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix rq->flags use in ide-tape.c
Message-ID: <20031105152319.GW1477@suse.de>
References: <200311041718.hA4HIBmv027100@hera.kernel.org> <200311051454.27514.bzolnier@elka.pw.edu.pl> <20031105135618.GT1477@suse.de> <200311051616.53701.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311051616.53701.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 05 2003, Bartlomiej Zolnierkiewicz wrote:
> On Wednesday 05 of November 2003 14:56, Jens Axboe wrote:
> > On Wed, Nov 05 2003, Bartlomiej Zolnierkiewicz wrote:
> > > On Wednesday 05 of November 2003 13:00, Bartlomiej Zolnierkiewicz wrote:
> > > > On Wednesday 05 of November 2003 09:40, Jens Axboe wrote:
> > > > > On Tue, Nov 04 2003, Linux Kernel Mailing List wrote:
> > > > > > ChangeSet 1.1413, 2003/11/04 08:01:30-08:00,
> > > > > > B.Zolnierkiewicz@elka.pw.edu.pl
> > > > > >
> > > > > > 	[PATCH] fix rq->flags use in ide-tape.c
> > > > > >
> > > > > > 	Noticed by Stuart_Hayes@Dell.com:
> > > > >
> > > > > Guys, this is _way_ ugly. We definitely dont need more crap in
> > > > > ->flags for private driver use, stuff them somewhere else in the rq.
> > > > > rq->cmd[0] usage would be a whole lot better. This patch should never
> > > > > have been merged. If each and every driver needs 5 private bits in
> > > > > ->flags, well...
> > > >
> > > > Yeah, it is ugly.  Using rq->cmd is also ugly as it hides the problem
> > > > in ide-tape.c, but if you prefer this way I can clean it up.  I just
> > > > wanted minimal changes to ide-tape.c to make it working.
> > >
> > > Also putting these flags in rq->cmd[0] makes it hard to later convert
> > > ide-tape.c to use rq->cmd[] for storing packet commands.
> >
> > What's wrong with just looking at the opcode instead of inventing magic
> > flags. Seems like _just_ the right thing to do, convert to really using
> > rq and killing the private command stuff as much as possible. The latter
> > can wait though, the flag thing really has to go right now.
> 
> It is non-trivial cause it seems packet commands are prepared during
> processing request, not prior to queuing it.  Also I still don't fully

Definitely, it can be done at a later stage.

> understand driver inner-workings with respect to DSC, "pipeline" and internal
> commands processing.

I don't blame you :)

> > ide-*.c driver by Gadi are all completely over designed and attempts to
> > basically implement everything themselves. Horrible.
> 
> Yep, but we should be careful in removing cruft.  I've already had a
> hard time fixing it after (totally unnecessary and broken)
> buffer_head->bio conversion.

Yup that wasn't a very good conversion... I think I even complained at
the time to whomever did it. In my opinion, it's better to keep the
driver broken than accept a bad conversion (someone doing it without
really understanding the driver nor bio stuff) that makes it compile.
The latter is what happened.

-- 
Jens Axboe

