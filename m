Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130177AbQKUMG3>; Tue, 21 Nov 2000 07:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130363AbQKUMGT>; Tue, 21 Nov 2000 07:06:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35847 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S130177AbQKUMGK>;
	Tue, 21 Nov 2000 07:06:10 -0500
Date: Tue, 21 Nov 2000 12:36:08 +0100
From: Jens Axboe <axboe@suse.de>
To: kumon@flab.fujitsu.co.jp
Cc: linux-kernel@vger.kernel.org, Dave Jones <davej@suse.de>,
        Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
Message-ID: <20001121123608.F10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp> <20001121112836.B10007@suse.de> <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp>; from kumon@flab.fujitsu.co.jp on Tue, Nov 21, 2000 at 08:30:33PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21 2000, kumon@flab.fujitsu.co.jp wrote:
>  > Believe it or not, but this is intentional. In that regard, the
>  > function name is a misnomer -- call it i/o scheduler instead :-)
> 
> I never believe it intentional.  If it is true, the current kernel
> will be suffered from a kind of DOS attack.  Yes, actually I'm a
> victim of it.

The problem is caused by the too high sequence numbers in stock
kernel, as I said. Plus, the sequence decrementing doesn't take
request/buffer size into account. So the starvation _is_ limited,
the limit is just too high.

> By Running ZD's ServerBench, not only the performance down, but my
> machine blocks all commands execution including /bin/ps, /bin/ls... ,
> and those are not ^C able unless the benchmark is stopped. Those
> commands are read from disks but the requests are wating at the end of
> I/O queue, those won't be executed.

If performance is down, then that problem is most likely elsewhere.
I/O limited benchmarking typically thrives on lots of request
latency -- with that comes better throughput for individual threads.

> Anyway, I'll try your patch.

Thanks

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
