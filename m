Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSI3TbY>; Mon, 30 Sep 2002 15:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSI3TbY>; Mon, 30 Sep 2002 15:31:24 -0400
Received: from packet.digeo.com ([12.110.80.53]:21440 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261264AbSI3TbX>;
	Mon, 30 Sep 2002 15:31:23 -0400
Message-ID: <3D98A7D0.8F07193F@digeo.com>
Date: Mon, 30 Sep 2002 12:36:48 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39-mm1
References: <200209301941.41627.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Sep 2002 19:36:28.0821 (UTC) FILETIME=[ABF7CC50:01C268B8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Here follow the contest v0.41 (http://contest.kolivas.net) results for
> 2.5.39-mm1:
> 
> noload:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  67.71           98%             1.00
> 2.5.38                  72.38           94%             1.07
> 2.5.38-mm3              73.00           93%             1.08
> 2.5.39                  73.17           93%             1.08
> 2.5.39-mm1              72.97           94%             1.08

2.4.19 achieves higher CPU occupancy - you're using `make -j4', so it
could be a CPU scheduler artifact, or a disk readahead latency effect.

Is the kernel source in-cache for these runs?

> process_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  110.75          57%             1.64
> 2.5.38                  85.71           79%             1.27
> 2.5.38-mm3              96.32           72%             1.42
> 2.5.39                  88.9            75%             1.33*
> 2.5.39-mm1              99.0            69%             1.45*

Not sure what to make of this test.  We have a bunch of tasks
sending data between each other across pipes while trying to
build a kernel.

It could be that with 2.4.19, those piping processes got a lot
more work done.

I'd be inclined to drop this test; not sure what it means.
 
> io_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  216.05          33%             3.19
> 2.5.38                  887.76          8%              13.11
> 2.5.38-mm3              105.17          70%             1.55
> 2.5.39                  229.4           34%             3.4
> 2.5.39-mm1              239.5           33%             3.4

I think I'll set fifo_batch to 16 again...
