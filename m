Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287145AbSAPSvG>; Wed, 16 Jan 2002 13:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSAPSvB>; Wed, 16 Jan 2002 13:51:01 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:36361 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S287155AbSAPSuc>;
	Wed, 16 Jan 2002 13:50:32 -0500
Date: Wed, 16 Jan 2002 19:50:20 +0100
From: Jens Axboe <axboe@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linuxdiskcert.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: block completion races
Message-ID: <20020116195020.E13372@suse.de>
In-Reply-To: <3C45B06C.5AA45DCD@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C45B06C.5AA45DCD@colorfullife.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16 2002, Manfred Spraul wrote:
> > Also, there is this code in ide_do_drive_cmd():
> > 
> >         if (action == ide_wait) {
> >                 wait_for_completion(&wait);     /* wait for it to be serviced */
> >                 return rq->errors ? -EIO : 0;   /* return -EIO if errors */
> >         }
> > 
> > Is it safe to use `rq' here?  It has just been recycled in
> > end_that_request_last() and we don't own it any more.
> >
> 
> Yes, this is safe. rq lies on the stack of the caller of
> ide_do_drive_cmd() - it can't disappear before we return.

Duh yes of course, I was even preaching this on irc the other day :/

-- 
Jens Axboe

