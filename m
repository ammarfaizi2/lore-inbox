Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQKUNJr>; Tue, 21 Nov 2000 08:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130380AbQKUNJi>; Tue, 21 Nov 2000 08:09:38 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:25809 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129664AbQKUNJY>; Tue, 21 Nov 2000 08:09:24 -0500
From: kumon@flab.fujitsu.co.jp
Date: Tue, 21 Nov 2000 21:39:07 +0900
Message-Id: <200011211239.VAA28311@asami.proc.flab.fujitsu.co.jp>
To: Jens Axboe <axboe@suse.de>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <20001121123608.F10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>
	<20001121112836.B10007@suse.de>
	<200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp>
	<20001121123608.F10007@suse.de>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > On Tue, Nov 21 2000, kumon@flab.fujitsu.co.jp wrote:
 > > I never believe it intentional.  If it is true, the current kernel
 > > will be suffered from a kind of DOS attack.  Yes, actually I'm a
 > > victim of it.
 > 
 > The problem is caused by the too high sequence numbers in stock
 > kernel, as I said. Plus, the sequence decrementing doesn't take
 > request/buffer size into account. So the starvation _is_ limited,
 > the limit is just too high.

Yes, current limit is 1000000 and if I/O can manage 200req/s, then it
will expire 5000 sec after. So, I said "infinite (more than 1hour)".
Why do you add extreme priotity to lower sector accesses, which breaks
elevator scheduling idea?


 > If performance is down, then that problem is most likely elsewhere.
 > I/O limited benchmarking typically thrives on lots of request
 > latency -- with that comes better throughput for individual threads.

No, the performance down caused from this point.  Server benchmark has
a standard configuration workload which consists from several kind of
task, such as, CPU interntional, disk seq-read, seq-write, random-read,
random-write.

The benchmark invokes lots of processes, each corresponds to a client,
and each accesses different portion of few large files.  We have
enough memory to hold all dirty data at onece (1GB without himem), so
if no I/O blocking occur, all process can be run simultaneously with
limited amount of dirty flush I/O stream.

If some processes eagerly access relatively lower blocks, and other
process unfortunately requests higher block read, then the process is
blocked. Eventually this happens to large portion of processes, the
performance goes extremely down.
 During the measurement of test10 or test11, the performance is very
fluctuated and lots of idle time observed by vmstat. Such instability
is not observed on test1 or test2.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
