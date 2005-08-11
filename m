Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbVHKXnl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbVHKXnl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 19:43:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVHKXnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 19:43:41 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:9611 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751111AbVHKXnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 19:43:40 -0400
From: Grant Coady <Grant.Coady@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Via-Rhine NIC, Via SATA or reiserfs broken, how to tell??
Date: Fri, 12 Aug 2005 09:43:31 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <54nnf1tv8722aq6med3mlr4mvg7nli0r09@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Situation is dataloss with no errors logged.

Test: unpack 2.6.12 tarball from NFS mount source, diff against 
previous attempt:

$ diff -Nrup linux-2.6.12.old linux-2.6.12
Binary files linux-2.6.12.old/include/asm-sparc/a.out.h and linux-2.6.12/include/asm-sparc/a.out.h differ
diff -Nrup linux-2.6.12.old/include/asm-sparc/apc.h linux-2.6.12/include/asm-sparc/apc.h
--- linux-2.6.12.old/include/asm-sparc/apc.h    2005-06-18 05:48:29.000000000 +1000
+++ linux-2.6.12/include/asm-sparc/apc.h        2005-06-18 05:48:29.000000000 +1000
@@ -31,7 +31,7 @@
 #define APC_BPORT_REG  0x30

 #define APC_REGMASK            0x01
-define APC_BPMASK              0x03
+#define APC_BPMASK             0x03

 /*
  * IDLE - CPU standby values (set to initiate standby)
diff -Nrup linux-2.6.12.old/include/asm-sparc/svr4.h linux-2.6.12/include/asm-sparc/svr4.h
--- linux-2.6.12.old/include/asm-sparc/svr4.h   2005-06-18 05:48:29.000000000 +1000
+++ linux-2.6.12/include/asm-sparc/svr4.h       2005-06-18 05:48:29.000000000 +1000
@@ -15,7 +15,7 @@ typedef struct {                /* signa

 /* Values for siginfo.code */
 #define SVR4_SINOINFO 32767
-/* Siginfo, sucker expects bunch of information on those paramEters */
+/* Siginfo, sucker expects bunch of information on those parameters */
 typedef union {
        char total_size [128];
        struct {


Seems like three bit errors for source tree.  Other times I've noted 
compile failures where unpacking source tree fresh would 'fix' error.
I'd previously assumed that I accidentally killed source tree with 
'cp -al ...' copies but I've had a segfault on that operation, hence 
I do not know if this be NIC or filesystem (reiserfs on via SATA).


Today disabled onboard via-rhine and used Intel pro/100 + e100 driver, 
several source trees unpacked identically, running 2.6.12.4 or 2.4.31-hf3

The fault occurs on 2.4 latest or 2.6 latest only on particular target 
box, so problem is not the NFS server.

How to test and isolate this error is in NIC driver, SATA driver or 
filesystem?  

Thanks,
Grant.

