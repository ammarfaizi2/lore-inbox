Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265734AbTFSIPg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265735AbTFSIPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:15:36 -0400
Received: from [203.221.157.221] ([203.221.157.221]:14084 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S265734AbTFSIPe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:15:34 -0400
Message-ID: <3EF17433.20209@cyberone.com.au>
Date: Thu, 19 Jun 2003 18:28:35 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: i/o benchmarks on 2.5.70* kernels
References: <20030618225017.GA15635@rushmore>
In-Reply-To: <20030618225017.GA15635@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



rwhron@earthlink.net wrote:

>>tiobench on SMP results are not very good, lots of
>>fragmentation
>>
>
>On uniprocessor with IDE disk, benchmarks look very
>different than SMP/SCSI. Recent -mm on uniprocessor 
>is frequently ahead of 2.5.70/2.5.71.
>

Thanks.
AS should be OK with SMP, but it would be nice to see
how it goes with a large number of spindles and processors.

AS should also be able to run SCSI alright, it tends to
perform quite poorly with TCQ and multiple random readers
though unfortunately. I'm setting up a box here with an
IDE and SCSI disk which I'll run my regression tests on,
(previously only IDE) so I might be able to help this along
a bit.

Fairness and interactiveness with AS and big TCQ should
be quite a bit better than deadline though, so it would
be a good workstation option even if it can't keep database
throughput up.

It looks like database loads without TCQ are often better
with AS than deadline, your AIM7 is, WimMark is. They can
be worse though. pgbench for example.

>
>Sequential Reads ext2
>                  Num                    Avg       Maximum     Lat%     Lat%    CPU
>Kernel            Thr   Rate  (CPU%)   Latency     Latency      >2s     >10s    Eff
>----------------- ---  ------------------------------------------------------------
>2.4.21-rc8aa1       1   19.00 71.72%     0.597      215.09  0.00000  0.00000     26
>2.5.70-mm6          1   14.26 21.45%     0.812      247.12  0.00000  0.00000     66
>2.5.71              1   14.13 18.03%     0.822      225.37  0.00000  0.00000     78
>2.5.70-mm7          1   14.08 22.96%     0.821      315.76  0.00000  0.00000     61
>2.5.70-mm5          1   14.00 23.80%     0.826      329.88  0.00000  0.00000     59
>2.5.70-mm3          1   13.95 23.75%     0.830      188.64  0.00000  0.00000     59
>2.5.70-mm1          1   13.80 23.84%     0.840      301.10  0.00000  0.00000     58
>2.5.69-ac1          1   13.66 20.44%     0.850      298.83  0.00000  0.00000     67
>2.5.70              1   13.60 20.57%     0.853      174.52  0.00000  0.00000     66
>
Don't ask me what the deal is here ;)
AS would have no impact on a single threaded IO load. aa is
using a lot of CPU for some reason. Driver difference
maybe? readahead? Andrea's secret sauce?

aa also gets much worse latency spikes at higher thread
counts (if tiobench is to be believed!). As thread count
rises readahead can't fit into the request queue, and you
see AS working.

On the write side, current mms should be improved due to
some changes in request allocation.


