Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262477AbVDGNkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262477AbVDGNkP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 09:40:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262478AbVDGNkP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 09:40:15 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:3238 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262477AbVDGNjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 09:39:49 -0400
Subject: Re: [OOPS] 2.6.11 - NMI lockup with CFQ scheduler
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jens Axboe <axboe@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050407133222.GJ1847@suse.de>
References: <20050329120311.GO16636@suse.de>
	 <1112804840.5476.16.camel@mulgrave> <20050406175838.GC15165@suse.de>
	 <1112811607.5555.15.camel@mulgrave> <20050406190838.GE15165@suse.de>
	 <1112821799.5850.19.camel@mulgrave> <20050407064934.GJ15165@suse.de>
	 <1112879919.5842.3.camel@mulgrave> <20050407132205.GA16517@infradead.org>
	 <1112880658.5842.10.camel@mulgrave>  <20050407133222.GJ1847@suse.de>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 09:39:43 -0400
Message-Id: <1112881183.5842.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 15:32 +0200, Jens Axboe wrote:
> I think Christophs point is that why add sdev_lock as a pointer, instead
> of just killing it? It's only used in one location, so it's not really
> that confusing (and a comment could fix that).

Because any use of sdev->request_queue->queue_lock would likely succeed
even after we've freed the device and released the queue.  If it's a
pointer and we null it after free and release, then any later use will
trigger an immediate NULL deref oops.

Since we've had so many nasty problems around refcounting, I just would
like to assure myself that we're doing everything correctly (I really
believe we are, but empirical evidence is also nice).

James


