Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVC2UEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVC2UEn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 15:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbVC2UE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 15:04:27 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62385 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261343AbVC2UER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 15:04:17 -0500
Date: Tue, 29 Mar 2005 22:04:09 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] new fifo I/O elevator that really does nothing at all
Message-ID: <20050329200408.GZ16636@suse.de>
References: <20050329080559.GD16636@suse.de> <200503291850.j2TIogg00494@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503291850.j2TIogg00494@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29 2005, Chen, Kenneth W wrote:
> On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> > The noop elevator is still too fat for db transaction processing
> > workload.  Since the db application already merged all blocks before
> > sending it down, the I/O presented to the elevator are actually not
> > merge-able anymore. Since I/O are also random, we don't want to sort
> > them either.  However the noop elevator is still doing a linear search
> > on the entire list of requests in the queue.  A noop elevator after
> > all isn't really noop.
> >
> > We are proposing a true no-op elevator algorithm, no merge, no
> > nothing. Just do first in and first out list management for the I/O
> > request.  The best name I can come up with is "FIFO".  I also piggy
> > backed the code onto noop-iosched.c.  I can easily pull those code
> > into a separate file if people object.  Though, I hope Jens is OK with
> > it.
> 
> 
> Jens Axboe wrote on Tuesday, March 29, 2005 12:06 AM
> > It's not quite ok, because you don't honor the insertion point in
> > fifo_add_request.
> 
> But it is FIFO!  Honoring insertion point will break the promises this
> elevator made to the user: first in first out.

No such promise was ever made, noop just means it does 'basically
nothing'. It never meant FIFO in anyway, we cannot break the semantics
of block layer commands just for the hell of it.

-- 
Jens Axboe

