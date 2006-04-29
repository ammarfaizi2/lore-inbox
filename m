Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751116AbWD2IZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbWD2IZW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 04:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWD2IZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 04:25:22 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:2472 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751116AbWD2IZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 04:25:21 -0400
Date: Sat, 29 Apr 2006 10:25:19 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Paulo Marques <pmarques@grupopie.com>
Subject: [patch 1/2] s390: fix ipd handling
Message-ID: <20060429082519.GB9463@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

As pointed out by Paulo Marques <pmarques@grupopie.com> MAX_IPD_TIME is
by a factor of ten too small. Since this means that we allow ten times more
IPDs in the intended time frame this could result in a cpu check stop of a
physical cpu.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/s390mach.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/s390mach.c b/drivers/s390/s390mach.c
index 5ae1480..f99e553 100644
--- a/drivers/s390/s390mach.c
+++ b/drivers/s390/s390mach.c
@@ -13,6 +13,7 @@ #include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/errno.h>
 #include <linux/workqueue.h>
+#include <linux/time.h>
 
 #include <asm/lowcore.h>
 
@@ -363,7 +364,7 @@ #endif
 }
 
 #define MAX_IPD_COUNT	29
-#define MAX_IPD_TIME	(5 * 60 * 100 * 1000) /* 5 minutes */
+#define MAX_IPD_TIME	(5 * 60 * USEC_PER_SEC) /* 5 minutes */
 
 /*
  * machine check handler.
