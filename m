Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSAVIRZ>; Tue, 22 Jan 2002 03:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289208AbSAVIRO>; Tue, 22 Jan 2002 03:17:14 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:1540 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289209AbSAVIRD>;
	Tue, 22 Jan 2002 03:17:03 -0500
Date: Tue, 22 Jan 2002 09:16:53 +0100
From: Jens Axboe <axboe@suse.de>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020122091653.J1018@suse.de>
In-Reply-To: <20020122082030.A12720@suse.cz> <Pine.LNX.4.10.10201212333540.16815-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10201212333540.16815-100000@master.linux-ide.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21 2002, Andre Hedrick wrote:
> > On Mon, Jan 21, 2002 at 03:53:20PM -0800, Andre Hedrick wrote:
> > > On Mon, 21 Jan 2002, Vojtech Pavlik wrote:
> > > Okay if the execution of the command block is ATOMIC, and we want to stop
> > > an ATOMIC operation to go alter buffers? 
> > 
> > YES! I think you got it! Because atomic here doesn't mean 'do it all as
> > soon as possible with no delay', but 'do nothing else on the ATA bus
> > inbetween'.
> 
> In order to do this you can not issue a sector request larger than an
> addressable buffer, since the request walking of the rq->buffer is not
> allowed.

It's not that it's not allowed, it's that it doesn't work the way you
want it. ->buffer is just the first segment, which is 8 sectors max,
that much is correct. But nothing prevents your from ending the front
of the request and continuing and the drive will never know. Just see
task_mulin_intr.

-- 
Jens Axboe

