Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbTIGGof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 02:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbTIGGof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 02:44:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:39094 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262997AbTIGGoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 02:44:34 -0400
Date: Sat, 6 Sep 2003 23:45:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: rml@tech9.net, jyau_kernel_dev@hotmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Message-Id: <20030906234545.46c990d6.akpm@osdl.org>
In-Reply-To: <3F5AD03E.5070506@cyberone.com.au>
References: <000101c374a3$2d2f9450$f40a0a0a@Aria>
	<1062878664.3754.12.camel@boobies.awol.org>
	<3F5ABD3A.7060709@cyberone.com.au>
	<20030906231856.6282cd44.akpm@osdl.org>
	<3F5AD03E.5070506@cyberone.com.au>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <piggin@cyberone.com.au> wrote:
>
> >My concern is the (large) performance regression with specjbb and
>  >volanomark, due to increased idle time.
>  >
>  >We cannot just jam all this code into Linus's tree while crossing our
>  >fingers and hoping that something will turn up to fix this problem. 
>  >Because we don't know what causes it, nor whether we even _can_ fix it.
>  >
>  >So this is the problem which everyone who is working on the CPU scheduler
>  >should be concentrating on, please.
>  >
> 
>  IIRC my (equivalent to Andrew's CAN_MIGRATE) patch fixed this. There was 
>  still a small (~8%?) performance regression, but idle times were on par 
>  with -linus. I don't have easy access to a largeish NUMA box, so I
>  can't do much more.
> 

That is not clear at this time.  We do know that the reaim regression was
introduced by sched-2.6.0-test2-mm2-A3, but we don't know why.  Certainly
that patch did not introduce the problem which Andrew's patch fixed.  And
we have theorised that Andrew's patch brought back the reaim throughput. 
And we have extrapolated those observations to possible improvements in
volanomark throughput.

It's all foggy and I'd like to see a clean rerun of specjbb and volanomark
by Mark Peloquin and co, confirming that -mm6 is performing OK.


Also, I'm concerned that sched-2.6.0-test2-mm2-A3 caused slowdowns and
Andrew's patch caused speedups and they just cancelled out.  Let's get
Andrew's patch into Linus's tree and see if it speeds things up.  If it
does, we probably still have a problem.

