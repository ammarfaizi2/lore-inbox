Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751280AbVJQTjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280AbVJQTjb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbVJQTjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:39:31 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28504 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751280AbVJQTja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:39:30 -0400
Date: Mon, 17 Oct 2005 21:40:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "Ananiev, Leonid I" <leonid.i.ananiev@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] indirect function calls elimination in IO scheduler
Message-ID: <20051017194016.GB2811@suse.de>
References: <20051017175858.GY2811@suse.de> <200510171925.j9HJPKg12681@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510171925.j9HJPKg12681@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17 2005, Chen, Kenneth W wrote:
> Jens Axboe wrote on Monday, October 17, 2005 10:59 AM
> > you cannot ref count a statically embedded structure. It has to be
> > dynamically allocated.
> 
> I'm confused.  For every block device queue, there is one unique
> elevator_t structure allocated via kmalloc.  And vice versa, one
> elevator_t has only one request_queue points to it. This elevator_t
> structure is per q since it has pointer to per-queue elevator
> private data.

For every _non_ stacked queue there is an elevator_t structure attached.
That's a seperate point, but it means that embedding the elevator inside
the queue wastes memory (104 bytes per queue on this box I'm typing on)
for dm/md devices.

> Since it is always one to one relationship, ref count is predictable
> and static.  I see there are ref count on q->elevator, But it is
> always 2: one from object instantiation and one from adding an sysfs
> hierarchy directory.  In this case, I don't see the difference.
> Am I missing something?

The reference count does exist outside of the queue getting gotten/put,
the switching being one of them. Tejun has patches for improving the
switching, so it would be possible to keep two schedulers alive for the
queue for the duration of the switch.

-- 
Jens Axboe

