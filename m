Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289594AbSAJSvJ>; Thu, 10 Jan 2002 13:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289593AbSAJSvA>; Thu, 10 Jan 2002 13:51:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:61143 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289594AbSAJSuz>; Thu, 10 Jan 2002 13:50:55 -0500
Date: Thu, 10 Jan 2002 10:21:06 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>,
        george anzinger <george@mvista.com>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Message-ID: <20020110102105.B1162@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <Pine.LNX.4.40.0201090940490.1595-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.33.0201092218450.7442-100000@localhost.localdomain> <20020109113833.J1149@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020109113833.J1149@w-mikek2.des.beaverton.ibm.com>; from kravetz@us.ibm.com on Wed, Jan 09, 2002 at 11:38:33AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 11:38:33AM -0800, Mike Kravetz wrote:
> 
> I just kicked off another benchmark run to compare pre10, pre10 & G1
> patch, pre10 & Davide's patch.

It wasn't a good night for benchmarking.  I had a typo in the
script to run chat reniced and as a result didn't collect any
numbers for this.  In addition, the kernel with Davide's patch
failed to boot with 8 CPUs enabled.  Can't see any '# CPU specific'
mods in the patch.  In any case, here is what I do have.


--------------------------------------------------------------------
mkbench - Time how long it takes to compile the kernel.  On this
        8 CPU system we use 'make -j 8' and increase the number
        of makes run in parallel.  Result is average build time in
        seconds.  Lower is better.
--------------------------------------------------------------------
# CPUs      # Makes         pre10          pre10-G1     pre10-Davide
--------------------------------------------------------------------
2           1               189             190            185
2           2               370             376            362
2           4               733             726*           717
2           6              1102            1082*          1077
4           1               101              99            101
4           2               199             192            195
4           4               387             382            381
4           6               581             551            568
8           1                58              56             -
8           2               110             104             -
8           4               214             204             -
8           6               314             305             -

* Most likely statisticly invalid results.  I run these things 3 times
  to make sure results are at lease consistent.  With pre10-G1 results
  varied more than the others.  Items marked with * had extremely high
  variations.

--------------------------------------------------------------------
Chat - VolanoMark simulator.  Result is a measure of throughput.
       Higher is better.
--------------------------------------------------------------------
Configuration Parms     # CPUs   pre10     pre10-G1   pre10-Davide
--------------------------------------------------------------------
10 rooms, 200 messages  2        143041    107718     181556
20 rooms, 200 messages  2        147335    147151     166048
30 rooms, 200 messages  2        179370    190413     173135
10 rooms, 200 messages  4        264033    287076     272597
20 rooms, 200 messages  4        243873    241855     273219
30 rooms, 200 messages  4        303228    301175     278513
10 rooms, 200 messages  8        304754    306891       -
20 rooms, 200 messages  8        241077    301414       -
30 rooms, 200 messages  8        309485    333660       -

-- 
Mike
