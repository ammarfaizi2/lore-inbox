Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315870AbSENQvi>; Tue, 14 May 2002 12:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315871AbSENQvi>; Tue, 14 May 2002 12:51:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14997 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315870AbSENQvg>;
	Tue, 14 May 2002 12:51:36 -0400
Date: Tue, 14 May 2002 18:51:13 +0200
From: Jens Axboe <axboe@suse.de>
To: Neil Conway <nconway.list@ukaea.org.uk>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
Message-ID: <20020514165113.GT17509@suse.de>
In-Reply-To: <E177dYp-00083c-00@the-village.bc.nu> <3CE11F90.5070701@evision-ventures.com> <3CE13943.FBD5B1D6@ukaea.org.uk> <20020514163241.GR17509@suse.de> <3CE13F99.5BDED3DF@ukaea.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14 2002, Neil Conway wrote:
> > To really serialize operations the queue _must_ be shared with whoever
> > requires serialiation.
> 
> Why will this help?  The hardware can still be doing DMA on hda while
> the queue's request_fn is called quite legitimately for a hdb request -
> and the IDE code MUST impose the serialization here to avoid hitting the
> cable with commands destined for hdb. (For example, by waiting for
> !channel->busy.)

Current IDE code leaves a request on the list until it has completed
(this is ignoring TCQ of course), so there's no way that you could start
serving a second request before the first one completes.

> > If not, the problem will have to be solved at the IDE level, not the
> > block level. And that has not looked pretty in the past.
> 
> I just can't see a way for the block level to remove the need for the
> busy flag.  I _think_ Alan just agreed with me.  I'm not sure but I get
> the impression that you are saying the IDE code doesn't need to do this
> serialization...

To be honest, I haven't given it too much thought right now. The nice
thing about the queue level serialization is that it all happens
automagically for IDE, without having it maintain any busy state on that
itself.

However, I may just talking out of my ass and implementation details
will mean it's still better to at least manage some of the serialization
at the ide level.

-- 
Jens Axboe

