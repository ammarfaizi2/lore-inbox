Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbUKWJkp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUKWJkp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 04:40:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbUKWJkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 04:40:45 -0500
Received: from dp.samba.org ([66.70.73.150]:50307 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262430AbUKWJiP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 04:38:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16803.1243.69076.294925@samba.org>
Date: Tue, 23 Nov 2004 20:37:31 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119162651.2d62a6a8.akpm@osdl.org>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<20041119162651.2d62a6a8.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

 > > Would anyone care to hazard a guess as to what aspect of -mm2 is
 > > gaining us 10% in overall Samba4 performance?
 > 
 > Is it reproducible with your tricked-up dbench?
 > 
 > If so, please send me a machine description and the relevant command line
 > and I'll do a bsearch.

Sorry for the delay in getting back to you on this. The full set of
runs for the data I posted last night took 12 hours to produce, so the
machine was a bit busy.

I've now confirmed that the new dbench does indeed show a significant
improvement in 2.6.10-rc2-mm2 as compared to
2.6.10-rc2. Interestingly, the improvement seems to be only in ext3,
which confused me for a while. The difference is also much more
dramatic (as a percentage) when xattrs are enabled in the test.

Here are the results for dbench3 runs with varying numbers of clients,
and with rc2 and rc2-mm2 for ext3. First the non-xattr results:

clients  -rc2   rc2-mm2
-----------------------
10        362       376
20        328       357
30        249       270
40        169       199
50        128       155
60        107       143

now the xattr results (using the -x option to dbench)

clients  -rc2   rc2-mm2
-----------------------
10         58       125
20         44        64
30         43        54
40         42        52
50         49        49
60         40        47

I don't know why there was no improvement at size 50.

for comparison, there is very little difference for xfs (or the other
filesystems I tested, which were jfs, reiser and ext2). Here are the
non-xattr xfs results:

clients  -rc2   rc2-mm2
-----------------------
10        365       368
20        324       328
30        254       257
40        194       212
50        128       139
60         58        59

The script I used to run dbench is at
  http://samba.org/~tridge/xattr_results/
the details on the machine config are there too.

For your bsearch, its probably best to choose one of the clearest
and least noisy results (like the xattr result for size 20) and just
run the search for that one. That will take a bit under 5 minutes per
test if you use the same runtime I did. You could do it quicker, but
you risk getting more noise in the results.

Cheers, Tridge
