Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUIIXTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUIIXTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUIIXTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:19:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:23503 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264286AbUIIXTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:19:02 -0400
Date: Thu, 9 Sep 2004 16:22:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cacheline align pagevec structure
Message-Id: <20040909162245.606403d3.akpm@osdl.org>
In-Reply-To: <20040909230905.GO3106@holomorphy.com>
References: <20040909163929.GA4484@logos.cnet>
	<20040909155226.714dc704.akpm@osdl.org>
	<20040909230905.GO3106@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Thu, Sep 09, 2004 at 03:52:26PM -0700, Andrew Morton wrote:
> > No, it was just a randomly-chosen batching factor.
> > The tradeoff here is between
> > a) lock acquisition frequency versus lock hold time (increasing the size
> >    helps).
> > b) icache misses versus dcache misses. (increasing the size probably hurts).
> > I suspect that some benefit would be seen from making the size very small
> > (say, 4). And on some machines, making it larger might help.
> 
> Reducing arrival rates by an Omega(NR_CPUS) factor would probably help,
> though that may blow the stack on e.g. larger Altixen. Perhaps
> O(lg(NR_CPUS)), e.g. NR_CPUS > 1 ? 4*lg(NR_CPUS) : 4 etc., will suffice,
> though we may have debates about how to evaluate lg(n) at compile-time...
> Would be nice if calls to sufficiently simple __attribute__((pure))
> functions with constant args were considered constant expressions by gcc.

Yes, that sort of thing.

It wouldn't be surprising if increasing the pagevec up to 64 slots on big
ia64 SMP provided a useful increase in some fs-intensive workloads.

One needs to watch stack consumption though.
