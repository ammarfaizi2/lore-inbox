Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272859AbRIPWAQ>; Sun, 16 Sep 2001 18:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272875AbRIPWAJ>; Sun, 16 Sep 2001 18:00:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22541 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S272859AbRIPV7w>;
	Sun, 16 Sep 2001 17:59:52 -0400
Date: Mon, 17 Sep 2001 00:00:12 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, arjanv@redhat.com,
        "David S. Miller" <davem@redhat.com>
Subject: Re: [patch] block highmem zero bounce v14
Message-ID: <20010917000012.B12270@suse.de>
In-Reply-To: <20010916234307.A12270@suse.de> <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0109161447390.29507-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16 2001, Linus Torvalds wrote:
> 
> On Sun, 16 Sep 2001, Jens Axboe wrote:
> >
> > It's against 2.4.10-pre9 and can be found right here:
> >
> > *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4.10-pre9/block-highmem-all-14
> 
> Jens, what's your feeling about the stability of these things, especially
> wrt weird drivers?

One of the very first decisions I made wrt this patch was to make sure
that weird/old drivers could keep on working exactly the way they do now
and never have to worry about highmem stuff. That basically means
enabling the stuff on a per-driver basis after it's considered safe. The
can_dma_32 for SCSI and highmem for IDE flag serves that purpose. Stand
alone block drivers just use blk_queue_bounce_limit to enable highmem
I/O after blk_init_queue, if they don't they get highmem pages bounced
as they are used too.

That leaves drivers that are 'different', stuff like ide-scsi for
instance. I think I have most of these under control...

> Ie do you think this is really a 2.4.x thing, or early 2.5.x?

Most of it is really a cautious back port of the 2.5 stuff I've been
working on, and with the above considerations it is/was meant as a 2.4
thing :-)

-- 
Jens Axboe

