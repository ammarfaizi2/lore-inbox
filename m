Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSJDR2q>; Fri, 4 Oct 2002 13:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSJDR2G>; Fri, 4 Oct 2002 13:28:06 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:62080 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S262782AbSJDR1w>;
	Fri, 4 Oct 2002 13:27:52 -0400
Message-ID: <3D9DCA1D.7070400@colorfullife.com>
Date: Fri, 04 Oct 2002 19:04:29 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: akpm@digeo.com, linux-kernel@vger.kernel.org
CC: mbligh@aracnet.com
Subject: [PATCH] patch-slab-split-03-tail
Content-Type: multipart/mixed;
 boundary="------------010100020304010803080807"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100020304010803080807
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

part 3:
[depends on -02-SMP]

If an object is freed from a slab, then move the slab to the tail of the 
partial list - this should increase the probability that the other 
objects from the same page are freed, too, and that a page can be 
returned to gfp later.

The cpu arrays are now always in front of the list, i.e. cache hit rates 
should not matter.


Please apply

--
	Manfred


--------------010100020304010803080807
Content-Type: text/plain;
 name="patch-slab-split-03-tail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-split-03-tail"

--- 2.5/mm/slab.c	Fri Oct  4 18:59:01 2002
+++ build-2.5/mm/slab.c	Fri Oct  4 18:59:11 2002
@@ -1478,7 +1478,7 @@
 		} else if (unlikely(inuse == cachep->num)) {
 			/* Was full. */
 			list_del(&slabp->list);
-			list_add(&slabp->list, &cachep->slabs_partial);
+			list_add_tail(&slabp->list, &cachep->slabs_partial);
 		}
 	}
 }

--------------010100020304010803080807--


