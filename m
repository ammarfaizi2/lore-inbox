Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131078AbRCGNvx>; Wed, 7 Mar 2001 08:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131079AbRCGNvn>; Wed, 7 Mar 2001 08:51:43 -0500
Received: from zeus.kernel.org ([209.10.41.242]:7901 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S131078AbRCGNvh>;
	Wed, 7 Mar 2001 08:51:37 -0500
Date: Wed, 7 Mar 2001 13:48:24 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
        Douglas Gilbert <dougg@torque.net>, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: scsi vs ide performance on fsync's
Message-ID: <20010307134824.A3715@redhat.com>
In-Reply-To: <E14aGHY-0000Yc-00@the-village.bc.nu> <Pine.LNX.4.10.10103061042250.1989-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10103061042250.1989-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Mar 06, 2001 at 10:44:34AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 06, 2001 at 10:44:34AM -0800, Linus Torvalds wrote:

> On Tue, 6 Mar 2001, Alan Cox wrote:
> > You want a write barrier. Write buffering (at least for short intervals) in
> > the drive is very sensible. The kernel needs to able to send drivers a write
> > barrier which will not be completed with outstanding commands before the
> > barrier.
> 
> But Alan is right - we needs a "sync" command or something. I don't know
> if IDE has one (it already might, for all I know).

Sync and barrier are very different models.  With barriers we can
enforce some elemnt of write ordering without actually waiting for the
IOs to complete; with sync, we're explicitly asking to be told when
the data has become persistant.  We can make use of both of these.

SCSI certainly lets us do both of these operations independently.  IDE
has the sync/flush command afaik, but I'm not sure whether the IDE
tagged command stuff has the equivalent of SCSI's ordered tag bits.
Andre?

--Stephen
