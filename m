Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315413AbSHHF5r>; Thu, 8 Aug 2002 01:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSHHF5r>; Thu, 8 Aug 2002 01:57:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54165 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315413AbSHHF5q>;
	Thu, 8 Aug 2002 01:57:46 -0400
Date: Thu, 8 Aug 2002 08:00:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
       jmacd@namesys.com, phillips@arcor.de, rml@tech9.net
Subject: Re: [PATCH] lock assertion macros for 2.5.30
Message-ID: <20020808060045.GM2243@suse.de>
References: <20020807205134.GA27013@sgi.com> <Pine.LNX.4.44L.0208071758280.23404-100000@imladris.surriel.com> <20020807210855.GA27182@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020807210855.GA27182@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07 2002, Jesse Barnes wrote:
> On Wed, Aug 07, 2002 at 06:02:19PM -0300, Rik van Riel wrote:
> > On Wed, 7 Aug 2002, Jesse Barnes wrote:
> > 
> > > +++ linux-2.5.30-lockassert/drivers/scsi/scsi.c Wed Aug  7 11:35:32 2002
> > > @@ -262,7 +262,7 @@
> > 
> > > +        MUST_NOT_HOLD(q->queue_lock);
> > 
> > ...
> > 
> > > +#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
> > > +#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
> > > +#define MUST_NOT_HOLD(lock)		BUG_ON(spin_is_locked(lock))
> > 
> > Please tell me the MUST_NOT_HOLD thing is a joke.
> > 
> > What is to prevent another CPU in another code path
> > from holding this spinlock when the code you've
> > inserted the MUST_NOT_HOLD in is on its merry way
> > not holding the lock ?
> 
> Nothing at all, but isn't that how the scsi ASSERT_LOCK(&lock, 0)
> macro worked before?  I could just remove all those checks in the scsi
> code I guess.

The SCSI ASSERT_LOCK() were never used from kernel space, they are for
the user space similator. So it was always single threaded from there
and has no bearing on what actual kernel code does.

For MUST_NOT_HOLD to work, you need to take into account which processor
took the lock etc.

> After I posted the last patch, a few people asked for MUST_NOT_HOLD so
> I added it back in.  Do you think it's a bad idea?  See the last

Your current version is surely worthless.

-- 
Jens Axboe

