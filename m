Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbUCLCTz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 21:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUCLCTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 21:19:55 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:21007
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261906AbUCLCTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 21:19:53 -0500
Date: Fri, 12 Mar 2004 03:20:36 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312022036.GP30940@dualathlon.random>
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112043420.2120-100000@localhost.localdomain> <20040312014710.GO30940@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040312014710.GO30940@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 02:47:10AM +0100, Andrea Arcangeli wrote:
> my patch is not stable yet, it crashes during swapping and the debugging
> code catches bug even before swapping (which is good):

I fixed some more bugs (s/index/private), it's not stable yet but some basic
swapping works now (there is probably some issue with shared swapcache
still, since ps just oopsed, and ps may be sharing-cow swapcache through
fork).

 0  0      0 408712   7800  41160    0    0     0     0 1131    46  0  0 95  5
 0  0      0 408712   7800  41160    0    0     0     0 1102    64  0  0 100  0
 0  0      0 408712   7800  41160    0    0     0     0 1090    40  0  0 100  0
 0  0      0 408712   7800  41160    0    0     0     0 1107    84  0  0 100  0
 0  0      0 408712   7808  41152    0    0     0    84 1101    66  0  0 100  0
 0  0      0 408712   7808  41152    0    0     0     0 1096    52  0  0 100  0
 1  0      0 264808   7808  41152    0    0     0     0 1093    49  5 16 79  0
 1  0      0  51636   7808  41152    0    0     0     0 1083    34  5 20 75  0
 1  1    128   2384    212  14068    0  128     0   204 1106   178  1  7 73 19
 1  2  82824   2332    200   2136   32 82668    40 82668 1221  1955  1 12 49 38
 1  2 130000   2448    208   1868   32 47048   312 47048 1184   782  0  5 60 35
 0  3 178700   1676    208   2428 10388 48700 11000 48700 1536  1291  0  4 55 40
 0  3 205996   1780    216   1992 4264 27224  4424 27224 1312   549  1  4 41 55
 2  2 238900   4148    240   2388   88 32980   684 32984 1190  1380  1  6 23 69
 0  3 295124   1996    244   2392   92 56148   232 56148 1223   149  1  6 38 54
 0  2 315204   2036    244   2356    0 19972     0 19972 1172    55  1  2 52 45
 1  0 334052   3924    264   2592  192 18720   372 18720 1205   154  0  1 35 63
 0  3 377208   2324    264   1928   64 42984    64 42984 1249   208  2  6 39 53
 0  1 389856   3408    264   2032  128 12680   224 12680 1187   159  0  1 60 38
 0  0 374032 263036    316   3504  920    0  2464     0 1258   224  0  2 76 23
 0  0 374032 263036    316   3504    0    0     0     0 1087    27  0  0 100  0
 0  0 374032 263036    316   3504    0    0     0     0 1083    25  0  0 100  0
 0  0 374032 263040    316   3504    0    0     0     0 1086    25  0  0 100  0
 0  0 374032 263040    316   3504    0    0     0     0 1084    27  0  0 100  0
 0  0 374032 263128    316   3504    0    0     0     0 1086    23  0  0 100  0
 0  0 374032 263164    316   3472   32    0    32     0 1086    23  0  0 100  0
 0  0 374032 263212    316   3508   32    0    32     0 1086    25  0  0 100  0

I uploaded a new anon_vma patch in the same directory with the fixes to make
the basic swapping work. Tomorrow I'll look into the ps oops and into
heavey cow loads.
