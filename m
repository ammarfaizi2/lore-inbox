Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264593AbTDZCIt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 22:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264594AbTDZCIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 22:08:49 -0400
Received: from static-ctb-210-9-247-179.webone.com.au ([210.9.247.179]:18184
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S264593AbTDZCIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 22:08:47 -0400
Message-ID: <3EA9ECFB.5050407@cyberone.com.au>
Date: Sat, 26 Apr 2003 12:20:43 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: rwhron@earthlink.net
CC: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.68 and 2.5.68-mm2
References: <20030426015856.GA2286@rushmore>
In-Reply-To: <20030426015856.GA2286@rushmore>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



rwhron@earthlink.net wrote:

>>>On the AIM7 database test, -mm2 was about 18% faster and
>>>
>
>>iirc, AIM7 is dominated by lots of O_SYNC writes.  I'd have expected the
>>anticipatory scheduler to do worse.  Odd.  Which fs was it?
>>
>
>That was ext2 too.
>
Well thats nice for a change. The set of workloads which do worse
on AS are obviously more specific than sync writes. I think
multiple threads reading and writing to a similar area of the
disk. Not sure though.

>
>
>>tiobench will create a bunch of processes, each growing a large file, all
>>in the same directory.  
>>
>
>>The benchmark is hitting a pathologoical case.  Yeah, it's a problem, but
>>it's not as bad as tiobench indicates.
>>
Its interesting that deadline does so much better for this case
though. I wonder if any other differences in mm could cause it?
A run with deadline on mm would be nice to see. IIRC my tests
showed AS doing as well or better than deadline in smp tiobench.
The bad random read performance is a problem too, because the
fragmentation should only add to the randomness.
I'll have to investigate this further.

>
>Oracle doing reads/writes to preallocated, contiguous files is more 
>important than tiobench.  Oracle datafiles are typically created
>sequentially, which wouldn't exercise the pathology.
>
>I pay more attention the OSDL-DBT-3 and "Winmark I" numbers than 
>the i/o stuff I run.  (I look at my numbers more, but care about
>theirs more).
>
>What about the behavior where CPU utilization goes down as thread
>count goes up?  Is she just i/o bound?
>
>Sequential Reads ext2
>	       Num                 
>Kernel         Thr   Rate   (CPU%)  
>----------     ---   -----  ------
>2.5.68           8   36.65  18.04%  
>2.5.68-mm2       8   23.96  11.15%  
>
>2.5.68         256   34.10  16.88%  
>2.5.68-mm2     256   18.84   8.96%  
>
Well its doing less IO. Look at CPU efficiency which appears to
be rate / cpu. It is steady - an amount of IO will cost an
amount of CPU.

