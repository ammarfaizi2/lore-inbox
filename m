Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVFUQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVFUQ3w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVFUQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:25:09 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:32237 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262172AbVFUQXz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:23:55 -0400
Date: Tue, 21 Jun 2005 18:23:57 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, cohuck@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 5/16] s390: cio max channels checks.
Message-ID: <20050621162357.GE6053@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 5/16] s390: cio max channels checks.

From: Cornelia Huck <cohuck@de.ibm.com>

Fix max channel check in cio_ignore display function.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/blacklist.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-06-21 17:36:48.000000000 +0200
@@ -1,7 +1,7 @@
 /*
  *  drivers/s390/cio/blacklist.c
  *   S/390 common I/O routines -- blacklisting of specific devices
- *   $Revision: 1.33 $
+ *   $Revision: 1.34 $
  *
  *    Copyright (C) 1999-2002 IBM Deutschland Entwicklung GmbH,
  *			      IBM Corporation
@@ -289,7 +289,7 @@ static int cio_ignore_read (char *page, 
 	len = 0;
 	for (devno = off; /* abuse the page variable
 			   * as counter, see fs/proc/generic.c */
-	     devno <= __MAX_SUBCHANNELS && len + entry_size < count; devno++) {
+	     devno < __MAX_SUBCHANNELS && len + entry_size < count; devno++) {
 		if (!test_bit(devno, bl_dev))
 			continue;
 		len += sprintf(page + len, "0.0.%04lx", devno);
@@ -302,7 +302,7 @@ static int cio_ignore_read (char *page, 
 		len += sprintf(page + len, "\n");
 	}
 
-	if (devno <= __MAX_SUBCHANNELS)
+	if (devno < __MAX_SUBCHANNELS)
 		*eof = 1;
 	*start = (char *) (devno - off); /* number of checked entries */
 	return len;
