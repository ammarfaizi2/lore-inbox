Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263901AbTDYMBu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 08:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTDYMBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 08:01:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:18073 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263901AbTDYMBs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 08:01:48 -0400
Date: Fri, 25 Apr 2003 14:13:41 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Jens Axboe <axboe@suse.de>, Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] IDE Power Management try 1
In-Reply-To: <1051271853.14994.32.camel@gaston>
Message-ID: <Pine.SOL.4.30.0304251407440.12558-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 Apr 2003, Benjamin Herrenschmidt wrote:

> On Fri, 2003-04-25 at 13:52, Benjamin Herrenschmidt wrote:
> > > If you add REQ_DRIVE_INTERNAL, and kill the other ones I mentioned, fine
> > > with me then.
> > >
> > > 	rq->flags & REQ_DRIVE_INTERNAL
> > > 		rq->cmd[0] == PM
> > > 			pm stuf
> > > 		rq->cmd[0] = taskfile
> > > 			taskfile
> > >
> > > etc. Make sense?
> >
> > As I just wrote, I'd rather go the whole way then and break up flags
> > (which is a very bad name btw) into req_type & req_subtype, though
> > that would mean a bit of driver fixing....
>
> Also, I noticed that my patch has a nice bug in the resume path, I
> use ide_preempt, which doesn't wait for the request to complete,
> but the request & struct state are allocated on the stack... ouch...
>
> It would be interesting to not wait for completion of the resume
> still here, there's no reason why resume of the disk can't be done
> asynchronously since we only release the request queue once completed,
> so I probably need to allocate the suspend request and release it from
> interrupt.
>
> Also, having a separate structure pointed to by ->special only makes
> this more complicated, there are plenty of fields in struct request
> that I could indeed use for my state information (like the cmd[] stuff)
>
> Ben.

Why can't we simply change ide_do_drive_command() to take extra
flag specifing wait/do not wait and use it for ide_preempt?

--
Bartlomiej

