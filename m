Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUAHBXT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:23:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUAHBXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:23:19 -0500
Received: from [193.138.115.2] ([193.138.115.2]:5907 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S263330AbUAHBXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:23:18 -0500
Date: Thu, 8 Jan 2004 02:20:32 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
cc: Mark Hemment <markhe@nextd.demon.co.uk>,
       Andrea Arcangeli <andrea@e-mind.com>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH] mm/slab.c remove impossible <0 check - size_t is not signed
 - patch is against 2.6.1-rc1-mm2
Message-ID: <Pine.LNX.4.56.0401080204060.9700@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In mm/slab.c in the function kmem_cache_create, there's a check for
'offset < 0' that is completely unnessesary since 'offset' is of
type size_t, and size_t is an unsigned datatype in all archs.

The patch below removes this un-needed code - even gcc agrees that this
code is not needed and that case can never happen.


--- linux-2.6.1-rc1-mm2-orig/mm/slab.c  2004-01-06 01:33:09.000000000 +0100
+++ linux-2.6.1-rc1-mm2/mm/slab.c       2004-01-08 02:08:33.000000000 +0100
@@ -1042,7 +1042,7 @@ kmem_cache_create (const char *name, siz
 		(size < BYTES_PER_WORD) ||
 		(size > (1<<MAX_OBJ_ORDER)*PAGE_SIZE) ||
 		(dtor && !ctor) ||
-		(offset < 0 || offset > size))
+		(offset > size))
			BUG();

 #if DEBUG


Patch is compile tested, that's all - but it seems to be 'obviously
correct' to me.


Kind regards,

Jesper Juhl



PS. CC'ing the people mentioned in the comments of mm/slab.c since I
couldn't fine any single person responsible for this file in MAINTAINERS -
hope that's OK.

