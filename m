Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264854AbTE1UHJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 16:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbTE1UHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 16:07:09 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:33179 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264854AbTE1UHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 16:07:05 -0400
Date: Wed, 28 May 2003 16:20:19 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux390@de.ibm.com
Cc: Pete Zaitcev <zaitcev@redhat.com>, James Antill <jantill@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Patch for strncmp use in s390 in 2.5
Message-ID: <20030528162019.A3492@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin & others:

I didn't see this posted before. Sorry if I missed it.
It's a harmless buglet which causes false positives with correctness
checking tools, and so annoys me.

Cheers,
-- Pete

--- linux-2.5.69-bk12/arch/s390/kernel/setup.c	2003-05-11 12:56:15.000000000 -0700
+++ linux-2.5.69-bk12-s390/arch/s390/kernel/setup.c	2003-05-28 13:01:54.000000000 -0700
@@ -165,15 +165,15 @@
 static int __init conmode_setup(char *str)
 {
 #if defined(CONFIG_SCLP_CONSOLE)
-	if (strncmp(str, "hwc", 4) == 0 || strncmp(str, "sclp", 5) == 0)
+	if (strncmp(str, "hwc", 3) == 0 || strncmp(str, "sclp", 4) == 0)
                 SET_CONSOLE_SCLP;
 #endif
 #if defined(CONFIG_TN3215_CONSOLE)
-	if (strncmp(str, "3215", 5) == 0)
+	if (strncmp(str, "3215", 4) == 0)
 		SET_CONSOLE_3215;
 #endif
 #if defined(CONFIG_TN3270_CONSOLE)
-	if (strncmp(str, "3270", 5) == 0)
+	if (strncmp(str, "3270", 4) == 0)
 		SET_CONSOLE_3270;
 #endif
         return 1;
