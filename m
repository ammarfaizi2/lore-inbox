Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTCJXiD>; Mon, 10 Mar 2003 18:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbTCJXiD>; Mon, 10 Mar 2003 18:38:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:10219 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262289AbTCJXiC>;
	Mon, 10 Mar 2003 18:38:02 -0500
Date: Mon, 10 Mar 2003 15:43:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: WimMark I for 2.5.64-mm2
Message-Id: <20030310154351.1dd104cf.akpm@digeo.com>
In-Reply-To: <20030310174746.GO2835@ca-server1.us.oracle.com>
References: <20030310174746.GO2835@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Mar 2003 23:48:37.0592 (UTC) FILETIME=[91ECCD80:01C2E75F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel Becker <Joel.Becker@oracle.com> wrote:
>
> 
> WimMark I report for 2.5.64-mm2 
> 
> Runs with deadline scheduler:  1580.10 1537.95
> Runs with anticipatory scheduler:  632.87 597.33 555.19

The anticipatory scheduler will never be better than deadline with these
sorts of workloads.  The best we can do is to equal it.

With other OLTP-style tests, AS is at worst 5-10% behind deadline.

So what's up with WimMark?  Is it possible that the test is exhibiting some
nonlinearity, wherein a small change in inputs causes a large swing in
output?

One way to tell that would be to perform several runs with different values
of /sys/block/sdXX/io_sched/antic_expire.  And see how the overall runtime
varies as that is altered.

The default it currently 10 (milliseconds).  With zero you should get the
same throughput as deadline.

I'm not sure what to conclude from this result.  Can you shed any light on
what it means, on what's going on?
