Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVBHU2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVBHU2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 15:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVBHU2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 15:28:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:24980 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261653AbVBHU2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 15:28:09 -0500
Date: Tue, 8 Feb 2005 12:27:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: prezeroing V6 [2/3]: ScrubD
Message-Id: <20050208122758.5c669281.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502080807410.3169@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0501211228430.26068@schroedinger.engr.sgi.com>
	<1106828124.19262.45.camel@hades.cambridge.redhat.com>
	<20050202153256.GA19615@logos.cnet>
	<Pine.LNX.4.58.0502071127470.27951@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0502071131260.27951@schroedinger.engr.sgi.com>
	<20050207163035.7596e4dd.akpm@osdl.org>
	<Pine.LNX.4.58.0502071646170.29971@schroedinger.engr.sgi.com>
	<20050207170947.239f8696.akpm@osdl.org>
	<Pine.LNX.4.58.0502071710580.30068@schroedinger.engr.sgi.com>
	<20050207173559.68ce30e3.akpm@osdl.org>
	<Pine.LNX.4.58.0502080807410.3169@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> wrote:
>
> On Mon, 7 Feb 2005, Andrew Morton wrote:
> 
> > > No its a page fault benchmark. Dave Miller has done some kernel compiles
> > > and I have some benchmarks here that I never posted because they do not
> > > show any material change as far as I can see. I will be posting that soon
> > > when this is complete (also need to do the same for the atomic page fault
> > > ops and the prefaulting patch).
> >
> > OK, thanks.  That's important work.  After all, this patch is a performance
> > optimisation.
> 
> Well its a bit complicated due to the various configuration. UP, and then
> more and more processors. Plus the NUMA stuff and the standard benchmarks
> that are basically not suited for SMP tests make this a bit difficult.

The patch is supposed to speed the kernel up with at least some workloads. 
We 100% need to see testing results with some such workloads to verify that
the patch is desirable.

We also need to try to identify workloads whcih might experience a
regression and test them too.  It isn't very hard.

> > > memory node is bound to a set of cpus. This may be controlled by the
> > > NUMA node configuration. F.e. for nodes without cpus.
> >
> > kthread_bind() should be able to do this.  From a quick read it appears to
> > have shortcomings in this department (it expects to be bound to a single
> > CPU).
> 
> Sorry but I still do not get what the problem is? kscrubd does exactly
> what kswapd does and can be handled in the same way. It works fine here
> on various multi node configurations and correctly gets CPUs assigned.

We now have a standard API for starting, binding and stopping kernel
threads.  It's best to use it.
