Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129691AbQKUMA7>; Tue, 21 Nov 2000 07:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKUMAu>; Tue, 21 Nov 2000 07:00:50 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:58245 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129931AbQKUMAm>; Tue, 21 Nov 2000 07:00:42 -0500
From: kumon@flab.fujitsu.co.jp
Date: Tue, 21 Nov 2000 20:30:33 +0900
Message-Id: <200011211130.UAA27961@asami.proc.flab.fujitsu.co.jp>
To: Jens Axboe <axboe@suse.de>
Cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org,
        Dave Jones <davej@suse.de>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] livelock in elevator scheduling
In-Reply-To: <20001121112836.B10007@suse.de>
In-Reply-To: <200011210838.RAA27382@asami.proc.flab.fujitsu.co.jp>
	<20001121112836.B10007@suse.de>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:
 > > Problem:
 > >  Current elevator_linus() traverses the I/O requesting queue from the
 > > tail to top. And when the current request has smaller sector number
 > > than the request on the top of queue, it is always placed just after
 > > the top.
 > >  This means, if requests in some sector range are continuously
 > > generated, a request with larger sector number is always places at the
 > > last and has no chance to go to the front.  e.g. it is not scheduled.
 > 
 > Believe it or not, but this is intentional. In that regard, the
 > function name is a misnomer -- call it i/o scheduler instead :-)

I never believe it intentional.  If it is true, the current kernel
will be suffered from a kind of DOS attack.  Yes, actually I'm a
victim of it.

By Running ZD's ServerBench, not only the performance down, but my
machine blocks all commands execution including /bin/ps, /bin/ls... ,
and those are not ^C able unless the benchmark is stopped. Those
commands are read from disks but the requests are wating at the end of
I/O queue, those won't be executed.

Anyway, I'll try your patch.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
