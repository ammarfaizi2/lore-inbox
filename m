Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290098AbSAWVFi>; Wed, 23 Jan 2002 16:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290081AbSAWVFY>; Wed, 23 Jan 2002 16:05:24 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:25875
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S290098AbSAWVEV>; Wed, 23 Jan 2002 16:04:21 -0500
Date: Wed, 23 Jan 2002 12:57:38 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Jens Axboe <axboe@suse.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: END GAME (Re: Linux 2.5.3-pre1-aia1)
In-Reply-To: <20020123095515.V1018@suse.de>
Message-ID: <Pine.LNX.4.10.10201231252170.23587-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Jens Axboe wrote:

> On Tue, Jan 22 2002, Andre Hedrick wrote:
> > 
> > Linus, Jens,
> > 
> > I need a function that performs the kmapping to return a pointer with all
> > the data needed for that transaction of the data phase, and will cross
> > pages correctly, and may cross more than 2 pages at a time in PIO.
> > I do not care how you do.
> > 
> > char * majic_voodoo_mapping (
> > 	struct request *rq,
> > 	int nsect,
> > 	unsigned long *flags)
> > {
> > 	char * buffer_walk = ide_map_rq(rq, &flags);
> > 	nsect -= ide_rq_offset(rq);
> > 	do {
> > 		buffer_walk += get_some_more(rq, nsect);
> > 	} while (nsect)
> > 	return buffer_walk;
> > }

When I chatted w/ Anton, he suggested a char ** to allow page walking.
This is more in line for allowing a rq->bio_list walking.

Obviously I may not have the correct item but the idea should be clean.

> > This should solve all the problems in the data-phases and let the driver
> > run correctly. The result is on each "get_some_more" will all BLOCK/BIO to
> > return the partial competions of at least one page
> > 
> > The function would behave like ide_end_request but only to adjust the 
> > buffer in process, and make block/bio deal with munging it back to the top
> > layers on the partial completions, it will not stop the data IO process of
> > the ATOMIC command in process.
> 
> That _is_ what ide_end_request is doing, it is not stopping any data I/O
> in progress. It is also atomic. What exactly do you think is missing?

If you are provided with an acceptable solution to make BLOCK/BIO more
flexable to the needs of the hardware, that is a possible answer and
should be acceptable, provided it does not violate other layers ?

> > Better yet, I will shut my PIEHOLE!
> 
> Oh, that'll be the day. Lets just say I'm not running to get my
> calendar and the big fat marker. :-)

Don't worry, I will FedEX one to you so you will not have to search.

Cheers,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

