Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137038AbRASXfp>; Fri, 19 Jan 2001 18:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137055AbRASXff>; Fri, 19 Jan 2001 18:35:35 -0500
Received: from gateway.sequent.com ([192.148.1.10]:55990 "EHLO
	gateway.sequent.com") by vger.kernel.org with ESMTP
	id <S137054AbRASXfd>; Fri, 19 Jan 2001 18:35:33 -0500
Date: Fri, 19 Jan 2001 15:35:21 -0800
From: Mike Kravetz <mkravetz@sequent.com>
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: multi-queue scheduler update
Message-ID: <20010119153521.K26968@w-mikek.des.sequent.com>
In-Reply-To: <20010118155311.B8637@w-mikek.des.sequent.com> <20010119012616.D32087@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010119012616.D32087@athlon.random>; from andrea@suse.de on Fri, Jan 19, 2001 at 01:26:16AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As promised, here are some numbers for low thread counts from the
benchmark Andrew and Davide provided.  I ran the benchmark for
1,2,4 and 8 threads.  I ran the test 5 times for each thread count
and used 60 seconds as the measure time in each case.

2.4.0
-----
1               1785408         1785408         0               0.000000
1               1786130         1786130         0               0.000000
1               1786156         1786156         0               0.000000
1               1781575         1781575         0               0.000000
1               1780079         1780079         0               0.000000
2               1873405         936702          0               0.000000
2               2006473         1003236         0               0.000001
2               1953842         976921          0               0.000004
2               1951338         975669          0               0.000000
2               1887887         943943          0               0.000004
4               1936350         484087          0               0.000055
4               1814430         453607          0               0.000087
4               1972681         493170          0               0.000055
4               1951748         487937          0               0.000206
4               1862182         465545          0               0.000283
8               2917216         364652          0               0.000008
8               2655834         331979          0               0.000018
8               3026734         378341          0               0.000005
8               3010204         376275          0               0.000004
8               2569647         321205          0               0.000014

2.4.0-multi-queue
-----------------
1               1295498         1295498         0               0.000000
1               1295011         1295011         0               0.000000
1               1296768         1296768         0               0.000000
1               1296053         1296053         0               0.000000
1               1296472         1296472         0               0.000000
2               1999043         999521          0               0.000000
2               1410636         705318          0               0.000000
2               1414476         707238          0               0.000000
2               2014664         1007332         0               0.000001
2               1414509         707254          0               0.000000
4               2046182         511545          0               0.000232
4               2101535         525383          0               0.000115
4               2094828         523707          0               0.000155
4               2097406         524351          0               0.000144
4               2057331         514332          0               0.000132
8               3795829         474478          0               0.000185
8               4058329         507291          0               0.001871
8               3845934         480741          0               0.000248
8               3715243         464405          0               0.000084
8               3777303         472162          0               0.000194

As expected the single thread numbers for the multi-queue scheduler
are not as good as those of the existing scheduler.  However, at 2
threads it is getting pretty close and from 4 threads up, the
multi-queue scheduler does better.

In this multi-queue implementation, the amount of overhead is
related to the number of processors in the system.  Therefore,
I would expect the numbers to 'be better' for low thread counts
on systems with lower (<8) processor counts.  It would be
interesting to see if the point at which the multi-queue does
better stays at aprox CPUs/2 as we change system configurations.
Hopefully we will have some more extensive benchmark results in
the not too distant future.  Until then, we'll be looking into
optimizations to help out the multi-queue scheduler at low
thread counts.

-- 
Mike Kravetz                                 mkravetz@sequent.com
IBM Linux Technology Center
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
