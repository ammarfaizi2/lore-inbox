Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282080AbRL0Oyk>; Thu, 27 Dec 2001 09:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282099AbRL0Oya>; Thu, 27 Dec 2001 09:54:30 -0500
Received: from fepC.post.tele.dk ([195.41.46.147]:28567 "EHLO
	fepC.post.tele.dk") by vger.kernel.org with ESMTP
	id <S282080AbRL0OyQ>; Thu, 27 Dec 2001 09:54:16 -0500
Date: Thu, 27 Dec 2001 15:54:03 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Daniel Stodden <stodden@in.tum.de>,
        linux-kernel@vger.kernel.org
Subject: Re: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
Message-ID: <20011227155403.A1730@suse.de>
In-Reply-To: <E16I8j1-0000ah-00@the-village.bc.nu> <Pine.LNX.4.10.10112231200500.12646-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10112231200500.12646-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23 2001, Andre Hedrick wrote:
> the content is primarily the FS.  Should an APP close a file but it is
> still in buffer_cache, there is no way to notify the app or the user or
> anything associated with the creation/closing of that file, if a write
> error occurs.
> 
> So we have user-space believing it is success.

We have a buggy user-space app believing it is a success -- do you
really believe programs like eg mta's ignorantly closes a file and just
hopes for the best? fsync.

> FS doing an initial ACK of success.
> BLOCK generating the request to the low_level.
> LOW_LEVEL goes OH CRAP, I am having a problem and can not complete.
> 
> LOW_LEVEL goes, HEY BLOCK we have a problem.
> BLOCK, that is nice whatever ....

What does this _mean_?

> This is a bad model, an worse is
> 
> LOW_LEVEL goes, HEY BLOCK we have a problem.
> BLOCK goes, HEY FS we have an annoying LOW_LEVEL asking for reissue.
> FS, duh which way did the rabbit go ...

retries belong at the low level, once you pass up info of failure to the
upper layers it's fatal. time for FS to shut down.

> > Incidentally the EVMS IBM volume manager code does support bad block
> > remapping in some situations.
> 
> Well managing badblock can be a major pain, but it is the right thing to
> do.  Now what is the cost, since there is surge in journaling FS's that
> have logs.  The cost is coming up w/ a sane way to manage the mess.
> Even before we get to managing the mess, we have to be able to reissue the
> request to a reallocated location, and make all kinds of noise that we are
> doing heroic attempts to save the data.  These may include --

Irk, software managed bad block remapping is horrible.

> The issue is we are doing nothing to address the point, and it is arrogant
> for the maintainers of the various storage classes and the supported upper
> layers not willing to address this issue.

How about showing solutions in form of patches instead bitching about
this again and again? Frankly, I'm pretty sick of just seeing pointless
talk about the issue.

-- 
Jens Axboe

