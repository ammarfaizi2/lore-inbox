Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTKKTyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263732AbTKKTyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 14:54:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:17851 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263728AbTKKTyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 14:54:08 -0500
Date: Tue, 11 Nov 2003 11:58:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: steiner@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-Id: <20031111115804.4aaafd28.akpm@osdl.org>
In-Reply-To: <20031111082915.GC1130@llm08.in.ibm.com>
References: <20031110215844.GC21632@sgi.com>
	<20031111082915.GC1130@llm08.in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> On Mon, Nov 10, 2003 at 03:58:44PM -0600, Jack Steiner wrote:
> > 
> > I dont know the background on note_interrupt() in arch/ia64/kernel/irq.c, 
> > but I had to disable the function on our large systems (IA64).
> > 
> > The function updates a counter in the irq_desc_t table. An entry in this table
> > is shared by all cpus that take a specific interrupt #. For most interrupt #'s,
> > this is a problem but it is prohibitive for the timer tick on big systems.
> > 
> > Updating the counter causes a cache line to be bounced between
> > cpus at a rate of at least HZ*active_cpus. (The number of bus transactions
> 
> The answer to this is probably alloc_percpu for the counters.

Or just make noirqdebug the default.

The note_interrupt() stuff is only useful for diagnosing mysterious lockups
(and hasn't proven useful for that, actually).  It should be disabled for
production use.


