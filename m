Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315830AbSENQsj>; Tue, 14 May 2002 12:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315832AbSENQsi>; Tue, 14 May 2002 12:48:38 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:14635 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315830AbSENQsh>; Tue, 14 May 2002 12:48:37 -0400
Message-ID: <3CE13F99.5BDED3DF@ukaea.org.uk>
Date: Tue, 14 May 2002 17:47:21 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com> <3CE13943.FBD5B1D6@ukaea.org.uk> <20020514163241.GR17509@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Tue, May 14 2002, Neil Conway wrote:
> > that's all the actual spinlock buys you.  It does not IIUC mean that you
> > can't get a call to request_fn of one queue while the other queue has
> > lots of requests in it (which are potentially being serviced by DMA).
> 
> Bingo, this is exactly right and makes the point a hell of a lot better
> than I did in my previous mail. Shared locks will only buy you that
> noone fiddles with one list while the other is busy (ie nothing for us).

Cool, thanks ;-)  Now watch me blow all my cred with this post:

> To really serialize operations the queue _must_ be shared with whoever
> requires serialiation.

Why will this help?  The hardware can still be doing DMA on hda while
the queue's request_fn is called quite legitimately for a hdb request -
and the IDE code MUST impose the serialization here to avoid hitting the
cable with commands destined for hdb. (For example, by waiting for
!channel->busy.)

> If not, the problem will have to be solved at the IDE level, not the
> block level. And that has not looked pretty in the past.

I just can't see a way for the block level to remove the need for the
busy flag.  I _think_ Alan just agreed with me.  I'm not sure but I get
the impression that you are saying the IDE code doesn't need to do this
serialization...

I'm certainly learning, thanks guys.
Neil
