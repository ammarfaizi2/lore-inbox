Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283561AbRLMGpG>; Thu, 13 Dec 2001 01:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283537AbRLMGo5>; Thu, 13 Dec 2001 01:44:57 -0500
Received: from mx2.elte.hu ([157.181.151.9]:30858 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S283501AbRLMGor>;
	Thu, 13 Dec 2001 01:44:47 -0500
Date: Thu, 13 Dec 2001 09:42:16 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-raid@vger.kernel.org>
Subject: [patch] RAID patches for 2.5.1
Message-ID: <Pine.LNX.4.33.0112130929001.7178-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've rewritten the 2.5.1 RAID-1 code to handle the new block layer
properly. The patch, against 2.5.1-pre10, can be found at:

   http://redhat.com/~mingo/raid-patches/raid-2.5.1-H2

Changes:

 - rewrote raid1.c/raid1.h to use bio's

 - large cleanups all around raid1.c/raid1.h. Streamlined/simplified code,
   more standard constructs used such as list.h. The RAID-1 code now uses
   sector_t all around the place, which enables the switching to 64-bit
   sector numbers later in 2.5.

 - got rid of the private bh/buffer pools within raid1.c, it's using the
   generic mempool interface now. This not only brings in a bit more
   performance, but is also much more maintainable and uses the same
   generic piece of code that is used by the IO layer's bio allocation
   code as well.

 - resync feature: it uses big IO requests to do resync now. This resulted
   in significant resync speedups on faster SCSI drives. resync thread CPU
   usage is much lower now as well.

 - a number of generic RAID layer cleanups. (md.c, include files.)

obviously, besides 2.5.1-pre10 being an extremely development kernel, this
patch is large, intrusive, and is work in progress as well. It is working
just fine on all systems tested so far (including Jens Axobe's own RAID1
array), but take care nevertheless.

(i'm now working on adopting raid5.c and multipath.c to the 2.5 block IO
architecture.)

	Ingo

