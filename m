Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbTIKW6f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 18:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTIKW6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 18:58:35 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:4293 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261581AbTIKW6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 18:58:32 -0400
Message-ID: <3F60FDD9.4080704@austin.ibm.com>
Date: Thu, 11 Sep 2003 17:57:29 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
References: <200309092353.h89NrTN31627@mail.osdl.org> <3F5E8897.7040302@cyberone.com.au> <3F5F7604.9040305@austin.ibm.com> <3F5FE385.10204@cyberone.com.au> <3F607E62.3010903@austin.ibm.com> <3F60873B.4000005@cyberone.com.au>
In-Reply-To: <3F60873B.4000005@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>
> Steven Pratt wrote:
>
>> Nick Piggin wrote:
>>
>>> Steven Pratt wrote:
>>>
>>>>
>>>> I gave this a try on the same setup that I am using for the 
>>>> regression tests and the scheduler tests for Andrew.  What I got 
>>>> was the following oops:
>>>
>>>
>>> Hi Steven,
>>> This is with the complete sched-rollup-v14.gz or sched-rollup-nopolicy?
>>
>>
>> This is with the complete sched-rollup-v14.gz.
>>
>
> OK, I've fixed a bug that might be causing that...
> Any chance you could grab my new version from:
> http://www.kerneltrap.org/~npiggin/v15/
> And give it another go. If you get an oops, could you make sure you've
> compiled with debugging info (-g), and use add2line on vmlinux using the
> crashing EIP, please?

Well, it oopsed the first time so I rebuilt with debugging on and it 
didn't die.  Not sure what debuggin info will do to the results, but 
since some of them went up I thought I'd let you see them anyway.  I 
might be out tomorrow so I might not be able to follow up until Monday.

SPECSDET
           2.6.0-test5 2.6.0-test5piggin
   Threads      Ops/sec      Ops/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1         3232         3248     0.50        16.00        96.96
         4        11794        11606    -1.59      -188.00       353.82
        16        19008        18723    -1.50      -285.00       570.24
        64        18736        17679    -5.64     -1057.00       562.08  *
 

SPECJBB
            2.6.0-test5 2.6.0-test5piggin
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1     10118.42     10100.65    -0.18       -17.77       303.55
         4     35316.38     35037.34    -0.79      -279.04      1059.49
         7     54126.17     54290.86     0.30       164.69      1623.79
        10     56906.64     56703.59    -0.36      -203.05      1707.20
        13     51589.86     55509.08     7.60      3919.22      1547.70  *
        16     41410.52     51366.41    24.04      9955.89      1242.32  *
        19     32944.48     33693.62     2.27       749.14       988.33

VOLANOMARK
            2.6.0-test5 2.6.0-test5piggin
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40915        42606     4.13      1691.00      1227.45  *



Steve

