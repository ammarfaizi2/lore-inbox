Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTKKEuw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 23:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbTKKEuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 23:50:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:42688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262694AbTKKEuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 23:50:50 -0500
Date: Mon, 10 Nov 2003 20:54:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Venezia <pvenezia@jpj.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I/O issues, iowait problems, 2.4 v 2.6
Message-Id: <20031110205443.6422259f.akpm@osdl.org>
In-Reply-To: <1068524657.25804.110.camel@soul.jpj.net>
References: <1068519213.22809.81.camel@soul.jpj.net>
	<20031110195433.4331b75e.akpm@osdl.org>
	<1068523328.25805.97.camel@soul.jpj.net>
	<20031110202819.7e7433a8.akpm@osdl.org>
	<1068524657.25804.110.camel@soul.jpj.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Venezia <pvenezia@jpj.net> wrote:
>
> vmstat output
> 
> 
>  procs                      memory      swap          io     system         cpu
>   r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>   0  0      0 1427316   8572  68472    0    0     0     0 1012    17  0  0 100  0
>   0  0      0 1427348   8580  68464    0    0     0    50 1014    20  0  0 99  1
>   0  0      0 1427412   8580  68464    0    0     0     0 1012    23  0  0 100  0
>   0  0      0 1427420   8580  68464    0    0     0     0 1012    15  0  0 100  0
>   0  0      0 1427484   8588  68456    0    0     0     8 1013    20  0  0 100  0
>   0  0      0 1427484   8588  68456    0    0     0     0 1012    22  0  0 100  0
>   0  0      0 1427484   8588  68456    0    0     0     0 1012    15  0  0 100  0
>   0 10      0 1318012   9776 169132    0    0   392 11202 34735 40869  4 33 32 32
>   2  6      0 1249532  10820 233980    0    0     0  1422 34765 42133  8 34  8 49
>   2  4      0 1192188  12048 288104    0    0    10  5276 33213 38553 11 39 15 36
>   4  4      0 1166588  12584 311844    0    0     4     0 31907 37992 14 41 18 26
>   0  4      0 1157372  13088 319976    0    0     4  1978 30261 35581 15 41 17 27
>   2  4      0 1163068  13460 313824    0    0     0  1886 29806 35017 16 41 15 28
>   4  4      0 1155700  13948 320544    0    0     0   202 30341 35867 15 42 16 27
>   3  4      0 1157044  14372 318692    0    0     0   696 30072 35217 16 43 17 24
>   4  4      0 1136820  15028 337688    0    0     0  1574 31872 36292 17 47 13 23
>   4  2      0 1141428  15404 332552    0    0     0  1980 30494 34756 17 46 17 20
>   4  2      0 1136052  15936 337256    0    0     2  2166 30653 35264 18 47 13 23
>   0 10      0 1136948  16284 336092    0    0     0  3456 26323 31729 10 30 25 35
>   0 14      0 1135668  16336 337264    0    0     0  2446 6548  7126  1  5 45 48
>   0 13      0 1135668  16336 337264    0    0     0   110 1038    59  0  0 54 46
>   0 13      0 1135676  16336 337264    0    0     0     0 1030    22  0  0 75 25
>   0 15      0 1133500  16404 336788    0    0     0  9304 6265  5409  2  6 37 55
>   0 13      0 1133308  16912 332132    0    0     0 11572 56145 61147  1  6  2 90
>   2 13      0 1131452  17088 333860    0    0     0  1316 18934 21857  2 11 18 69
>   0 13      0 1128444  17304 336772    0    0     0  1128 20925 23989  3 12 19 66
>   0 13      0 1129340  17548 335440    0    0     0   964 21529 25782  3 14 10 72
>   0 13      0 1128636  17776 336096    0    0     0   338 20924 23571  4 15  1 81
>   0 12      0 1135548  17980 313112    0    0     0  4056 21764 27560  3 15 15 66
>   0 12      0 1135868  18204 312616    0    0     0  4434 21152 25559  3 13 24 60
>   0 11      0 1146316  18352 287172    0    0     0  3442 18240 19442  2 10 40 47
>   2 11      0 1143052  18564 290428    0    0     0  1812 20483 22976  3 14 12 71
>   0 11      0 1142668  18720 290680    0    0    32  3298 15806 17710  3 10 17 70
>   0 10      0 1146444  18940 286856    0    0     0  2106 21450 25860  4 14 37 45

OK, the IO rates are obviously very poor, and the context switch rate is
suspicious as well.  Certainly, testing with the single disk would help.


But.  If the workload here was a simple dd of /dev/zero onto a regular
file then why on earth is the pagecache size not rising?  Could you please
do:

	rm foo
	cat /dev/zero > foo

and rerun the `vmstat 1' trace?  Make sure that after the big initial jump,
the `cache' column is increasing at a rate equal to the I/O rate.  Thanks.


