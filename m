Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263186AbTE0BVg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 21:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTE0BVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 21:21:35 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26578
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262610AbTE0BUc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 21:20:32 -0400
Date: Tue, 27 May 2003 03:33:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
Message-ID: <20030527013346.GK3767@dualathlon.random>
References: <20030526162616.6ceacaba.akpm@digeo.com> <20030526233446.GZ3767@dualathlon.random> <20030527011750.GG3767@dualathlon.random> <20030526.182026.27807754.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030526.182026.27807754.davem@redhat.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 26, 2003 at 06:20:26PM -0700, David S. Miller wrote:
>    From: Andrea Arcangeli <andrea@suse.de>
>    Date: Tue, 27 May 2003 03:17:50 +0200
>    
>    I'm going to try this (if it compiles ;). the ksoftirqd check is
>    the one for the NAPI workload brought to attention by Dave.
> 
> Ksoftirqd should not be running on a properly functioning system.
> 
> In fact, I know lots of people who are simply making ksoftirqd
> only run if we do the softirq loop N times where N is very large
> in order to avoid the performance problems that result from ksoftirqd.

note that what those lots of people are doing is very legitimate. I'll
also change this in my current tree right now, so we'll see if these
lots of people will be fine with my next tree. would be interesting
which N those lots of people are using though.

I very well recall that we waited people to ask if the N == 1 was too
low when we introduced ksoftirqd, Linus just said he would increase it
if it was generating spurious reschedules during load peaks.

Note however that the larger N the more it will tend to hang the box
(i.e. less fair) with NAPI. I certainly don't doubt network performance
can increase slightly.

Andrea
