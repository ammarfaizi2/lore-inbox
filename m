Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVDGOrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVDGOrP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVDGOrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:47:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62340 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262481AbVDGOqF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:46:05 -0400
Date: Thu, 7 Apr 2005 16:45:58 +0200
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
Message-ID: <20050407144557.GK1847@suse.de>
References: <20050406175838.GC15165@suse.de> <1112811607.5555.15.camel@mulgrave> <20050406190838.GE15165@suse.de> <1112821799.5850.19.camel@mulgrave> <20050407064934.GJ15165@suse.de> <1112879919.5842.3.camel@mulgrave> <20050407132205.GA16517@infradead.org> <1112880658.5842.10.camel@mulgrave> <20050407133222.GJ1847@suse.de> <1112881183.5842.13.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112881183.5842.13.camel@mulgrave>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07 2005, James Bottomley wrote:
> On Thu, 2005-04-07 at 15:32 +0200, Jens Axboe wrote:
> > I think Christophs point is that why add sdev_lock as a pointer, instead
> > of just killing it? It's only used in one location, so it's not really
> > that confusing (and a comment could fix that).
> 
> Because any use of sdev->request_queue->queue_lock would likely succeed
> even after we've freed the device and released the queue.  If it's a
> pointer and we null it after free and release, then any later use will
> trigger an immediate NULL deref oops.

So clear ->request_queue instead.

-- 
Jens Axboe

