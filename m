Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269720AbTGJXpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269719AbTGJXpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 19:45:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:4545 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S269720AbTGJXoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 19:44:32 -0400
Message-ID: <3F0DFC26.3050501@us.ibm.com>
Date: Thu, 10 Jul 2003 16:52:06 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
Organization: IBM LTC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: [trivial][patch] no more warnings [3/3] ide_scan_direction
Content-Type: multipart/mixed;
 boundary="------------010303030602000605020009"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010303030602000605020009
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ide_scan_direction is defined in general, but only ever referenced in 
code wrapped by CONFIG_BLK_DEV_IDEPCI.  This wraps the definition of 
ide_scan_direction in CONFIG_BLK_DEV_IDEPCI, too, to silence warnings 
about being defined and not used.

Cheers!

-Matt

--------------010303030602000605020009
Content-Type: text/plain;
 name="ide-warning.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide-warning.patch"

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.5.74-vanilla/drivers/ide/ide.c linux-2.5.74-warnings/drivers/ide/ide.c
--- linux-2.5.74-vanilla/drivers/ide/ide.c	Wed Jul  2 13:43:59 2003
+++ linux-2.5.74-warnings/drivers/ide/ide.c	Thu Jul 10 14:47:24 2003
@@ -180,7 +180,9 @@ static int initializing;	/* set while in
 DECLARE_MUTEX(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
+#ifdef CONFIG_BLK_DEV_IDEPCI
 static int ide_scan_direction; /* THIS was formerly 2.2.x pci=reverse */
+#endif
 
 #ifdef CONFIG_IDEDMA_AUTO
 int noautodma = 0;

--------------010303030602000605020009--

