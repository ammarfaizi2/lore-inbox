Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262393AbTEFGli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262400AbTEFGli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:41:38 -0400
Received: from [12.47.58.20] ([12.47.58.20]:64017 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262393AbTEFGlh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:41:37 -0400
Date: Mon, 5 May 2003 23:55:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: "David S. Miller" <davem@redhat.com>
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
Message-Id: <20030505235549.5df75866.akpm@digeo.com>
In-Reply-To: <20030505.223554.88485673.davem@redhat.com>
References: <20030505220250.213417f6.akpm@digeo.com>
	<20030505.211606.28803580.davem@redhat.com>
	<20030505224815.07e5240c.akpm@digeo.com>
	<20030505.223554.88485673.davem@redhat.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 May 2003 06:54:03.0733 (UTC) FILETIME=[47D2D050:01C3139C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> wrote:
>
> Your grep is faulty, we're using kmalloc_percpu() in ipv6 for per-cpu
> and per-device icmp stats.

My grep is fine.  It's the brain which failed ;)

> You solution doesn't work in that case.  Also ipv4 will have the same
> problems if we make that modular at some point.
> 
> I also don't see how this fits in for your ext2 fuzzy counter stuff.

Well it doesn't fit.  With the proposals which we are discussing here, ext2
(and, we hope, soon ext3) would continue to use foo[NR_CPUS].

> It isn't a "module" for most people, I can't even remember if I've
> ever built ext2 non-statically.  :-)  It almost appears as if you
> are suggesting kmalloc_percpu() is not usable at all.

kmalloc_per_cpu() is useful at present.  But with Rusty's patch it becomes
less useful.

Aside: I rather think that 4000 filesystems isn't sane.  4000 disks is, but I
find it hard to believe that people will have a separate fs on each one...

> So there we have it, there are a total of 3 users of kmalloc_percpu()
> (ipv4/ipv6/diskstats) so let's decide if it's going to continue to
> live longer or not before there are any more. :-)

How about we leave kmalloc_per_cpu as-is (it uses kmalloc()), and only apply
Rusty's new code to DEFINE_PER_CPU?

