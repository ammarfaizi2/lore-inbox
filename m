Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVE0JBE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVE0JBE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 05:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVE0JBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 05:01:03 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:64973 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262395AbVE0JAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 05:00:31 -0400
Date: Fri, 27 May 2005 11:02:06 +0200
To: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: [patch 2/10] s390: multicast address registration in lcs
Message-ID: <20050527090206.GB8213@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Frank Pavlic <pavlic@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[patch 2/10] s390: multicast address registration in lcs.

From: Michael Holzheu <holzheu@de.ibm.com>

When setting lcs devices online you can run into an endless loop,
because the code that registers the multicast addresses uses
list_for_each_entry instead of list_for_each_entry_safe.

Signed-off-by: Frank Pavlic <pavlic@de.ibm.com>

diffstat:
 drivers/s390/net/lcs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/net/lcs.c linux-2.6-patched/drivers/s390/net/lcs.c
--- linux-2.6/drivers/s390/net/lcs.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/drivers/s390/net/lcs.c	2005-05-06 11:26:13.000000000 +0200
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.96 $	 $Date: 2004/11/11 13:42:33 $
+ *    $Revision: 1.97 $	 $Date: 2005/03/31 09:42:02 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.96 $"
+#define VERSION_LCS_C  "$Revision: 1.97 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 static char debug_buffer[255];
@@ -1160,7 +1160,7 @@ list_modified:
 		}
 	}
 	/* re-insert all entries from the failed_list into ipm_list */
-	list_for_each_entry(ipm, &failed_list, list) {
+	list_for_each_entry_safe(ipm, tmp, &failed_list, list) {
 		list_del_init(&ipm->list);
 		list_add_tail(&ipm->list, &card->ipm_list);
 	}
