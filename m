Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932655AbWJLRDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655AbWJLRDV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932701AbWJLRDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:03:20 -0400
Received: from sycorax.lbl.gov ([128.3.5.196]:65290 "EHLO sycorax.lbl.gov")
	by vger.kernel.org with ESMTP id S932655AbWJLRDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:03:20 -0400
From: Alex Romosan <romosan@sycorax.lbl.gov>
To: Mike Galbraith <efault@gmx.de>
Cc: Jens Axboe <jens.axboe@oracle.com>, linux-kernel@vger.kernel.org,
       olaf@aepfle.de
Subject: Re: 2.6.19-rc1 regression: unable to read dvd's
References: <87hcya8fxk.fsf@sycorax.lbl.gov> <20061012065346.GY6515@kernel.dk>
	<1160648885.5897.6.camel@Homer.simpson.net>
	<1160662435.6177.3.camel@Homer.simpson.net>
	<20061012120927.GQ6515@kernel.dk> <20061012122146.GS6515@kernel.dk>
	<87odshr289.fsf@sycorax.lbl.gov> <20061012152356.GE6515@kernel.dk>
	<87r6xd1qpl.fsf@sycorax.lbl.gov>
	<1160679627.7956.7.camel@Homer.simpson.net>
Date: Thu, 12 Oct 2006 10:02:58 -0700
In-Reply-To: <1160679627.7956.7.camel@Homer.simpson.net> (message from Mike
	Galbraith on Thu, 12 Oct 2006 19:00:27 +0000)
Message-ID: <874pu94gcd.fsf@sycorax.lbl.gov>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith <efault@gmx.de> writes:

> On Thu, 2006-10-12 at 08:47 -0700, Alex Romosan wrote:
>> Jens Axboe <jens.axboe@oracle.com> writes:
>> 
>> > Argh damn, it needs this on top of it as well. Your second problem
>> > likely stems from that missing bit, please retest with this one applied
>> > as well.
>> >
>> > diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
>> > index e7513e5..bddfebd 100644
>> > --- a/drivers/ide/ide-cd.c
>> > +++ b/drivers/ide/ide-cd.c
>> > @@ -716,7 +716,7 @@ static int cdrom_decode_status(ide_drive
>> >  		ide_error(drive, "request sense failure", stat);
>> >  		return 1;
>> >  
>> > -	} else if (blk_pc_request(rq)) {
>> > +	} else if (blk_pc_request(rq) || rq->cmd_type == REQ_TYPE_ATA_PC) {
>> >  		/* All other functions, except for READ. */
>> >  		unsigned long flags;
>> >  
>> 
>> no more strange messages but, once again, i am not able to read movie
>> dvd's with the above patch applied.
>
> Hmm.  Xine still works fine here.
>
> I tried starting xine with no dvd in the drive for grins, and _without_
> this patch, I had to resort to SysRq-E to regain control of my box, and
> that still took quite a while.  I got no oops, but a zillion IO retries
> and sector blah messages.  DoSed me bigtime.  With this patch, I just
> got the expected can't open failure.

works fine for me too as i said in my next message (i initially forgot
to put the dvd in the drive). i guess this is what happens when i try
to test things before my morning espresso...

--alex--

-- 
| I believe the moment is at hand when, by a paranoiac and active |
|  advance of the mind, it will be possible (simultaneously with  |
|  automatism and other passive states) to systematize confusion  |
|  and thus to help to discredit completely the world of reality. |
