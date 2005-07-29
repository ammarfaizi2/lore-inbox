Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVG2URQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVG2URQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262813AbVG2UOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:14:50 -0400
Received: from tayrelbas01.tay.hp.com ([161.114.80.244]:34006 "EHLO
	tayrelbas01.tay.hp.com") by vger.kernel.org with ESMTP
	id S262735AbVG2UNh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:13:37 -0400
X-MIMEOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: [Patch] Trival - Add warning to init/main.c
Date: Fri, 29 Jul 2005 16:13:33 -0400
Message-ID: <6B003D25ADBDE347B5542AFE6A55B42E06EA4FD7@tayexc13.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Patch] Trival - Add warning to init/main.c
thread-index: AcWUaWngKv5UIg0XSOCv0ydXcHWuKAADnyLA
From: "Avery, Brian" <b.avery@hp.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jul 2005 20:13:34.0179 (UTC) FILETIME=[FF1A3B30:01C59479]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I passed init=/mylinuxrc to the kernel on the command line.  The kernel
silently dropped down to exec /sbin/init.  It turned out that /mylinuxrc
had improper permissions.  Without any warning message from the kernel
that something was wrong it took awhile to find the issue.  The patch
below adds a warning.

Regards,
Brian Avery


--- init/main.c.orig    2005-07-29 13:27:18.666231288 -0400
+++ init/main.c   2005-07-29 13:01:08.000000000 -0400
@@ -701,9 +701,10 @@ static int init(void * unused)
       * trying to recover a really broken machine.
       */
 
-     if (execute_command)
-           run_init_process(execute_command);
-
+     if (execute_command){
+                run_init_process(execute_command);
+                printk(KERN_WARNING "Failed to execute %s.  Attempting
defaults...\n",execute_command);
+        }        
      run_init_process("/sbin/init");
      run_init_process("/etc/init");
      run_init_process("/bin/init");
 
