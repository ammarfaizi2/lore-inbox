Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264231AbUFKQxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbUFKQxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264175AbUFKQwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:52:38 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:37866 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264231AbUFKQvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:51:35 -0400
Date: Fri, 11 Jun 2004 18:50:39 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and later)
Message-ID: <20040611165039.GB4309@suse.de>
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040611075515.GR13836@suse.de> <20040611161701.GB11095@bounceswoosh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040611161701.GB11095@bounceswoosh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2004, Eric D. Mudama wrote:
> On Fri, Jun 11 at  9:55, Jens Axboe wrote:
> >Proposal looks fine, but please lets not forget that flush cache range
> >is really a band-aid because we don't have a proper ordered write in the
> >first place. Personally, I'd much rather see that implemented than flush
> >cache range. It would be way more effective.
> 
> So something like:
> 
> WRITE FIRST PARTY DMA QUEUED BARRIER EXT
> READ FIRST PARTY DMA QUEUED BARRIER EXT
> READ DMA QUEUED BARRIER EXT
> READ DMA QUEUED BARRIER
> WRITE DMA QUEUED BARRIER
> WRITE DMA QUEUED BARRIER EXT
> 
> 
> ...
> 
> If the drive receives a queued barrier write (NCQ or Legacy), it will
> finish processing all previously-received queued commands and post
> good status for them, then it will process the barrier operation, post
> status for that barrier operation, then it will continue processing
> queued commands in the order received.
> 
> Multiple barrier operations can be in the queue at the same time.  A
> barrier operation has an implied FUA associated with it, such that the
> command (and all previous-in-time commands) must be pushed to the
> media before command completetion can be indicated.
> 
> 
> Is that what would be most useful?

That is _spot on_ the best implementation for writes and what I have
asked for all along :-). I have nothing to add to the above.

I don't have an immediate use for the read-barrier requests (btw, I
think we should call it WRITE_DMA_QUEUED_ORDERED and so forth, clearer
naming), though.

-- 
Jens Axboe

