Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTDYLh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263505AbTDYLh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:37:27 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:10684 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263205AbTDYLh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:37:26 -0400
Date: Fri, 25 Apr 2003 13:49:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexander Atanasov <alex@ssi.bg>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/PATCH] IDE Power Management try 1
Message-ID: <20030425114932.GL1012@suse.de>
References: <1051189194.13267.23.camel@gaston> <3EA90176.2080304@ssi.bg> <1051270378.15078.22.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051270378.15078.22.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 25 2003, Benjamin Herrenschmidt wrote:
> 
> > 		What about this - add __REQ_DRIVE_INTERNAL, and carry args in 
> > rq->cmd[16] [0] = PM, [1] = SUSPEND/RESUME, [2]= STATE ? IDE can use it 
> > for power managment, error handling (do not do it from interrupt 
> > context, but queue it), may be more. This way it would really makes 
> > things a bit better with the complicated IDE locking. SCSI and probably 
> > other block devices can benefit from this internal requests too, so the 
> > bit is not wasted.
> 
> I agree. IDE locking isn't _that_ complicated ;) Though currently, we do

>From the request side of things, IDE is very simple.

> handle requests right on interrupt completion so error handling wouldn't
> be deferred by this trick.
> 
> Jens, what do you think ? You are the blkdev.h guy :)

If you add REQ_DRIVE_INTERNAL, and kill the other ones I mentioned, fine
with me then.

	rq->flags & REQ_DRIVE_INTERNAL
		rq->cmd[0] == PM
			pm stuf
		rq->cmd[0] = taskfile
			taskfile

etc. Make sense?

-- 
Jens Axboe

