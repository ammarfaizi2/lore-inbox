Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTKELzn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 06:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTKELzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 06:55:43 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4529 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262848AbTKELzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 06:55:42 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] fix rq->flags use in ide-tape.c
Date: Wed, 5 Nov 2003 13:00:47 +0100
User-Agent: KMail/1.5.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200311041718.hA4HIBmv027100@hera.kernel.org> <20031105084004.GY1477@suse.de>
In-Reply-To: <20031105084004.GY1477@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311051300.47039.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 of November 2003 09:40, Jens Axboe wrote:
> On Tue, Nov 04 2003, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1413, 2003/11/04 08:01:30-08:00,
> > B.Zolnierkiewicz@elka.pw.edu.pl
> >
> > 	[PATCH] fix rq->flags use in ide-tape.c
> >
> > 	Noticed by Stuart_Hayes@Dell.com:
>
> Guys, this is _way_ ugly. We definitely dont need more crap in ->flags
> for private driver use, stuff them somewhere else in the rq. rq->cmd[0]
> usage would be a whole lot better. This patch should never have been
> merged. If each and every driver needs 5 private bits in ->flags,
> well...

Yeah, it is ugly.  Using rq->cmd is also ugly as it hides the problem in
ide-tape.c, but if you prefer this way I can clean it up.  I just wanted
minimal changes to ide-tape.c to make it working.

> Was this even posted on linux-kernel for review?

Yes.

--bartlomiej

> > @@ -218,6 +223,11 @@
> >  #define REQ_PM_SUSPEND	(1 << __REQ_PM_SUSPEND)
> >  #define REQ_PM_RESUME	(1 << __REQ_PM_RESUME)
> >  #define REQ_PM_SHUTDOWN	(1 << __REQ_PM_SHUTDOWN)
> > +#define REQ_IDETAPE_PC1 (1 << __REQ_IDETAPE_PC1)
> > +#define REQ_IDETAPE_PC2 (1 << __REQ_IDETAPE_PC2)
> > +#define REQ_IDETAPE_READ	(1 << __REQ_IDETAPE_READ)
> > +#define REQ_IDETAPE_WRITE	(1 << __REQ_IDETAPE_WRITE)
> > +#define REQ_IDETAPE_READ_BUFFER	(1 << __REQ_IDETAPE_READ_BUFFER)

