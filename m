Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289737AbSAWIzr>; Wed, 23 Jan 2002 03:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289738AbSAWIzi>; Wed, 23 Jan 2002 03:55:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54281 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289737AbSAWIzb>;
	Wed, 23 Jan 2002 03:55:31 -0500
Date: Wed, 23 Jan 2002 09:55:15 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: END GAME (Re: Linux 2.5.3-pre1-aia1)
Message-ID: <20020123095515.V1018@suse.de>
In-Reply-To: <20020122110621.K1018@suse.de> <Pine.LNX.4.10.10201221449500.19685-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201221449500.19685-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22 2002, Andre Hedrick wrote:
> 
> Linus, Jens,
> 
> I need a function that performs the kmapping to return a pointer with all
> the data needed for that transaction of the data phase, and will cross
> pages correctly, and may cross more than 2 pages at a time in PIO.
> I do not care how you do.
> 
> char * majic_voodoo_mapping (
> 	struct request *rq,
> 	int nsect,
> 	unsigned long *flags)
> {
> 	char * buffer_walk = ide_map_rq(rq, &flags);
> 	nsect -= ide_rq_offset(rq);
> 	do {
> 		buffer_walk += get_some_more(rq, nsect);
> 	} while (nsect)
> 	return buffer_walk;
> }
> 
> This should solve all the problems in the data-phases and let the driver
> run correctly. The result is on each "get_some_more" will all BLOCK/BIO to
> return the partial competions of at least one page
> 
> The function would behave like ide_end_request but only to adjust the 
> buffer in process, and make block/bio deal with munging it back to the top
> layers on the partial completions, it will not stop the data IO process of
> the ATOMIC command in process.

That _is_ what ide_end_request is doing, it is not stopping any data I/O
in progress. It is also atomic. What exactly do you think is missing?

> Better yet, I will shut my PIEHOLE!

Oh, that'll be the day. Lets just say I'm not running to get my
calendar and the big fat marker. :-)

-- 
Jens Axboe

