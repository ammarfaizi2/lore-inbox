Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbTLOXat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 18:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbTLOXat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 18:30:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:64403 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264536AbTLOXas (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 18:30:48 -0500
Date: Mon, 15 Dec 2003 15:31:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@holomorphy.com, kernel@kolivas.org, chris@cvine.freeserve.co.uk,
       riel@redhat.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-Id: <20031215153122.1d915475.akpm@osdl.org>
In-Reply-To: <20031210224445.GE11193@dualathlon.random>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com>
	<200311031148.40242.kernel@kolivas.org>
	<200311032113.14462.chris@cvine.freeserve.co.uk>
	<200311041355.08731.kernel@kolivas.org>
	<20031208135225.GT19856@holomorphy.com>
	<20031208194930.GA8667@k3.hellgate.ch>
	<20031208204817.GA19856@holomorphy.com>
	<20031210215235.GC11193@dualathlon.random>
	<20031210220525.GA28912@k3.hellgate.ch>
	<20031210224445.GE11193@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > Uhm.. guys? I forgot to mention that earlier: qsbench as I used it was not
> > about one single process. There were four worker processes (-p 4), and my
> > load control stuff did make it run faster, so the point is moot.
> 
> more processes can be optimized even better by adding unfariness.
> Either ways a significant slowdown of qsbench probably means worse core
> VM, at least if compared with 2.4 that isn't adding huge unfariness just
> to optimize qsbench.

Single-threaded qsbench is OK on 2.6.  Last time I looked it was a little
quicker than 2.4.  It's when you go to multiple qsbench instances that
everything goes to crap.

It's interesting to watch the `top' output during the run.  In 2.4 you see
three qsbench instances have consumed 0.1 seconds CPU and the fourth has
consumed 45 seconds and then exits.

In 2.6 all four processes consume CPU at the same rate.  Really, really
slowly.

