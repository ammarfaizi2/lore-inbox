Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVFASWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVFASWL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:22:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVFASLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:11:43 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:9949 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S261506AbVFASCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:02:10 -0400
Date: Wed, 1 Jun 2005 20:02:10 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 1/11] s390: cio max channels checks.
Message-ID: <20050601180210.GA6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 1/11] s390: cio max channels checks.

From: Cornelia Huck <cohuck@de.ibm.com>

Fix max channel check in cio_ignore display function.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/cio/blacklist.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -urpN linux-2.6/drivers/s390/cio/blacklist.c linux-2.6-patched/drivers/s390/cio/blacklist.c
--- linux-2.6/drivers/s390/cio/blacklist.c	2005-03-02 08:37:53.000000000 +0100
+++ linux-2.6-patched/drivers/s390/cio/blacklist.c	2005-06-01 19:43:14.000000000 +0200
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
