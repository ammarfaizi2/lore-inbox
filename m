Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133010AbRADNs4>; Thu, 4 Jan 2001 08:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133053AbRADNsq>; Thu, 4 Jan 2001 08:48:46 -0500
Received: from linuxcare.com.au ([203.29.91.49]:6149 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S133010AbRADNsa>; Thu, 4 Jan 2001 08:48:30 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Fri, 5 Jan 2001 00:46:45 +1100
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking 2.2 and 2.4 using hdparm and dbench 1.1
Message-ID: <20010105004644.K13759@linuxcare.com>
In-Reply-To: <Pine.LNX.4.21.0101031755090.4448-200000@svea.tellus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0101031755090.4448-200000@svea.tellus>; from tori@tellus.mine.nu on Wed, Jan 03, 2001 at 06:43:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1) Why does the hdbench numbers go down for 2.4 (only) when 32 MB is used?
>    I fail to see how that matters, especially for the '-T' test.

When I did some tests long ago, hdparm was hitting the buffer cache hash
table pretty hard in 2.4 compared to 2.2 because it is now smaller. However
as davem pointed out, most things don't do such things so resizing the hash
table just for this is a waste.

Since the hash is based on RAM, it may end up being big enough on the 128M
machine.

> 3) The 2.2 kernels outperform the 2.4 kernels for few clients (see
>    especially the "dbench 1" numbers for the PII-128M.  Oops!

dbench was sleeping up to 1 second between starting the clock and starting
the benchmark. This made small benchmarks (ie especially dbench 1) somewhat
variable. Grab the latest version from pserver.samba.org (if you havent
already).

> The reason for doing the benchmarks in the first place is that my 32MB P90
> at home really does perform noticeably worse with samba using 2.4 kernels
> than using 2.2 kernels, and that bugs me.  I have no hard numbers for that
> machine (yet).  If they will show anything extra, I will post them here.  

What exactly are you seeing?

> Btw, has anyone else noticed samba slowdowns when going from 2.2 to 2.4?

I am seeing good results with 2.4 + samba 2.2 using tdb spinlocks.

Anton
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
