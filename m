Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTE0LkC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 07:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTE0LkB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 07:40:01 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:65502
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263298AbTE0LkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 07:40:00 -0400
Date: Tue, 27 May 2003 13:53:14 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527115314.GU3767@dualathlon.random>
References: <20030527010903.GF3767@dualathlon.random> <20030526.181309.02272953.davem@redhat.com> <20030527012617.GH3767@dualathlon.random> <20030526.231120.26504389.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526.231120.26504389.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 11:11:20PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Tue, 27 May 2003 03:26:17 +0200
>    
>    I argue with that, NAPI needs to poll somehow, either you hook into the
>    kernel slowing down every single schedule, or you need to offload this
>    work to a kernel thread.
> 
> You've never shown what this "offloading work to a kernel thread"
> actually accomplishes.

in case it wasn't obvious (that is the whole point of ksoftirqd) what
accomplishes in a single word is "fairness" and "not starving userspace
during networking".

> What I've seen it do is decrease the amount of total softirq work that
> cpu can get done.  And avoiding ksoftirqd actually running makes
> performance get better.

sure, as far as you don't care about anything but the network load. I
mean, if you can't care less of the userspae progress and you don't want
the usual scheduler fariness guarantees, then you can hack the kernel
and replace the ksoftirqd with an infinite loop and networking will
certainly perform better since it will be able to stall indefinitely all
userspace computations in favour of pure irq driven networking I/O
running all in irq context and never ending.

I really thought this was obvious to everybody, otherwise there would be
no point for ksoftirqd at all if you can't care less to hang userspace
indefinitely.

Andrea
