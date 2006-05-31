Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965018AbWEaN17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965018AbWEaN17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965019AbWEaN17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:27:59 -0400
Received: from ftp.linux-mips.org ([194.74.144.162]:3298 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S965018AbWEaN16
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:27:58 -0400
Date: Wed, 31 May 2006 14:27:50 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chad Reese <creese@caviumnetworks.com>
Subject: [PATCH] Sparsemem build fix.
Message-ID: <20060531132750.GA9504@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<linux/mmzone.h> uses PAGE_SIZE, PAGE_SHIFT from <asm/page.h> without
including that header itself.  For some sparsemem configurations this
may result in build errors like:

  CC      init/initramfs.o
In file included from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/rcupdate.h:41,
                 from include/linux/dcache.h:10,
                 from include/linux/fs.h:226,
                 from init/initramfs.c:2:
include/linux/mmzone.h:498:22: warning: "PAGE_SHIFT" is not defined
In file included from include/linux/gfp.h:4,
                 from include/linux/slab.h:15,
                 from include/linux/percpu.h:4,
                 from include/linux/rcupdate.h:41,
                 from include/linux/dcache.h:10,
                 from include/linux/fs.h:226,
                 from init/initramfs.c:2:
include/linux/mmzone.h:526: error: `PAGE_SIZE' undeclared here (not in a function)
include/linux/mmzone.h: In function `__pfn_to_section':
include/linux/mmzone.h:573: error: `PAGE_SHIFT' undeclared (first use in this function)
include/linux/mmzone.h:573: error: (Each undeclared identifier is reported only once
include/linux/mmzone.h:573: error: for each function it appears in.)
include/linux/mmzone.h: In function `pfn_valid':
include/linux/mmzone.h:578: error: `PAGE_SHIFT' undeclared (first use in this function)
make[1]: *** [init/initramfs.o] Error 1
make: *** [init] Error 2

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3674035..2d83371 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -15,6 +15,7 @@ #include <linux/init.h>
 #include <linux/seqlock.h>
 #include <linux/nodemask.h>
 #include <asm/atomic.h>
+#include <asm/page.h>
 
 /* Free memory management - zoned buddy allocator.  */
 #ifndef CONFIG_FORCE_MAX_ZONEORDER
