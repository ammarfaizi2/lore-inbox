Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315827AbSENQdM>; Tue, 14 May 2002 12:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315823AbSENQdL>; Tue, 14 May 2002 12:33:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43667 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315820AbSENQdJ>;
	Tue, 14 May 2002 12:33:09 -0400
Date: Tue, 14 May 2002 18:32:41 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Conway <nconway.list@ukaea.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020514163241.GR17509@suse.de>
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com> <3CE13943.FBD5B1D6@ukaea.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14 2002, Neil Conway wrote:
> On the serialisation issue: what does serialisation of the queues with
> respect to each other mean to you?  I understand it to mean that we
> won't ever call the request_fn of both queues at the same time - because
> that's all the actual spinlock buys you.  It does not IIUC mean that you
> can't get a call to request_fn of one queue while the other queue has
> lots of requests in it (which are potentially being serviced by DMA). 

Bingo, this is exactly right and makes the point a hell of a lot better
than I did in my previous mail. Shared locks will only buy you that
noone fiddles with one list while the other is busy (ie nothing for us).
To really serialize operations the queue _must_ be shared with whoever
requires serialiation.

If not, the problem will have to be solved at the IDE level, not the
block level. And that has not looked pretty in the past.

-- 
Jens Axboe

