Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292801AbSBVFgl>; Fri, 22 Feb 2002 00:36:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292800AbSBVFgb>; Fri, 22 Feb 2002 00:36:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59911 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292802AbSBVFgP>;
	Fri, 22 Feb 2002 00:36:15 -0500
Message-ID: <3C75D88C.DF65F534@zip.com.au>
Date: Thu, 21 Feb 2002 21:35:08 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: jamagallon@able.es, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
In-Reply-To: <20020222042138.GA10466@rushmore>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rwhron@earthlink.net wrote:
> 
> ... 
> Tiobench average of 3 runs
> --------------------------
> ...
> Random Writes
>                   Num                 Avg      Maximum     Lat%    Lat%  CPU
> Kernel            Thr Rate  (CPU%)  Latency    Latency      >2s    >10s  Eff
> ----------------- --- ------------------------------------------------------
> ... 
> 2.4.18-rc2        128  0.67  1.87%    1.334     777.23  0.00000  0.00000  36
> 2.4.18-rc2-jam1   128  0.80  5.72%    0.190       3.68  0.00000  0.00000  14
> 2.4.18rc2aa2      128  0.61  1.39%   61.796   72674.58  0.32761  0.32761  44
> 
> ...

Holy cow!  Are you sure these numbers are right?

The increased throughput will be thanks to the boosted request
queue size.

The (greatly) increased CPU load will also be due to browsing the eight-times
larger request queue.  Plus we browse it a bit more than we used to.

The improvement in worst-case latency in both -aa and -jam will
be due to the FIFO wait for requests.

But improvement by a factor of 20,000 sounds a little excessive :)
And a maximum latency of three milliseconds would seem to indicate
that the benchmark is *never* waiting on disk seek, and that
perhaps the request queue is simply never filling up.  But that
doesn't make sense.

What does the "latency" actually mean?  Is it the time spent
in the kernel to issue a write(2)?

Something funny is happening, I suspect.  Guess I should go
look at tiobench...

-
