Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRCFUi1>; Tue, 6 Mar 2001 15:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRCFUiR>; Tue, 6 Mar 2001 15:38:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:28422 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129175AbRCFUiH>;
	Tue, 6 Mar 2001 15:38:07 -0500
Date: Tue, 6 Mar 2001 21:37:20 +0100
From: Jens Axboe <axboe@suse.de>
To: David Balazic <david.balazic@uni-mb.si>
Cc: torvalds@transmeta.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010306213720.U2803@suse.de>
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AA53DC0.C6E2F308@uni-mb.si>; from david.balazic@uni-mb.si on Tue, Mar 06, 2001 at 08:42:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06 2001, David Balazic wrote:
> > > Wrong model 
> > > 
> > > You want a write barrier. Write buffering (at least for short intervals)
> > > in the drive is very sensible. The kernel needs to able to send
> > > drivers a write barrier which will not be completed with outstanding
> > > commands before the 
> > > barrier. 
> > 
> > Agreed. 
> > 
> > Write buffering is incredibly useful on a disk - for all the same reasons 
> > that an OS wants to do it. The disk can use write buffering to speed up 
> > writes a lot - not just lower the _perceived_ latency by the OS, but to 
> > actually improve performance too. 
> > 
> > But Alan is right - we needs a "sync" command or something. I don't know 
> > if IDE has one (it already might, for all I know). 
> 
> ATA , SCSI and ATAPI all have a FLUSH_CACHE command. (*)
> Whether the drives implement it is another question ...

(Usually called SYNCHRONIZE_CACHE btw)

SCSI has ordered tag, which fit the model Alan described quite nicely.
I've been meaning to implement this for some time, it would be handy
for journalled fs to use such a barrier. Since ATA doesn't do queueing
(at least not in current Linux), a synchronize cache is probably the
only way to go there.

> (*) references : 
>   ATA-6 draft standard from www.t13.org
>   MtFuji document from ????????

ftp.avc-pioneer.com

-- 
Jens Axboe

