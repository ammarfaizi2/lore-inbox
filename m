Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129399AbRCFSpH>; Tue, 6 Mar 2001 13:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRCFSo5>; Tue, 6 Mar 2001 13:44:57 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:5648 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129399AbRCFSoq>; Tue, 6 Mar 2001 13:44:46 -0500
Date: Tue, 6 Mar 2001 10:44:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>, Douglas Gilbert <dougg@torque.net>,
        linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <E14aGHY-0000Yc-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10103061042250.1989-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 6 Mar 2001, Alan Cox wrote:
>
> > > I don't know if there is any way to turn of a write buffer on an IDE disk.
> > You want a forced set of commands to kill caching at init?
> 
> Wrong model
> 
> You want a write barrier. Write buffering (at least for short intervals) in
> the drive is very sensible. The kernel needs to able to send drivers a write
> barrier which will not be completed with outstanding commands before the
> barrier.

Agreed.

Write buffering is incredibly useful on a disk - for all the same reasons
that an OS wants to do it. The disk can use write buffering to speed up
writes a lot - not just lower the _perceived_ latency by the OS, but to
actually improve performance too.

But Alan is right - we needs a "sync" command or something. I don't know
if IDE has one (it already might, for all I know).

		Linus

