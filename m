Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287173AbSALQcp>; Sat, 12 Jan 2002 11:32:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287158AbSALQbW>; Sat, 12 Jan 2002 11:31:22 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:6100 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S287173AbSALQbD>;
	Sat, 12 Jan 2002 11:31:03 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 12 Jan 2002 08:31:01 -0800
Message-Id: <200201121631.IAA06475@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: linux-2.5.2-pre11/drivers/loop.c bio question
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Has anyone out there tried to use linux-2.5.2-pre11/drivers/loop.c?
In my hacked version of loop.c, do_bio_blockbacked is often
called with a bio that has bio->bi_idx set to 1 rather than 0
(and with bi->bi_vcnt == 1), so it thinks it has no transfers to do.
When I add the kludge of doing "bio->bi_idx = 0;" at the beginning
of the routine, then it works fine.


	It is possible that my problem is self-inflicted because I
am using a version that I have adopted the "initial value" patch to,
and I also added a temporary hack to force the requests to be processed
one sector at a time, like so:

        blk_queue_max_segment_size(BLK_DEFAULT_QUEUE(MAJOR_NR), 512);

	However, I think my changes are probably not the cause.  Anyhow,
I thought I should mention this now to see if anyone else can
confirm or refute having similar problems.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
