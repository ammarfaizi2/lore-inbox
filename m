Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266478AbUF3RHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266478AbUF3RHk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266784AbUF3RHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:07:39 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:64762 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266478AbUF3RGi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:06:38 -0400
Date: Wed, 30 Jun 2004 19:07:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] 64 bit bug in radix-tree lookup.
Message-ID: <20040630170704.GB3189@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] 64 bit bug in radix-tree lookup.

The radix tree functions __lookup and __lookup_tag uses (1 << shift)
in their index calculations. On 64 bit systems the shift can be
bigger than 32. The shift of an integer by more than 32 bits evaluates
to zero which causes the lookup to fail.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 lib/radix-tree.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -urN linux-2.6/lib/radix-tree.c linux-2.6-s390/lib/radix-tree.c
--- linux-2.6/lib/radix-tree.c	Wed Jun 30 17:06:23 2004
+++ linux-2.6-s390/lib/radix-tree.c	Wed Jun 30 17:06:32 2004
@@ -494,8 +494,8 @@
 		for ( ; i < RADIX_TREE_MAP_SIZE; i++) {
 			if (slot->slots[i] != NULL)
 				break;
-			index &= ~((1 << shift) - 1);
-			index += 1 << shift;
+			index &= ~((1UL << shift) - 1);
+			index += 1UL << shift;
 			if (index == 0)
 				goto out;	/* 32-bit wraparound */
 		}
@@ -584,8 +584,8 @@
 				BUG_ON(slot->slots[i] == NULL);
 				break;
 			}
-			index &= ~((1 << shift) - 1);
-			index += 1 << shift;
+			index &= ~((1UL << shift) - 1);
+			index += 1UL << shift;
 			if (index == 0)
 				goto out;	/* 32-bit wraparound */
 		}
