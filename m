Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbTEFIdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 04:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTEFIdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 04:33:35 -0400
Received: from [12.47.58.20] ([12.47.58.20]:52248 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262457AbTEFIdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 04:33:33 -0400
Date: Tue, 6 May 2003 01:47:45 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030506014745.02508f0d.akpm@digeo.com>
In-Reply-To: <20030506082948.B371D2C003@lists.samba.org>
References: <20030505235549.5df75866.akpm@digeo.com>
	<20030506082948.B371D2C003@lists.samba.org>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 08:45:58.0516 (UTC) FILETIME=[EA256340:01C313AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> It's a tradeoff, but I think it's worth it for a kmalloc_percpu which
> is fast, space-efficient and numa-aware, since the code is needed
> anyway.

I don't beleive that kmalloc_percpu() itself needs to be fast, as you say.

The code is _not_ NUMA-aware.  Is it?

> How about a compromise like the following (scaled with mem)?
> Untested, but you get the idea...

> +	/* Plenty of memory?  1GB = 64k per-cpu. */
> +	pool_size = max(((long long)num_physpages << PAGE_SHIFT) / 16384,
> +			(long long)pool_size);

On 64GB 32-way that's 128MB of lowmem.  Unpopular.  I'd settle for a __setup
thingy here, and a printk when the memory runs out.

btw, what's wrong with leaving kmalloc_percpu() as-is, and only using this
allocator for DEFINE_PERCPU()?


