Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbTKNCSI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 21:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbTKNCSI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 21:18:08 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:38849 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264499AbTKNCSD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 21:18:03 -0500
Message-ID: <3FB43A13.80705@cyberone.com.au>
Date: Fri, 14 Nov 2003 13:12:35 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Nick's scheduler v18
References: <3FAFC8C6.8010709@cyberone.com.au> <38770000.1068759009@flay>
In-Reply-To: <38770000.1068759009@flay>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Martin J. Bligh wrote:

>>Average of 5 kernel compiles (make -j) on a 16-way 512KB cache NUMAQ gives
>>         bk14  bk14-v18
>>real    83.5s     81.7s
>>user   987.6s    992.5s
>>sys    158.0s    142.3s
>>
>>Volanomark looks much better than mainline.
>>
>>More testing welcome.
>>
>
>-noint is just backing out the interactivity patch (part of your patch)
>Not sure that's helping you much really, but maybe it conflicts with
>your other stuff.
>
>Kernbench: (make -j N vmlinux, where N = 2 x num_cpus)
>                              Elapsed      System        User         CPU
>              2.6.0-test9       45.28      100.19      568.01     1474.75
>        2.6.0-test9-noint       48.20       99.05      567.26     1389.00
>       2.6.0-test9-nick18       45.06       91.56      568.77     1467.50
>
>Kernbench: (make -j N vmlinux, where N = 16 x num_cpus)
>                              Elapsed      System        User         CPU
>              2.6.0-test9       46.17      122.20      571.58     1501.00
>        2.6.0-test9-noint       46.43      117.96      577.60     1498.00
>       2.6.0-test9-nick18       46.90      109.05      589.77     1488.75
>
>Kernbench: (make -j vmlinux, maximal tasks)
>                              Elapsed      System        User         CPU
>              2.6.0-test9       45.84      120.14      570.93     1507.00
>        2.6.0-test9-noint       47.42      123.52      582.91     1488.75
>       2.6.0-test9-nick18       46.83      110.70      588.91     1494.00
>
>It seems that you're decreasing system time significantly, but increasing
>user time if you have lots of tasks ... context switch thrash, maybe?
>

OK, thanks for testing. Still not great.

My patchset does a _lot_ less SMP and NUMA balancing, although I think
that sometimes causes too much idle time. It might be doing more context
switching though.

>
>Would be interesting if you know which of the many patches in there make
>the performance difference ... the whole thing is a bit too big to pick
>up and maintain easily ;-)
>

Its not well broken out though unfortunately. I really need to document and
comment it better.

