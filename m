Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268047AbRGYUn5>; Wed, 25 Jul 2001 16:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268105AbRGYUni>; Wed, 25 Jul 2001 16:43:38 -0400
Received: from rj.sgi.com ([204.94.215.100]:37838 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S268063AbRGYUng>;
	Wed, 25 Jul 2001 16:43:36 -0400
Date: Wed, 25 Jul 2001 13:43:41 -0700
From: richard offer <offer@sgi.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: unitialized variable in 2.4.7 (sym53c8xx, dmi_scan)
Message-ID: <177030000.996093821@changeling.engr.sgi.com>
X-Mailer: Mulberry/2.1.0b2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Compiling with -Werror to catch my development mistakes gives.

sym53c8xx.c:6994: warning: `istat' might be used uninitialized in this
function

dmi_scan.c:161: warning: `disable_ide_dma' defined but not used

The following fixes these issues.

8<--------------------------------------------------------------
===== arch/i386/kernel/dmi_scan.c 1.3 vs edited =====
--- 1.3/arch/i386/kernel/dmi_scan.c     Wed Jul 18 02:43:27 2001
+++ edited/arch/i386/kernel/dmi_scan.c  Wed Jul 25 13:41:59 2001
@@ -157,6 +157,7 @@
  *     corruption problems
  */ 
  
+#if 0 /* commented out until its used in dmi_blacklist[] */
 static __init int disable_ide_dma(struct dmi_blacklist *d)
 {
 #ifdef CONFIG_BLK_DEV_IDE
@@ -169,6 +170,7 @@
 #endif
        return 0;
 }
+#endif
 
 /* 
  * Some machines require the "reboot=b"  commandline option, this quirk
makes that automatic.
===== drivers/scsi/sym53c8xx.c 1.6 vs edited =====
--- 1.6/drivers/scsi/sym53c8xx.c        Thu Jul  5 04:28:16 2001
+++ edited/drivers/scsi/sym53c8xx.c     Wed Jul 25 13:37:10 2001
@@ -6991,7 +6991,7 @@
 
 static void ncr_soft_reset(ncb_p np)
 {
-       u_char istat;
+       u_char istat=0;
        int i;
 
        if (!(np->features & FE_ISTAT1) || !(INB (nc_istat1) & SRUN))
8<--------------------------------------------------------------


