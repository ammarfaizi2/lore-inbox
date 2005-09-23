Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVIWHMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVIWHMP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 03:12:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVIWHMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 03:12:15 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2695 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbVIWHMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 03:12:14 -0400
Date: Fri, 23 Sep 2005 00:10:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: davem@davemloft.net, rusty@rustcorp.com.au, dipankar@in.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 0/6] mm: alloc_percpu and  bigrefs
Message-Id: <20050923001013.28b7f032.akpm@osdl.org>
In-Reply-To: <20050923062529.GA4209@localhost.localdomain>
References: <20050923062529.GA4209@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Added linux-kernel)

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> Hi Andrew,
> This patchset contains alloc_percpu + bigrefs + bigrefs for netdevice
> refcount.  This patchset improves tbench lo performance by 6% on a 8 way IBM
> x445.

I think we'd need more comprehensive benchmarks than this before adding
large amounts of complex core code.

We'd also need to know how much of any performance improvement was due to
alloc_percpu versus bigrefs, please.

Bigrefs look reasonably sane to me, but a whole new memory allocator is a
big deal.  Given that alloc_percpu() is already numa-aware, is that extra
cross-node fetch and pointer hop really worth all that new code?  The new
version will have to do a tlb load (including a cross-node fetch)
approximately as often as the old version will get a CPU cache miss on the
percpu array, maybe?


