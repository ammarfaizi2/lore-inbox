Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTKKIX2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 03:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTKKIX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 03:23:28 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:20703 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264274AbTKKIX1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 03:23:27 -0500
Date: Tue, 11 Nov 2003 13:59:15 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031111082915.GC1130@llm08.in.ibm.com>
References: <20031110215844.GC21632@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031110215844.GC21632@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 03:58:44PM -0600, Jack Steiner wrote:
> 
> I dont know the background on note_interrupt() in arch/ia64/kernel/irq.c, 
> but I had to disable the function on our large systems (IA64).
> 
> The function updates a counter in the irq_desc_t table. An entry in this table
> is shared by all cpus that take a specific interrupt #. For most interrupt #'s,
> this is a problem but it is prohibitive for the timer tick on big systems.
> 
> Updating the counter causes a cache line to be bounced between
> cpus at a rate of at least HZ*active_cpus. (The number of bus transactions

The answer to this is probably alloc_percpu for the counters.
right now this might not possible because irq_desc_t table might be used very
early, and alloc_percpu uses slab underneath.  alloc_percpu will have to be 
made to work early enough for this....

Thanks,
Kiran

