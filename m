Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUE1TFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUE1TFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 15:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUE1TFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 15:05:37 -0400
Received: from ned.cc.purdue.edu ([128.210.189.24]:25765 "EHLO
	ned.cc.purdue.edu") by vger.kernel.org with ESMTP id S263804AbUE1TFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 15:05:31 -0400
From: Patrick Finnegan <pat@computer-refuge.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Alpha compile error on 2.6.7-rc1
Date: Fri, 28 May 2004 14:05:30 -0500
User-Agent: KMail/1.5.4
Cc: rth@twiddle.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405281405.30638.pat@computer-refuge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine is a 21164A Alpha (164LX motherboard).  The error is:

  CC      arch/alpha/mm/init.o
arch/alpha/mm/init.c: In function `show_mem':
arch/alpha/mm/init.c:120: structure has no member named `count'
make[1]: *** [arch/alpha/mm/init.o] Error 1
make: *** [arch/alpha/mm] Error 2

Patch is below.

Alpha: Fixup arch/alpha/mm/init.c to match struct page changes 

--- linux-2.6.7-rc1.old/arch/alpha/mm/init.c	2004-05-28 13:53:04.000000000 -0500
+++ linux-2.6.7-rc1/arch/alpha/mm/init.c	2004-05-28 13:53:52.000000000 -0500
@@ -117,7 +117,7 @@
 		else if (!page_count(mem_map+i))
 			free++;
 		else
-			shared += atomic_read(&mem_map[i].count) - 1;
+			shared += atomic_read(&mem_map[i]._count) - 1;
 	}
 	printk("%ld pages of RAM\n",total);
 	printk("%ld free pages\n",free);

-- Pat
Purdue University ITAP/RCS        ---  http://www.itap.purdue.edu/rcs/
The Computer Refuge               ---  http://computer-refuge.org
