Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVB0NmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVB0NmY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 08:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVB0NmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 08:42:24 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:26764 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261391AbVB0NmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 08:42:20 -0500
To: linux-mm@kvack.org
Subject: [PATCH] 0/2 Buddy allocator with placement policy + prezeroing
Cc: linux-kernel@vger.kernel.org
Message-Id: <20050227134219.B4346ECE4@skynet.csn.ul.ie>
Date: Sun, 27 Feb 2005 13:42:19 +0000 (GMT)
From: mel@csn.ul.ie (Mel Gorman)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the two following emails are the latest version of the placement policy
for the binary buddy allocator to reduce fragmentation and the prezeroing
patch. The changelogs are with the patches although the most significant change
to the placement policy is a fix for a bug in the usemap size calculation
(pointed out by Mike Kravetz). 

The placement policy is Even Better than previous versions and can allocate
over 100 2**10 blocks of pages under loads in excess of 30 so I still
consider it ready for inclusion to the mainline. The prezeroing patches
main contribution is a handy accounting scheme for the scrubbing daemon. The
patch records how many times blocks were zeroed and what size they were. I
found that order-0 is the most common size to zero because of the per-cpu
cache. For example, after the usual stress test completed, /proc/buddyinfo
reported the following;

Zeroblock count 1775307   7696   2048   1046   2577    871    164     17     18
8     39

That means that the majority of zeroing calls was for order-0 pages. What is
of greater concern is that the prezeroing patch seriously regresses how well
fragmentation is handled making it perform almost as badly as the standard
allocator. 

The patches were developed and tested heavily on 2.6.11-rc4 but are known
to patch cleanly and pass a stress test on 2.6.11-rc5.

-- 
Mel Gorman
