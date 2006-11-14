Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933385AbWKNKsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933385AbWKNKsx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 05:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933398AbWKNKsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 05:48:52 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:27404 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S933385AbWKNKsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 05:48:52 -0500
Date: Tue, 14 Nov 2006 10:48:44 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Jens Axboe <jens.axboe@oracle.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to cleanly shut down a block device
Message-ID: <20061114104844.GA15340@flint.arm.linux.org.uk>
Mail-Followup-To: Pierre Ossman <drzeus-list@drzeus.cx>,
	Jens Axboe <jens.axboe@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <455969F2.80401@drzeus.cx> <20061114075648.GK15031@kernel.dk> <45597B0A.3060409@drzeus.cx> <20061114084519.GL15031@kernel.dk> <45598462.80605@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45598462.80605@drzeus.cx>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2006 at 09:54:58AM +0100, Pierre Ossman wrote:
> I've had another look at it, and I believe I have a solution. There is
> one assumption I need to verify though.
> 
> After del_gendisk() and after I've flushed out any remaining requests,
> is it ok to kill off the queue? Someone might still have the disk open,
> so that would mean the queue is gone by the time gendisk's release
> function is called.

Just arrange for the mmc_queue_thread() to empty the queue when
MMC_QUEUE_EXIT is set, and then exit.  I thought this was something
that the block layer looked after (Jens must have missed this in his
original review of the MMC code.)

The handling of userspace keeping the device open despite the hardware
having been removed is already in place.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
