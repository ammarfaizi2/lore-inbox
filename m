Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318027AbSG2FeL>; Mon, 29 Jul 2002 01:34:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318028AbSG2FeL>; Mon, 29 Jul 2002 01:34:11 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9091 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S318027AbSG2FeK>;
	Mon, 29 Jul 2002 01:34:10 -0400
Date: Mon, 29 Jul 2002 07:37:46 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Marcin Dalecki <dalecki@evision.ag>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
Message-ID: <20020729073746.A4437@suse.de>
References: <200207282013.g6SKDjg02769@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207282013.g6SKDjg02769@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28 2002, James Bottomley wrote:
> > You are right the
> > > rq->flags &= REQ_QUEUED;
> > > and the
> > > if (blk_rq_tagged(rq))
> > blk_queue_end_tag(q, rq);
> > > should be just removed and things are fine.
> > They only survive becouse they don't provide a tag for the request in
> > first place.
> > > Thanks for pointing it out.
> 
> 
> Please don't remove this.
> 
> insert_special isn't just used to start new requests, it's also used to queue 
> incoming requests that cannot be processed by the device (host adapter, 
> queue_full etc.).
> 
> In this latter case, the tag is already begun, so it needs to go back with 
> end_tag (we start a new tag when the device begins processing again).
> 
> I own up to introducing the &= REQ_QUEUED rubbish---I was just keeping the 
> original  placement of the flag clearing code, but now we need to preserve 
> whether the request was queued or not for the blk_rq_tagged check.  On 
> reflection it would have been better just to set the flags to REQ_SPECIAL | 
> REQ_BARRIER after the end tag code.

I think you are missing the point. The stuff should not be in the
_generic_ blk_insert_request(). As I posted in my first reply to Martin,
SCSI needs to clear the tag before calling blk_insert_request() if it
needs to.

> axboe@suse.de said:
> > But the crap still got merged, sigh... Yet again an excellent point of
> > why stuff like this should go through the maintainer. Apparently Linus
> > blindly applies this stuff.
> 
> Hmm, well I sent it to you and you are the Maintainer.

I've never seen it?!

-- 
Jens Axboe

