Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269134AbTCDEIo>; Mon, 3 Mar 2003 23:08:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269141AbTCDEIo>; Mon, 3 Mar 2003 23:08:44 -0500
Received: from static-ctb-203-29-86-202.webone.com.au ([203.29.86.202]:46351
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id <S269134AbTCDEIn>; Mon, 3 Mar 2003 23:08:43 -0500
Message-ID: <3E642932.7070205@cyberone.com.au>
Date: Tue, 04 Mar 2003 15:18:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Subject: Re: [BENCHMARK] 2.5.63-mm2 + i/o schedulers with contest
References: <200303041354.03428.kernel@kolivas.org>
In-Reply-To: <200303041354.03428.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:

>Here are contest (http://contest.kolivas.org) benchmarks using the osdl 
>hardware (http://www.osdl.org) for 2.5.63-mm2 and various i/o schedulers:
>
Thanks :)

>It seems the AS scheduler reliably takes slightly longer to compile the kernel 
>in no load conditions, but only about 1% cpu.
>
It is likely that AS will wait too long for gcc to submit another
read and end up timing out anyway. Hopefully IO history tracking
will fix this up - for some loads the effect can be much worse.

>
>
>CFQ and DL faster to compile the kernel than AS while extracting or creating 
>tars.
>
This is likely to be balancing differences from LCPU% it does
seem like AS is doing a bit more "load" work.

>
>
>AS significantly faster under writing large file to the same disk (io_load) or 
>other disk (io_other) conditions. The CFQ and DL schedulers showed much more 
>variability on io_load during testing but did not drop below 140 seconds.
>
small randomish reads vs large writes _is_ where AS really can
perform better than non a non AS scheduler. Unfortunately gcc
doesn't have the _best_ IO pattern for AS ;)

>
>
>CFQ and DL scheduler were faster compiling the kernel under read_load,  
>list_load and dbench_load.
>
>Mem_load result of AS being slower was just plain weird with the result rising 
>from 100 to 150 during testing.
>
I would like to see if AS helps much with a swap/memory
thrashing load.

