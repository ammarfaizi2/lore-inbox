Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261491AbSJYQsJ>; Fri, 25 Oct 2002 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJYQsJ>; Fri, 25 Oct 2002 12:48:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:60826 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S261489AbSJYQsH>;
	Fri, 25 Oct 2002 12:48:07 -0400
Date: Fri, 25 Oct 2002 18:53:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Markus Plail <plail@web.de>
Cc: linux-kernel@vger.kernel.org, Vegard.Lima@hia.no,
       matthias.welk@fokus.gmd.de
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
Message-ID: <20021025165354.GG4153@suse.de>
References: <20021025103631.GA588@giantx.co.uk> <20021025103938.GN4153@suse.de> <87adl2is1u.fsf@gitteundmarkus.de> <20021025144224.GW4153@suse.de> <87pttyh3r5.fsf@gitteundmarkus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pttyh3r5.fsf@gitteundmarkus.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25 2002, Markus Plail wrote:
> Hi Jens!
> 
> * Jens Axboe writes:
> >Please try:
> >*.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.44/sgio-16.bz2
>                                                                      ^^16b
> >That should fix the silly panic.
> 
> Yes it does. I can't burn though. I attached the cdrecord output. Hava
> a look at the Blocks numbers. Although the image is only 500MB, it says
> it wouldn't fit on the disc which is 700MB. In another try it wanted to
> start burning although I had a bought audio CD in the burner.

As a hack, can you change:

	if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
		rq->errors = sense_key;

in drivers/ide/ide-cd.c:cdrom_decode_status() to

	if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
		rq->errors = 2;

-- 
Jens Axboe

