Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVCDHWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVCDHWe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 02:22:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262527AbVCDHWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 02:22:34 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16593 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262592AbVCDHSN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 02:18:13 -0500
Date: Fri, 4 Mar 2005 08:18:01 +0100
From: Jens Axboe <axboe@suse.de>
To: Florin Iucha <florin@iucha.net>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
Subject: Re: are the io-schedulers per-device?
Message-ID: <20050304071756.GA14764@suse.de>
References: <20050304064053.GC10507@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304064053.GC10507@iucha.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04 2005, Florin Iucha wrote:
> Hello,
> 
> For a semester project I am experimenting with a new IO scheduler and I
> was trying to set my scheduler to control a single device, to ease the
> development and debugging, by using
>    echo "foo" > /sys/block/ubdc/queue/scheduler
> Much to my suprise, this sets the scheduler for the other block
> devices as well! Does this happen only to UML block devices? Do I need
> to do anything to allow a per-device scheduler? Is the functionality
> there, or is it in-progress? Am I reading too much in the fact that
> the queue/scheduler is defined under each block device?

It's per-queue. In general that is per-device, apparently that is not so
for UML since it shares a queue for several devices. From a cleanliness
and performance POV, it's is far better to have a queue per device
instead of sharing, I would suggest fixing the uml block device.

It looks pretty straight forward to do so, except for ubd_handler().
Which, btw, calls elv_next_request() without holding the queue lock!

-- 
Jens Axboe

