Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271706AbTGRFcR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 01:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTGRFcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 01:32:17 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49539
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S271706AbTGRFcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 01:32:15 -0400
Date: Fri, 18 Jul 2003 07:47:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org, Chris Mason <mason@suse.com>
Subject: Re: 2.4.22pre6aa1
Message-ID: <20030718054709.GA3928@dualathlon.random>
References: <20030717102857.GA1855@dualathlon.random> <200307180013.38078.m.c.p@wolk-project.de> <200307180024.17523.m.c.p@wolk-project.de> <20030717225002.GY1855@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717225002.GY1855@dualathlon.random>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 12:50:02AM +0200, Andrea Arcangeli wrote:
> At least on my machines the contigous I/O still at the same speed.

Just to be 100% sure I run an accurate benchmarks myself too. I had the
numbers for the pre-2.4.22pre levels, but I didn't benchmarked yet on
the final code in mainline that had some cosmetical difference.

These are the results for the contigous I/O with vanilla 2.4.21 against
vanilla 2.4.22-pre6 against 2.4.22pre6aa2 (and aa2 is completely equal
to aa1 in terms of blkdev/IO). BTW, pre6aa2 is configured as desktop so
it has some additional overhead (not significant in pure I/O bound
computatations).

aic7xxx booted with mem=128m ext3 data=ordered

              -------Sequential Output-------- ---Sequential Input-- --Random--
              -Per Char- --Block--- -Rewrite-- -Per Char- --Block--- --Seeks---
Kernel     MB K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU K/sec %CPU  /sec %CPU
2.4.21    100 11052 77.3 21683 15.5 16401  8.8 20347 82.1 32765  6.1 865.6  2.8
2.4.21    100 13533 94.5 21236 13.9 15904  7.9 21182 82.3 35019  5.1 1254.3  2.2
2.4.21    100 12402 86.5 22453 14.9 16165  5.8 20270 82.1 34754  6.4 1398.8  3.8

22pre6    100 13070 91.4 23314 15.3 15402  6.5 21202 81.8 33167  8.4 959.9  2.2
22pre6    100 13181 92.2 18556 12.5 16506  6.9 20562 78.1 33394  4.9 1271.9  1.9
22pre6    100 14082 98.5 23170 16.1 16199  5.7 21045 81.2 34124  7.3 1450.6  4.0

22pre6aa2 100 12703 90.5 23245 16.3 15533  6.8 19730 79.6 37072  8.0 775.9  1.4
22pre6aa2 100 13241 94.0 20602 14.4 15562  7.0 19675 79.6 37102  7.7 843.5  1.8
22pre6aa2 100 12948 93.0 21566 15.0 15970  7.6 19460 81.7 36599  7.2 740.6  1.7

as you can see for contigous I/O I can't measure any regression at all,
the minor variations across the three runs are likely for the largest
part influenced by the ext3 block allocation that can change for every
run.

Andrea
