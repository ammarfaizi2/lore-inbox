Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267679AbTAHVyf>; Wed, 8 Jan 2003 16:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267799AbTAHVyf>; Wed, 8 Jan 2003 16:54:35 -0500
Received: from web10005.mail.yahoo.com ([216.136.130.41]:47012 "HELO
	web10005.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267679AbTAHVyf>; Wed, 8 Jan 2003 16:54:35 -0500
Message-ID: <20030108220316.83003.qmail@web10005.mail.yahoo.com>
Date: Wed, 8 Jan 2003 14:03:16 -0800 (PST)
From: Shangc <shangcs@yahoo.com>
Subject: [PATCH] mm/slab.c, kernel <2.4.20>
To: linux-kernel@vger.kernel.org
Cc: markhe@nextd.demon.co.uk
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/**
 * --readme--
 * make a better initial value for i, which will
reduce the number of 
while loop.
 * the change can be proved mathematically:
 *
 * i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage
 * ==> i*size + base + i*extra <= wastage
 * ==> solve about equation about i
 * ==> i <= (wastage - base) / (size + extra)
 *
 * Chen Shang
 * shangcs@yahoo.com
 */

--- slab.c	2003-02-08 04:26:50.000000000 -0500
+++ slab.c	2003-02-08 04:26:14.000000000 -0500
@@ -397,7 +397,7 @@
 		base = sizeof(slab_t);
 		extra = sizeof(kmem_bufctl_t);
 	}
-	i = 0;
+	i = (wastage - base) / (size + extra);
 	while (i*size + L1_CACHE_ALIGN(base+i*extra) <=
wastage)
 		i++;
 	if (i > 0)

__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
