Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319052AbSHFKkq>; Tue, 6 Aug 2002 06:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319053AbSHFKkq>; Tue, 6 Aug 2002 06:40:46 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27848 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S319052AbSHFKko>;
	Tue, 6 Aug 2002 06:40:44 -0400
Date: Tue, 6 Aug 2002 12:44:14 +0200
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Marcin Dalecki <dalecki@evision.ag>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
Message-ID: <20020806104414.GC1132@suse.de>
References: <13AC5F92253@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13AC5F92253@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06 2002, Petr Vandrovec wrote:
> > After all ide_raw_taskfile only gets used for REQ_SPECIAL request
> > types. This does *not* contain normal data request from block IO.
> > As of master slave issues - well we have the data pre allocated per
> > device not per channel! If q->request_fn would properly return the
> > error count instead of void, we could even get rid ot the
> > checking for rq->errors after finishment... But well that's
> > entierly different story.
> 
> For example do_cmd_ioctl() invokes ide_raw_taskfile, without any locking.
> Two programs, both issuing HDIO_DRIVE_CMD at same time, will compete
> over one drive->srequest struct: you'll get same drive->srequest structure
> submitted twice to blk_insert_request (hm, Jens, will this trigger
> BUG, or will this just damage request list?).

Just silently damage request list. We _could_ easily add code to detect
this, but it's not been a problem in the past so not worth looking for.

AFAICS, Petr is completely right wrt this race.

-- 
Jens Axboe

