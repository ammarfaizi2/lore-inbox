Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262751AbSI1JDK>; Sat, 28 Sep 2002 05:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262753AbSI1JDK>; Sat, 28 Sep 2002 05:03:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:22182 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262751AbSI1JDJ>;
	Sat, 28 Sep 2002 05:03:09 -0400
Date: Sat, 28 Sep 2002 11:08:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <conman@kolivas.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
Message-ID: <20020928090806.GI23468@suse.de>
References: <1033196310.3d955316425bd@kolivas.net> <3D95670C.3239A357@digeo.com> <1033201873.3d9568d158a72@kolivas.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1033201873.3d9568d158a72@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28 2002, Con Kolivas wrote:
> > > io_load:
> > > Kernel                  Time            CPU             Ratio
> > > 2.4.19                  216.05          33%             3.19
> > > 2.5.38                  887.76          8%              13.11*
> > > 2.5.38-mm3              105.17          70%             1.55*
> > > 2.5.39                  216.81          37%             3.20
> > 
> > -mm3 has fifo_batch=16.  2.5.39 has fifo_batch=32.

That's not the only difference, btw.

> > > mem_load:
> > > Kernel                  Time            CPU             Ratio
> > > 2.4.19                  105.40          70%             1.56
> > > 2.5.38                  107.89          73%             1.59
> > > 2.5.38-mm3              117.09          63%             1.73*
> > > 2.5.39                  103.72          72%             1.53
> > 
> > 2.5's swapout is still fairly synchronously sucky.  So low-latency
> > writeout could be advantageous there.  This difference is probably
> > also the fifo_batch thing.  Or maybe statistical?
> > 
> > 
> > I did some testing with your latest.  4xPIII, mem=512m, SCSI,
> > tag depth = 0, 2.5.39-mm1 candidate:
> > 
> > fifo_batch=32:
> > 
> > 	noload          2:34.53         291%
> > 	cpuload         2:36.20         286%
> > 	memload         2:19.44         333%
> > 	ioloadhalf      2:34.81         303%
> > 	ioloadfull      3:15.47         238%
> > 
> > (err.  memload sped it up!)
> > 
> > fifo_batch=16:
> > 
> > 	noload          2:00.03         380%
> > 	cpuload         2:27.62         304%
> > 	memload         2:22.59         326%
> > 	ioloadhalf      2:33.75         306%
> > 	ioloadfull      2:59.18         259%
> > 
> > - Something went horridly wrong in the first `noload' test.
> > - fifo_batch=16 is better than 32.
> > - you see a 4x hit from io_load.  I see a 1.5x hit.

So far fifo_batch=16 looks pretty good. Doesn't quite make sense to me.
Need to bench/test some more :-)

-- 
Jens Axboe

