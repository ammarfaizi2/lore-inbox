Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbULBLRk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbULBLRk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:17:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbULBLRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:17:37 -0500
Received: from gate.crashing.org ([63.228.1.57]:4268 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261581AbULBLRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:17:31 -0500
Subject: Re: page fault scalability patch V12 [0/7]: Overview
	and	performance tests
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       list linux-ide <linux-ide@vger.kernel.org>
In-Reply-To: <41AEC021.8040000@pobox.com>
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain>
	 <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221419440.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0411221424580.22895@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0411221429050.20993@ppc970.osdl.org>
	 <Pine.LNX.4.58.0412011539170.5721@schroedinger.engr.sgi.com>
	 <Pine.LNX.4.58.0412011608500.22796@ppc970.osdl.org>
	 <41AEB44D.2040805@pobox.com> <20041201223441.3820fbc0.akpm@osdl.org>
	 <41AEBD95.7030804@pobox.com> <1101971149.5593.64.camel@gaston>
	 <41AEC021.8040000@pobox.com>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 22:16:24 +1100
Message-Id: <1101986184.14597.75.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 02:11 -0500, Jeff Garzik wrote:
> Benjamin Herrenschmidt wrote:
> > They may not end up in order if they are stores (the stores to the
> > taskfile may be out of order vs; the loads/stores to/from the data
> > register) unless you have a spinlock protecting both or a full sync (on
> > ppc), but then, I don't know the ordering things on x86_64. This could
> > certainly be a problem on ppc & ppc64 too.
> 
> 
> Is synchronization beyond in[bwl] needed, do you think?

Yes, when potentially hop'ing between CPUs, definitely.

> This specific problem is only on Intel ICHx AFAICS, which is PIO not 
> MMIO and x86-only.  I presumed insw() by its very nature already has 
> synchronization, but perhaps not...

Hrm... on "pure" x86, I would expect so at the HW level, not sure about
x86_64... but there would be definitely an issue on ppc with your
scheme. You need at least a full barrier before you trigger the
workqueue. That may not be the problem you are facing now, but it would
become one.

Ben.


