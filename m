Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315202AbSFOIxF>; Sat, 15 Jun 2002 04:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315204AbSFOIxE>; Sat, 15 Jun 2002 04:53:04 -0400
Received: from h-64-105-136-45.SNVACAID.covad.net ([64.105.136.45]:1689 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S315202AbSFOIxD>; Sat, 15 Jun 2002 04:53:03 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 15 Jun 2002 01:52:59 -0700
Message-Id: <200206150852.BAA00805@adam.yggdrasil.com>
To: axboe@suse.de
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
>The I/O path allocations all use GFP_NOIO (or GFP_NOFS), which all have
>__GFP_WAIT set. So the bio allocations will try normal allocation first,
>then fall back to the bio pool. If the bio pool is also empty, we will
>block waiting for entries to be freed there. So there never will be a
>failure.

	I did not realize that allocation with __GFP_WAIT was guaranteed
to _never_ fail.

	Even so, if __GFP_WAIT never fails, then it can deadlock (for
example, some other device driver has a memory leak).  Under a
scheme like bio_chain (provided that it is changed not to call a
memory allocator that can deadlock), the only way you deadlock is
if there really is deadlock bug in the lower layers that process
the underlying request.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
