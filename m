Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTDYGLa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 02:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTDYGLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 02:11:30 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:32438 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263055AbTDYGL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 02:11:27 -0400
Date: Fri, 25 Apr 2003 08:23:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Badness in as-iosched:1210
Message-ID: <20030425062329.GB1012@suse.de>
References: <Pine.LNX.4.50.0304222259300.2085-100000@montezuma.mastecende.com> <3EA7A0CC.50005@cyberone.com.au> <20030424084717.GF8775@suse.de> <3EA81A3B.80800@cyberone.com.au> <20030424173228.GT8775@suse.de> <3EA8A5A7.3080003@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA8A5A7.3080003@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25 2003, Nick Piggin wrote:
> Jens Axboe wrote:
> 
> >On Fri, Apr 25 2003, Nick Piggin wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>
> >>>On Thu, Apr 24 2003, Nick Piggin wrote:
> >>>
> >>>
> >>>>Zwane Mwaikambo wrote:
> >>>>
> >>>>
> >>>>
> >>>>>I'm not sure wether you want this, it was during error handling from 
> >>>>>the HBA driver (source was disk error).
> >>>>>
> >>>>>scsi1: ERROR on channel 0, id 3, lun 0, CDB: Read (10) 00 00 7f de 60 
> >>>>>00 00 80 00 Info fld=0x7fdeb2, Current sdd: sense key Medium Error
> >>>>>Additional sense: Unrecovered read error
> >>>>>end_request: I/O error, dev sdd, sector 8380032
> >>>>>Badness in as_add_request at drivers/block/as-iosched.c:1210
> >>>>>
> >>>>>
> >>>>>
> >>>>Thanks I'll have a look.
> >>>>
> >>>>
> >>>The debug check looks broken, request could have come from somewhere
> >>>else than the block pool.
> >>>
> >>>
> >>Thats right. I thought these requests would all be
> >>!blk_fs_request()s though. It should be only the debug
> >>checks which are wrong.
> >>
> >
> >Exactly, the rest looks ok, the debug trigger is wrong :). The
> >add_request() strategy is the entry point for all types of requests, not
> >just blk_fs_request()
> >
> No but it is as_insert_request which is that entry point. It
> should only calls as_add_request for a blk_fs_request.

Oh I see, yes you are right, I should have looked closer (I just assumed
it was your elevator_add_req_fn, your naming is a bit funny :)

The debug check is still a bit silly, and there's nothing that stops it
from being wrong. So I'd still suggest to kill it.

-- 
Jens Axboe

