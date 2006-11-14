Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933271AbWKNImn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933271AbWKNImn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933275AbWKNImm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:42:42 -0500
Received: from brick.kernel.dk ([62.242.22.158]:38933 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933271AbWKNImm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:42:42 -0500
Date: Tue, 14 Nov 2006 09:45:19 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061114084519.GL15031@kernel.dk>
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45597B0A.3060409@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14 2006, Pierre Ossman wrote:
> Jens Axboe wrote:
> >
> > There is no helper to kill already queued requests when a device is
> > removed, if you look at SCSI you'll see that it handles this "manually"
> > as well in the request_fn handler. So you'll need a "device dead or
> > gone" check in your request_fn handler, and do it from there.
> >
> >   
> 
> Is there some part of the current infrastructure I can use to determine
> this. If del_gendisk() grabs the queue lock (and hence is "safe" wrt the
> request handler), then perhaps there is a test that can be done to test
> if the disk has been deleted?

SCSI just sets ->queuedata to NULL, if you store your device there you
may do just that. Or just mark your device structure appropriately,
there are no special places in the queue for that.

-- 
Jens Axboe

