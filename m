Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267967AbTBSDkf>; Tue, 18 Feb 2003 22:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267968AbTBSDkf>; Tue, 18 Feb 2003 22:40:35 -0500
Received: from packet.digeo.com ([12.110.80.53]:4089 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267967AbTBSDke>;
	Tue, 18 Feb 2003 22:40:34 -0500
Date: Tue, 18 Feb 2003 19:51:40 -0800
From: Andrew Morton <akpm@digeo.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: mikpe@user.it.uu.se, linux-kernel@vger.kernel.org
Subject: Re: module changes
Message-Id: <20030218195140.27b0798f.akpm@digeo.com>
In-Reply-To: <20030219033429.990F62C0CA@lists.samba.org>
References: <15954.22427.557293.353363@gargle.gargle.HOWL>
	<20030219033429.990F62C0CA@lists.samba.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Feb 2003 03:50:27.0526 (UTC) FILETIME=[0A420660:01C2D7CA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> In message <15954.22427.557293.353363@gargle.gargle.HOWL> you write:
> > Rusty Russell writes:
> >  > D: This adds percpu support for modules.  A module cannot have more
> >  > D: percpu data than the base kernel does (on my kernel 5636 bytes).
> > 
> > This limitation is quite horrible.
> > 
> > Does the implementation have to be perfect? The per_cpu API can easily
> > be simulated using good old NR_CPUS arrays:
> 
> The problem is that then you have to have to know whether this is a
> per-cpu thing created in a module, or not, when you use it 8(
> 
> There are two things we can use to alleviate the problem.  The first
> would be to put a minimal cap on the per-cpu data size (eg. 8k).  The
> other possibility is to allocate on an object granularity, in which
> case the rule becomes "no single per-cpu object can be larger than
> XXX", but the cost is to write a mini allocator.
> 

Is kmalloc_percpu() not suitable?
