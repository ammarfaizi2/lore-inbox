Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTEFGav (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 02:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbTEFGav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 02:30:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:5861 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262386AbTEFGas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 02:30:48 -0400
Date: Mon, 05 May 2003 22:35:54 -0700 (PDT)
Message-Id: <20030505.223554.88485673.davem@redhat.com>
To: akpm@digeo.com
Cc: rusty@rustcorp.com.au, dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmalloc_percpu
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030505224815.07e5240c.akpm@digeo.com>
References: <20030505220250.213417f6.akpm@digeo.com>
	<20030505.211606.28803580.davem@redhat.com>
	<20030505224815.07e5240c.akpm@digeo.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Mon, 5 May 2003 22:48:15 -0700

   I think so.  So we'd end up with:
   
   - DEFINE_PER_CPU and kmalloc_percpu() work in core kernel, and use the 32k
     pool.
   
   - DEFINE_PER_CPU in modules uses the 32k pool as well (core kernel does the
     allocation).
   
   - kmalloc_per_cpu() is unavailble to modules (it ain't exported).
   
   AFAICT the only thing which will break is sctp, which needs a trivial
   conversion to DEFINE_PER_CPU.
   
Your grep is faulty, we're using kmalloc_percpu() in ipv6 for per-cpu
and per-device icmp stats.

You solution doesn't work in that case.  Also ipv4 will have the same
problems if we make that modular at some point.

I also don't see how this fits in for your ext2 fuzzy counter stuff.
It isn't a "module" for most people, I can't even remember if I've
ever built ext2 non-statically.  :-)  It almost appears as if you
are suggesting kmalloc_percpu() is not usable at all.

So there we have it, there are a total of 3 users of kmalloc_percpu()
(ipv4/ipv6/diskstats) so let's decide if it's going to continue to
live longer or not before there are any more. :-)
