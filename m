Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317299AbSGXOSd>; Wed, 24 Jul 2002 10:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317300AbSGXOSd>; Wed, 24 Jul 2002 10:18:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:20453 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S317299AbSGXOSc>; Wed, 24 Jul 2002 10:18:32 -0400
Date: Wed, 24 Jul 2002 16:21:26 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: <martin@dalecki.de>
cc: Jens Axboe <axboe@suse.de>, Adam Kropelin <akropel1@rochester.rr.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: cpqarray broken since 2.5.19
In-Reply-To: <3D3EB576.1040601@evision.ag>
Message-ID: <Pine.SOL.4.30.0207241619020.15605-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Jul 2002, Marcin Dalecki wrote:

>
> >
> > Jens, the same is in cciss.c.
> > Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> > unlocking in request_functions.
> >
> Bartek I think the removal is just for reassertion that the
> locking is the problem. You can't remove it easly from
> blk_stop_queue() unless you make it mandatory that blk_stop_queue
> has to be run with the lock already held. Or in other words
> basically -> Don't use blk_stop_queue() outside of ->request_fn.

Yep, that how it should be only used.
However you are right these stop/start need some checking.

About idea of using QUEUE_FLAG_STOPPED as IDE_BUSY right now is no go
and will never be.

