Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbTEZSFw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 14:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTEZSFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 14:05:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:29889 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262138AbTEZSFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 14:05:49 -0400
Date: Mon, 26 May 2003 20:18:52 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCHES] add ata scsi driver
Message-ID: <20030526181852.GL845@suse.de>
References: <1053972773.2298.177.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053972773.2298.177.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26 2003, James Bottomley wrote:
> 
>     On Mon, May 26 2003, Linus Torvalds wrote:
>     > > What does the block layer need, that it doesn't have now?
>     > 
>     > Exactly. I'd _love_ for people to really think about this.
>     
>     In discussion with Jeff, it seems most of what he wants is already
>     there. He just doesn't know it yet :-)
>     
>     Maybe that's my problem as well, maybe the code / comments / doc /
>     whatever is not clear enough.
>     
> My wishlist for this would be:
> 
> 1. Unified SG segment allocation.  The SCSI layer currently has a
> mempool implementation to cope with this, is there a reason it can't
> become block generic?

Of course that is doable, when I killed scsi_dma.c it was just a direct
replacement. Given that IDE had no such dynamic sg list allocation
requirements, it stayed in SCSI. Overdesign is never good :)

> 2. Device locality awareness.  Quite a bit of the esoteric SCSI queueing
> code occurs because we have two type of queue events:
> a. device can't accept another command---stop queue and restart when the
> device sends a completion back

This should be doable.

> b. the host adapter is out of resources for *all* its devices.  Block
> all device queues until we free some resources (again, usually a
> returning command).

This is harder, because it involves more than one specific queue.

> 3. Perhaps some type of unified command handling.  At the moment, we all
> seem to allocate DMA'able regions for our commands/taskfiles/whatever
> and attach them to reqest->special.  Then we need to release them again
> before completing the request.
> 
> 4. Same thing goes for sense buffers.

Completely agree.

> 5. There needs to be some amalgam of the SCSI code for dynamic tag
> command queue depth handling.

Again, block layer queueing was designed for what I needed (ide tcq) and
no overdesign was attempted. If you describe what you need, I'd be very
happy to oblige and add those bits. Some decent depth change handling, I
presume?

-- 
Jens Axboe

