Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280742AbRKBRe6>; Fri, 2 Nov 2001 12:34:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280744AbRKBRes>; Fri, 2 Nov 2001 12:34:48 -0500
Received: from mailrelay2.inwind.it ([212.141.54.102]:46270 "EHLO
	mailrelay2.inwind.it") by vger.kernel.org with ESMTP
	id <S280742AbRKBRec>; Fri, 2 Nov 2001 12:34:32 -0500
Message-Id: <3.0.6.32.20011102183650.02007100@pop.tiscalinet.it>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.6 (32)
Date: Fri, 02 Nov 2001 18:36:50 +0100
To: Stephan von Krawczynski <skraw@ithnet.com>
From: Lorenzo Allegrucci <lenstra@tiscalinet.it>
Subject: Re: new OOM heuristic failure  (was: Re: VM: qsbench)
Cc: torvalds@transmeta.com, riel@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011102140001.7c995186.skraw@ithnet.com>
In-Reply-To: <3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
 <Pine.LNX.4.33L.0110311259570.2963-100000@imladris.surriel.com>
 <3.0.6.32.20011031185529.01fc4310@pop.tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14.00 02/11/01 +0100, Stephan von Krawczynski wrote:
>Hello Lorenzo,
>
>please find attached next vmscan.c patch which sums up the delayed swap_out
>(first patch), the fix for not swapping when nr_pages is reached, and (new) the
>idea to swap more pages in one call to swap_out if priority gets higher.
>
>I have not the slightest idea what all this does to the performance. Especially
>the "more" swap_out code is a pure try-and-error type of thing. Can you do some
>testing please?

vmscan-patch2 looks slightly slower than vmscan-patch:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.800u 2.210s 2:27.96 49.3%    0+0k 0+0io 18551pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.600u 2.150s 2:28.49 48.9%    0+0k 0+0io 18728pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.690u 2.080s 2:28.77 48.9%    0+0k 0+0io 18753pf+0w
1:03 kswapd

Same test with 400M of swap:

lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
72.180u 2.110s 2:31.37 49.0%    0+0k 0+0io 18696pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.400u 2.200s 2:31.04 48.0%    0+0k 0+0io 18940pf+0w
lenstra:~/src/qsort> time ./qsbench -n 90000000 -p 1 -s 140175100
70.950u 2.210s 2:32.35 48.0%    0+0k 0+0io 19115pf+0w
1:02 kswapd

kswapd still takes many cycles.


-- 
Lorenzo
