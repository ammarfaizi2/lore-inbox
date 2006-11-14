Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933368AbWKNKV0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933368AbWKNKV0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933374AbWKNKV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:21:26 -0500
Received: from brick.kernel.dk ([62.242.22.158]:29778 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S933368AbWKNKVZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:21:25 -0500
Date: Tue, 14 Nov 2006 11:24:03 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061114102403.GM15031@kernel.dk>
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45598462.80605@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14 2006, Pierre Ossman wrote:
> Jens Axboe wrote:
> > SCSI just sets ->queuedata to NULL, if you store your device there you
> > may do just that. Or just mark your device structure appropriately,
> > there are no special places in the queue for that.
> >
> >   
> 
> I've had another look at it, and I believe I have a solution. There is
> one assumption I need to verify though.
> 
> After del_gendisk() and after I've flushed out any remaining requests,
> is it ok to kill off the queue? Someone might still have the disk open,
> so that would mean the queue is gone by the time gendisk's release
> function is called.

What do you mean by "killing off the queue"? As long as the queue can be
gotten at, it needs to remain valid. That is what the references are
for.

-- 
Jens Axboe

