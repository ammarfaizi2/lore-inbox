Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318731AbSICOsB>; Tue, 3 Sep 2002 10:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318782AbSICOsA>; Tue, 3 Sep 2002 10:48:00 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:61700
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318731AbSICOr6>; Tue, 3 Sep 2002 10:47:58 -0400
Subject: [PATCH] flag type cleanup
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Sep 2002 10:52:26 -0400
Message-Id: <1031064747.978.3203.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch fixes various instances of the interrupt flag variable
not being the proper `unsigned long'.

Most notably, kernel/softirq.c ...

Patch is against 2.5.33-BK, please apply.

	Robert Love

diff -urN linux-2.5.33/drivers/cdrom/sbpcd.c linux/drivers/cdrom/sbpcd.c
--- linux-2.5.33/drivers/cdrom/sbpcd.c	Sat Aug 31 18:04:51 2002
+++ linux/drivers/cdrom/sbpcd.c	Tue Sep  3 10:38:59 2002
@@ -1307,7 +1307,7 @@
 	
 	static int cc_DriveReset(void);
 	int i, j, l=0, m, ntries;
-	long flags;
+	unsigned long flags;
 
 	D_S[d].error_state=0;
 	D_S[d].b3=0;
diff -urN linux-2.5.33/drivers/scsi/sym53c8xx.c linux/drivers/scsi/sym53c8xx.c
--- linux-2.5.33/drivers/scsi/sym53c8xx.c	Sat Aug 31 18:04:49 2002
+++ linux/drivers/scsi/sym53c8xx.c	Tue Sep  3 10:33:06 2002
@@ -14115,7 +14115,7 @@
 	if (len)
 		return -EINVAL;
 	else {
-		long flags;
+		unsigned long flags;
 
 		NCR_LOCK_NCB(np, flags);
 		ncr_usercmd (np);
diff -urN linux-2.5.33/drivers/scsi/sym53c8xx_2/sym_glue.c linux/drivers/scsi/sym53c8xx_2/sym_glue.c
--- linux-2.5.33/drivers/scsi/sym53c8xx_2/sym_glue.c	Sat Aug 31 18:05:23 2002
+++ linux/drivers/scsi/sym53c8xx_2/sym_glue.c	Tue Sep  3 10:33:25 2002
@@ -1686,7 +1686,7 @@
 	if (len)
 		return -EINVAL;
 	else {
-		long flags;
+		unsigned long flags;
 
 		SYM_LOCK_HCB(np, flags);
 		sym_exec_user_command (np, uc);
diff -urN linux-2.5.33/fs/intermezzo/kml_utils.c linux/fs/intermezzo/kml_utils.c
--- linux-2.5.33/fs/intermezzo/kml_utils.c	Sat Aug 31 18:05:27 2002
+++ linux/fs/intermezzo/kml_utils.c	Tue Sep  3 10:39:54 2002
@@ -25,7 +25,7 @@
         va_list args;
         int  i;
         char *path;
-        long flags;
+        unsigned long flags;
 
         spin_lock_irqsave(&kml_lock, flags);
         va_start(args, format);
diff -urN linux-2.5.33/kernel/softirq.c linux/kernel/softirq.c
--- linux-2.5.33/kernel/softirq.c	Sat Aug 31 18:04:52 2002
+++ linux/kernel/softirq.c	Tue Sep  3 10:31:14 2002
@@ -59,7 +59,7 @@
 asmlinkage void do_softirq()
 {
 	__u32 pending;
-	long flags;
+	unsigned long flags;
 	__u32 mask;
 	int cpu;
 
@@ -129,7 +129,7 @@
 
 void raise_softirq(unsigned int nr)
 {
-	long flags;
+	unsigned long flags;
 
 	local_irq_save(flags);
 	cpu_raise_softirq(smp_processor_id(), nr);



