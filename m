Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVFNO2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVFNO2q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 10:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVFNO2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 10:28:46 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:28040 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261237AbVFNO2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:28:43 -0400
Date: Tue, 14 Jun 2005 19:56:12 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] files: scalable fd management (V4)
Message-ID: <20050614142612.GA4557@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated version of patchset published earlier
at - http://marc.theaimsgroup.com/?l=linux-kernel&m=111747394710704&w=2

Since then I have done the following additional testing :

1. SMP/UP kernels with and without CONFIG_PREEMPT on x86 and ppc64.
   running various tests like ltp, dbench, tiobench, reaim. 

2. Testing with a testcase that creates > 1024 fds and exercises
   the vmalloc allocation and freeing path.

3. More 24+ hour runs on both x86 and ppc64

4. Touch testing with X running on a desktop.

5. Testing with __ARCH_HAS_CMPXCHG undefined. I booted and ran some
   basic tests with this on a ppc64 SMP box in order to exercise
   the hashed locking.

Additional performance #s :
---------------------------

tiobench on a 4-way ppc64 system :
                                        (lockfree)
Test            2.6.10-vanilla  Stdev   2.6.10-fd       Stdev
-------------------------------------------------------------
Seqread         1428            32.47   1475.0          29.11
Randread        1469.2          17.27   1599.6          35.95
Seqwrite        262.06          9.31    246.8           30.94
Randwrite       548.38          12.49   521.4           61.98

With LL/SC based locks, cache line bouncing effect of file_lock
is not as pronounced, but it still makes a difference 
with seq and random reads.

Andrew, would it be possible to give this some testing time
in -mm ? If so, please let me know what would be an appropriate
time for that and I will send patches against -mm.

Thanks
Dipankar
