Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSGXORD>; Wed, 24 Jul 2002 10:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317283AbSGXORC>; Wed, 24 Jul 2002 10:17:02 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:56716 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317258AbSGXOQ6>;
	Wed, 24 Jul 2002 10:16:58 -0400
Date: Wed, 24 Jul 2002 16:19:54 +0200
From: Jens Axboe <axboe@suse.de>
To: martin@dalecki.de
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: cpqarray broken since 2.5.19
Message-ID: <20020724141954.GF5159@suse.de>
References: <Pine.SOL.4.30.0207241606090.15605-100000@mion.elka.pw.edu.pl> <3D3EB576.1040601@evision.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3EB576.1040601@evision.ag>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24 2002, Marcin Dalecki wrote:
> 
> >
> >Jens, the same is in cciss.c.
> >Please remove locking from blk_stop_queue() (as you suggested) or intrduce
> >unlocking in request_functions.
> >
> Bartek I think the removal is just for reassertion that the
> locking is the problem. You can't remove it easly from
> blk_stop_queue() unless you make it mandatory that blk_stop_queue
> has to be run with the lock already held. Or in other words
> basically -> Don't use blk_stop_queue() outside of ->request_fn.

Of couse Bart is advocating just making sure that every caller of
blk_stop_queue() _has_ the queue_lock before calling it, not removing
the locking there.

-- 
Jens Axboe

