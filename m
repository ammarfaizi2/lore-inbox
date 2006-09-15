Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWIOL0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWIOL0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 07:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWIOL0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 07:26:53 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:9269 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751267AbWIOL0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 07:26:53 -0400
Date: Fri, 15 Sep 2006 13:26:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, cornelia.huck@de.ibm.com
Subject: [S390] Get rid of DBG macro.
Message-ID: <20060915112649.GA23134@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cornelia Huck <cornelia.huck@de.ibm.com>

[S390] Get rid of DBG macro.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/s390mach.c |   17 +++++++----------
 1 files changed, 7 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/drivers/s390/s390mach.c linux-2.6-patched/drivers/s390/s390mach.c
--- linux-2.6/drivers/s390/s390mach.c	2006-09-15 12:17:37.000000000 +0200
+++ linux-2.6-patched/drivers/s390/s390mach.c	2006-09-15 12:18:41.000000000 +0200
@@ -19,9 +19,6 @@
 
 #include "s390mach.h"
 
-#define DBG printk
-// #define DBG(args,...) do {} while (0);
-
 static struct semaphore m_sem;
 
 extern int css_process_crw(int, int);
@@ -83,11 +80,11 @@ repeat:
 		ccode = stcrw(&crw[chain]);
 		if (ccode != 0)
 			break;
-		DBG(KERN_DEBUG "crw_info : CRW reports slct=%d, oflw=%d, "
-		    "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
-		    crw[chain].slct, crw[chain].oflw, crw[chain].chn,
-		    crw[chain].rsc, crw[chain].anc, crw[chain].erc,
-		    crw[chain].rsid);
+		printk(KERN_DEBUG "crw_info : CRW reports slct=%d, oflw=%d, "
+		       "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+		       crw[chain].slct, crw[chain].oflw, crw[chain].chn,
+		       crw[chain].rsc, crw[chain].anc, crw[chain].erc,
+		       crw[chain].rsid);
 		/* Check for overflows. */
 		if (crw[chain].oflw) {
 			pr_debug("%s: crw overflow detected!\n", __FUNCTION__);
@@ -117,8 +114,8 @@ repeat:
 			 * reported to the common I/O layer.
 			 */
 			if (crw[chain].slct) {
-				DBG(KERN_INFO"solicited machine check for "
-				    "channel path %02X\n", crw[0].rsid);
+				pr_debug("solicited machine check for "
+					 "channel path %02X\n", crw[0].rsid);
 				break;
 			}
 			switch (crw[0].erc) {
