Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVANS6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVANS6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 13:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVANS4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 13:56:53 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:21191 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261343AbVANSzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 13:55:11 -0500
Date: Fri, 14 Jan 2005 19:55:09 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 3/8] s390: Common I/O layer changes.
Message-ID: <20050114185509.GC6789@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 3/8] s390: Common I/O layer changes.

From: Steffen Thoss <thoss@de.ibm.com>

Common I/O layer changes:
 - Check if AIF is available on hardware before enabling
   the AIF time delay disablement facility.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/qdio.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff -urN linux-2.6/drivers/s390/cio/qdio.c linux-2.6-patched/drivers/s390/cio/qdio.c
--- linux-2.6/drivers/s390/cio/qdio.c	2005-01-14 19:44:49.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/qdio.c	2005-01-14 19:45:17.000000000 +0100
@@ -56,7 +56,7 @@
 #include "ioasm.h"
 #include "chsc.h"
 
-#define VERSION_QDIO_C "$Revision: 1.94 $"
+#define VERSION_QDIO_C "$Revision: 1.98 $"
 
 /****************** MODULE PARAMETER VARIABLES ********************/
 MODULE_AUTHOR("Utz Bacher <utz.bacher@de.ibm.com>");
@@ -2043,6 +2043,7 @@
 				"installed.\n");
 		return -ENOENT;
 	}
+
 	/* Check for bits 107 and 108. */
 	if (!css_chsc_characteristics.scssc ||
 	    !css_chsc_characteristics.scsscf) {
@@ -2132,7 +2133,11 @@
 	/* enables the time delay disablement facility. Don't care
 	 * whether it is really there (i.e. we haven't checked for
 	 * it) */
-	scssc_area->word_with_d_bit = 0x10000000;
+	if (css_general_characteristics.aif_tdd)
+		scssc_area->word_with_d_bit = 0x10000000;
+	else
+		QDIO_PRINT_WARN("Time delay disablement facility " \
+				"not available\n");
 
 
 
