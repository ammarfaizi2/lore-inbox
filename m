Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbUC2Pbb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 10:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUC2Pbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 10:31:31 -0500
Received: from auemail2.lucent.com ([192.11.223.163]:45558 "EHLO
	auemail2.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S262971AbUC2Pb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 10:31:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16488.14980.884442.349267@gargle.gargle.HOWL>
Date: Mon, 29 Mar 2004 10:02:28 -0500
From: "John Stoffel" <stoffel@lucent.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "John Stoffel" <stoffel@lucent.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-mm1 - swapoff dies with OOM, why?
In-Reply-To: <20040328201259.1c8ee95c.akpm@osdl.org>
References: <16487.35872.160526.477780@gargle.gargle.HOWL>
	<20040328201259.1c8ee95c.akpm@osdl.org>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew> Were you using rc2-mm1 at the time?  It had a memory leak in
Andrew> ext3.  Lots of memroy was leaked, so swapoff cannot get
Andrew> sufficient memory to do its thing.

Yup, it looks like that might be the problem here.  I've now gotten
control of the system again (since I also had a disk die, thankfully
the data is all mirrored!) at the same time, and when badblocks runs
away on your, it's a nasty thing.

So yes, I was running 2.6.5-rc2-mm1, and I've now just rebooted the
system into 2.6.5-rc2-mm4 (with -mm5 released as I type this... :-).
Things are looking better now, time to load test this system and see
how it handles again.

I'm still wondering why swapoff dies though.  Shouldn't it complete,
or at least have some way *to* complete if needed?  I realize, with a
memory leak in the filesystem, it's a hard thing to deal with.  

Anyway, thanks for the quick response, using -mm4 to compile -mm5 is
looking much better.  Much lower cache size, decent buffer, and still
some free memory.  Not to try a badblocks pass on my dead drive...

Here's some vmstat output (dual proc 550mhz Xeon, 768mb of RAM, -j3
compile)

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 7  0      0 543328  17176 111344    0    0    12     0 1086   749 80 16  1  4
 2  0      0 533408  17180 111408    0    0    16     0 1084   260 87 12  0  0
 5  0      0 531552  17188 111468    0    0     4     0 1084   509 90 10  0  0
 2  0      0 532448  17208 111652    0    0    48    56 1093   356 83 15  1  1
 3  0      0 538912  17248 113924    0    0    80  1624 1152   329 72 17  7  3
 3  0      0 522464  17256 113984    0    0     8   332 1146   330 84 10  6  0
 2  0      0 540832  17276 114236    0    0    20     0 1087   524 81 17  0  2
 2  0      0 539936  17292 114356    0    0    16     0 1087   388 85 15  0  0

Thanks Andrew,
John
