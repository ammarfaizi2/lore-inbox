Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTIIWHp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 18:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264609AbTIIWHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 18:07:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:30630 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264606AbTIIWHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 18:07:34 -0400
Message-ID: <3F5E4EF5.1030005@austin.ibm.com>
Date: Tue, 09 Sep 2003 17:06:45 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <3F5D023A.5090405@austin.ibm.com> <20030908155639.2cdc8b56.akpm@osdl.org>
In-Reply-To: <20030908155639.2cdc8b56.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Steven Pratt <slpratt@austin.ibm.com> wrote:
>  
>
>>For specjbb things are looking good from a throughput point of view. 
>>...
>>Volanomark, on the other hand is still off by quite a bit from test4 stock
>>
>>    
>>
>hmm, thanks.
>
>I'm not sure that volanomark is very representative of any real-world
>thing.
>
>  
>
>>...
>>If thre is any particular patch/tree combination you would like me to 
>>try out, please let me know and I will see if I can get the results for 
>>you. 
>>    
>>
>
>Could we please see test5 versus test5 plus Andrew's patch?
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-CAN_MIGRATE_TASK-fix.patch
>
This patch improves specjjb over test5 and has no real effect on any of 
kernbench, volanomark or specsdet.

Specjbb Throughput
           2.6.0-test5 2.6.0-test5BALANCE
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42     10062.66    -0.55       -55.76       303.55
         4     35316.38     34676.03    -1.81      -640.35      1059.49
         7     54126.17     52717.84    -2.60     -1408.33      1623.79
        10     56906.64     56587.53    -0.56      -319.11      1707.20
        13     51589.86     54625.25     5.88      3035.39      1547.70  *
        16     41410.52     43120.66     4.13      1710.14      1242.32  *
        19     32944.48     35820.89     8.73      2876.41       988.33  *

Volanomark
           2.6.0-test5 2.6.0-test5BALANCE
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        41391     1.16       476.00      1227.45


>
>and if you have time, also test5 plus sched-CAN_MIGRATE_TASK-fix.patch plus
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-balance-fix-2.6.0-test3-mm3-A0.patch
>  
>
This patch degrades both specjbb and volanomark, and to a lesser degree 
specsdet

Specjbb throughput
            2.6.0-test5 2.6.0-test5MIGRATE
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42      9980.90    -1.36      -137.52       303.55
         4     35316.38     34065.11    -3.54     -1251.27      1059.49  *
         7     54126.17     52697.10    -2.64     -1429.07      1623.79
        10     56906.64     55466.77    -2.53     -1439.87      1707.20
        13     51589.86     43152.57   -16.35     -8437.29      1547.70  *
        16     41410.52     45201.21     9.15      3790.69      1242.32  *
        19     32944.48     29025.16   -11.90     -3919.32       988.33  *


Volanomark
           2.6.0-test5   2.6.0-test5MIGRATE
           Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        38518    -5.86     -2397.00      1227.45  *


>
>What I'm afraid of is that those patches will yield improved results over
>test5, and that adding
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test4/2.6.0-test4-mm6/broken-out/sched-2.6.0-test2-mm2-A3.patch
>
I tried adding this patch to stock test5 and it failed to apply 
cleanly.  I have not had a chance to look at why.  Did you mean for this 
to be applied by itself, or was this supposed to go on top of one of the 
other patches?

>
>will slow things down again.
>

Steve

