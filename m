Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281912AbRLKRCu>; Tue, 11 Dec 2001 12:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281918AbRLKRC3>; Tue, 11 Dec 2001 12:02:29 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:60392 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S281912AbRLKRC1>;
	Tue, 11 Dec 2001 12:02:27 -0500
Date: Tue, 11 Dec 2001 09:02:01 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] hackbench: New Multiqueue Scheduler Benchmark
Message-ID: <20011211090201.A1137@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <E16Dh0t-0003yl-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Dh0t-0003yl-00@wagner.rustcorp.com.au>; from rusty@rustcorp.com.au on Tue, Dec 11, 2001 at 06:07:39PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 06:07:39PM +1100, Rusty Russell wrote:
> 	I've cut down the chat benchmark into a version which doesn't
> use threads or semaphores, and called it hackbench:
> 
> On a 12-way PPC64:
> 2.4.17-pre7:
> 	hackbench 50: Time: 851.469 Time: 847.143 Time: 826.868
> 
> 2.4.17-pre7-multiqueue-patch:
> 	hackbench 50: Time: 15.120 Time: 14.766 Time: 15.067

I suspect the reason for the big difference is runqueue lock contention
(as in the original chat benchmark).

It might be interesting to keep the benchmark load the same and
rerun with a varying number of CPUs.  My 'guess' is that with the
default scheduler you will see better numbers with less CPUs.  When
we were working with chat on an 8-way Intel, we saw benchmark
numbers peak at around 4 CPUs.  As you added more than 4 CPUs,
your benchmark numbers got worse.  You can see this graphicly at:
http://lse.sourceforge.net/scheduling/ols2001/img54.htm

-- 
Mike
