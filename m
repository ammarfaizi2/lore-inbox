Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129787AbQJ2WZC>; Sun, 29 Oct 2000 17:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129815AbQJ2WYx>; Sun, 29 Oct 2000 17:24:53 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:30725 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129787AbQJ2WYl>; Sun, 29 Oct 2000 17:24:41 -0500
Message-ID: <39FCA2BC.91D5AA96@timpanogas.org>
Date: Sun, 29 Oct 2000 15:20:44 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Miles Lane <miles@speakeasy.org>,
        Rui Sousa <rsousa@grad.physics.sunysb.edu>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Blocked processes <=> Elevator starvation?
In-Reply-To: <20001027134603.A513@suse.de> <Pine.LNX.4.21.0010280408520.1157-100000@localhost.localdomain> <20001027202710.A825@suse.de> <39FC78BF.90607@speakeasy.org> <20001029144543.D615@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am posting the completed NWFS 2.4.4 tommorrow, and it NEVER exhibits
this lockup problem on the console, no matter how busy the I/O subsystem
underneath becomes.  I think this is probably because I use my own
elevator and LRU and don't use Linus's buffer cache.  Whatever is
causing it I would guess is related to the way the buffer cache
interacts with ll_rw_block().  It's NOT in the VFS since if it were, I
would be seeing it as well, and I don't.  I do see it when I use the
buffer cache with LINUX_BUFFER_CACHE = 1.  I think it may be related to
the bdflush daemon and the way it interacts with ll_rw_block().  The
whole buffer cache needs some serious rework anyway, since it's physical
and not logical, and clustered file systems that use it will always be
buffering multiple data on the systems accross a cluster.  We need
something that uses a logical partition semantic.  

Jeff

Jens Axboe wrote:
> 
> On Sun, Oct 29 2000, Miles Lane wrote:
> > >> There were still some stalls but they only lasted a couple of
> > >> seconds. The patch did make a difference and for the better.
> > >
> > >
> > > Ok, still needs a bit of work. Thanks for the feedback.
> >
> > Have you resolved this problem completely, now?
> >
> > I am testing the USB Storage support with my ORB backup
> > drive.  When I run:
> >
> >       dd if=/dev/zero of=/dev/sda bs=1k count=2G
> >
> > The drive gets data quickly for about thirty seconds.
> > Then the throughput drops off to about ten percent
> > of its previous transfer rate.  This dropoff appears to
> > be due to conflict over accessing filesystems.  Specifically,
> > I have USB_STORAGE_DEBUG enabled, which shoots a ton of
> > debugging output into my kernel log.  When the throughput
> > to the ORB drive falls off, all writing to the syslog
> > ceases.  At least, that's what "tail -f" shows.
> >
> > I would be happy to test any patches you have for this
> > problem.
> 
> Could you send vmstat 1 info from the start of the copy
> and until the i/o rate drops off?
> 
> --
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
