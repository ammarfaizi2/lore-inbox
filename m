Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbTE0I5w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 04:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTE0I5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 04:57:52 -0400
Received: from ns.suse.de ([213.95.15.193]:30226 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262878AbTE0I5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 04:57:51 -0400
Date: Tue, 27 May 2003 11:11:04 +0200
From: Andi Kleen <ak@suse.de>
To: Erich Focht <efocht@hpce.nec.com>
Cc: LSE <lse-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Node affine NUMA scheduler extension
Message-ID: <20030527091104.GB31510@wotan.suse.de>
References: <200305271031.55554.efocht@hpce.nec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305271031.55554.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 10:31:55AM +0200, Erich Focht wrote:
> This patch is an adaptation of the earlier work on the node affine
> NUMA scheduler to the NUMA features meanwhile integrated into
> 2.5. Compared to the patch posted for 2.5.39 this one is much simpler
> and easier to understand.

Yes, it is also much simpler than my implementation (I did a similar homenode
scheduler for an 2.4 kernel). The basic principles are the same.

But the main problems I have is that the tuning for threads is very 
difficult. On AMD64 where Node equals CPU it is important
to home node balance threads too. After some experiments I settled on 
homenode assignment on the first load balance (called "lazy homenode")  
When a thread clones it initially executes on the CPU of the parent, but 
there is a window until the first load balance tick where it can allocate
memory on the wrong node.  I found a lot of code runs very badly until the 
cache decay parameter is set to 0 (no special cache affinity) to allow
quick initial migration. Migration directly on fork/clone requires a lot 
of changes and also breaks down on some benchmarks.

-Andi

