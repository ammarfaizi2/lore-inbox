Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293048AbSCOS3k>; Fri, 15 Mar 2002 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293058AbSCOS3e>; Fri, 15 Mar 2002 13:29:34 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:41866 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S293048AbSCOS3X>; Fri, 15 Mar 2002 13:29:23 -0500
Date: Fri, 15 Mar 2002 13:29:16 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: schwidefsky@de.ibm.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: 2.4.19-pre3 s390 patch for hwc_con.c
Message-ID: <20020315132916.C24597@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes hwc_con more resilient to structure layout changes.
It's not _strictly_ necessary, but I would like it to be in.

-- Pete

diff -ur -X dontdiff linux-2.4.19-pre3/drivers/s390/char/hwc_con.c linux-2.4.19-pre3-390/drivers/s390/char/hwc_con.c
--- linux-2.4.19-pre3/drivers/s390/char/hwc_con.c	Wed Jul 25 14:12:02 2001
+++ linux-2.4.19-pre3-390/drivers/s390/char/hwc_con.c	Fri Mar 15 08:39:17 2002
@@ -31,20 +31,12 @@
 
 #define  HWC_CON_PRINT_HEADER "hwc console driver: "
 
-struct console hwc_console =
-{
-
-	hwc_console_name,
-	hwc_console_write,
-	NULL,
-	hwc_console_device,
-	NULL,
-	hwc_console_unblank,
-	NULL,
-	CON_PRINTBUFFER,
-	0,
-	0,
-	NULL
+struct console hwc_console = {
+	name:	hwc_console_name,
+	write:	hwc_console_write,
+	device:	hwc_console_device,
+	unblank:hwc_console_unblank,
+	flags:	CON_PRINTBUFFER,
 };
 
 void 
