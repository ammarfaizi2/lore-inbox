Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263258AbVGAHBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbVGAHBd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263256AbVGAHBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:01:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54450 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263258AbVGAHBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:01:06 -0400
Date: Fri, 1 Jul 2005 09:02:20 +0200
From: Jens Axboe <axboe@suse.de>
To: mike.miller@hp.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] cciss per disk queue for 2.6
Message-ID: <20050701070219.GV2243@suse.de>
References: <20050630210342.GA28770@beardog.cca.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630210342.GA28770@beardog.cca.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30 2005, mike.miller@hp.com wrote:
> This patch adds per disk queue functionality to cciss. Sometime back I
> submitted a patch but it looks like only part of what I needed. In the
> 2.6 kernel if we have more than one logical volume the driver will
> Oops during rmmod. It seems all of the queues actually point back to
> the same queue. So after deleting the first volume you hit a null
> pointer on the second one.
> 
> This has been tested in our labs. There is no difference in
> performance, it just fixes the Oops. Please consider this patch for
> inclusion.

Going to per-disk queues is undoubtedly a good idea, performance will be
much better this way. So far, so good.

But you need to do something about the queueing for this to be
acceptable, imho. You have a per-controller queueing limit in place, you
need to enforce some fairness to ensure an equal distribution of
commands between the disks.

Perhaps just limit the per-queue depth to something sane, instead of the
huuuge 384 commands you have now. I've had several people complain to
me, that ciss is doing some nasty starvation with that many commands in
flight and we've effectively had to limit the queueing depth to
something really low to get adequate read performance in presence of
writes.


-- 
Jens Axboe

