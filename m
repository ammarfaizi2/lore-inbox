Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUCQJLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 04:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbUCQJLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 04:11:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:14511 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261197AbUCQJLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 04:11:01 -0500
Date: Wed, 17 Mar 2004 01:10:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.5-rc1 shm paging blocker
Message-Id: <20040317011053.78ae4821.akpm@osdl.org>
In-Reply-To: <20040317061522.GN30940@dualathlon.random>
References: <20040317061522.GN30940@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> One of those patchsets (extracted from kernel CVS) is screwing
>  completely the paging of shm in 2.6.5-rc1. The malfunction is nearly
>  no-swapping of shm and machine hanging forever in a sort of live lock
>  scenario and I've to click reboot.

Can't reproduce it, sorry.  Stock 2.6.5-rc1 on 4-way with mem=1024M,
shmmax=3e9:

procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
 0  0      0 908480  15140  76796    0    0     0     0 1017    30  0  0  0 100
 0  0      0 908480  15148  76788    0    0     0    76 1010    16  0  0  0 100
 0  0      0 908480  15148  76788    0    0    28     0 1030    56  2  0  2 96
41 21      0 865368  15148 115344    0    0     0     0 1011 33978  2 43  0 55
41 31      0 782576  15148 189940    0    0     0     0 1006 64580  5 95  0  0
47 40      0 701688  15148 259368    0    0     0     0 1006 13025  5 95  0  0
69 29      0 656960  15148 291668    0    0     0     0 1005  1918  6 94  0  0
62 29      0 644864  15156 291728    0    0     0    72 1007  4269  6 94  0  0
67 28      0 560192  15156 367888    0    0     0     0 1005 40205  5 95  0  0
67 30      0 511432  15156 406376    0    0     0     0 1005 24601  5 95  0  0
57 39      0 476744  15156 429224    0    0     0     0 1004 12228  6 94  0  0
80 46      0 443264  15156 450916    0    0     0     0 1005 16476  6 94  0  0
87 53      0 387840  15156 493484    0    0     0     0 1005 10994  6 94  0  0
90 49      0 310136  15156 561688    0    0     0     0 1005 39578  5 95  0  0
72 60      0 254384  15156 604936    0    0     0     0 1006 13469  6 94  0  0
104 59      0 198144  15156 652128    0    0     0     0 1006 46466  5 95  0  0
85 71      0 150144  15160 688844    0    0     0     4 1007 38554  5 95  0  0
101 63      0 110080  15160 718356    0    0     0     0 1006 15811  6 94  0  0
84 59      0  72832  15160 743856    0    0     0     0 1005  8047  5 95  0  0
96 60      0  46464  15160 757796    0    0     0     0 1005 11904  6 94  0  0
112 56      0   2696   9332 796740    0    0     0     0 1005 18330  6 94  0  0
85 53    684   2104   1380 796188    0    0     0   116 1000  4171  5 95  0  0
98 48   6416   3412    240 787788  428 5284   428  5284 1524  7250  4 96  0  0
94 47   8140   2908    240 784648  192 1988   192  1988 1034  3397  3 97  0  0
67 58  21632   3132    240 771612  328 10532   328 10532 1206 11524  5 95  0  0
94 73  26796   3796    244 765696  628 4692   628  4696 1184 21272  6 94  0  0
97 89  52528   5960    244 734396  652 8672   652  8672 1122 32257  7 93  0  0
47 97  57584   2164    184 730240 1284 28208  1284 28208 1103 15508  6 94  0  0
34 109  64376   2520    184 724280 1256 2072  1256  2072 1078 37640  4 96  0  0
procs                      memory      swap          io     system         cpu
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy wa id
131 104  68964   2232    184 719776  716 10304   716 10304 1079  9494  5 95  0  0

Is there some info I'm missing?
