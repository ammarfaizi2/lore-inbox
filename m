Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTBXSVF>; Mon, 24 Feb 2003 13:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTBXSUY>; Mon, 24 Feb 2003 13:20:24 -0500
Received: from d06lmsgate-4.uk.ibm.com ([195.212.29.4]:28651 "EHLO
	d06lmsgate-4.uk.ibm.COM") by vger.kernel.org with ESMTP
	id <S267315AbTBXSKQ> convert rfc822-to-8bit; Mon, 24 Feb 2003 13:10:16 -0500
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Organization: IBM Deutschland GmbH
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] s390 (11/13): trivial bug fixes.
Date: Mon, 24 Feb 2003 19:14:02 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200302241914.02987.schwidefsky@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

trivial s390 fixes/typos.

diff -urN linux-2.5.62/arch/s390/kernel/setup.c linux-2.5.62-s390/arch/s390/kernel/setup.c
--- linux-2.5.62/arch/s390/kernel/setup.c	Mon Feb 17 23:55:53 2003
+++ linux-2.5.62-s390/arch/s390/kernel/setup.c	Mon Feb 24 18:24:47 2003
@@ -551,7 +551,7 @@
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos < NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
diff -urN linux-2.5.62/arch/s390x/kernel/setup.c linux-2.5.62-s390/arch/s390x/kernel/setup.c
--- linux-2.5.62/arch/s390x/kernel/setup.c	Mon Feb 17 23:56:12 2003
+++ linux-2.5.62-s390/arch/s390x/kernel/setup.c	Mon Feb 24 18:24:47 2003
@@ -545,7 +545,7 @@
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos <= NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
+	return *pos < NR_CPUS ? (void *)((unsigned long) *pos + 1) : NULL;
 }
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
 {
diff -urN linux-2.5.62/drivers/s390/char/tape.h linux-2.5.62-s390/drivers/s390/char/tape.h
--- linux-2.5.62/drivers/s390/char/tape.h	Mon Feb 17 23:56:25 2003
+++ linux-2.5.62-s390/drivers/s390/char/tape.h	Mon Feb 24 18:24:47 2003
@@ -121,7 +121,7 @@
 /* Function type for magnetic tape commands */
 typedef int (*tape_mtop_fn)(struct tape_device *, int);
 
-/* Size of the arry containing the mtops for a discipline */
+/* Size of the array containing the mtops for a discipline */
 #define TAPE_NR_MTOPS (MTMKPART+1)
 
 /* Tape Discipline */
@@ -151,7 +151,7 @@
  * The discipline irq function either returns an error code (<0) which
  * means that the request has failed with an error or one of the following:
  */
-#define TAPE_IO_SUCCESS 0	/* request sucessful */
+#define TAPE_IO_SUCCESS 0	/* request successful */
 #define TAPE_IO_PENDING 1	/* request still running */
 #define TAPE_IO_RETRY	2	/* retry to current request */
 #define TAPE_IO_STOP	3	/* stop the running request */
diff -urN linux-2.5.62/drivers/s390/char/tape_34xx.c linux-2.5.62-s390/drivers/s390/char/tape_34xx.c
--- linux-2.5.62/drivers/s390/char/tape_34xx.c	Mon Feb 17 23:56:11 2003
+++ linux-2.5.62-s390/drivers/s390/char/tape_34xx.c	Mon Feb 24 18:24:47 2003
@@ -28,7 +28,7 @@
 };
 
 /*
- * Medium sense (asyncronous with callback) for 34xx tapes. There is no 'real'
+ * Medium sense (asynchronous with callback) for 34xx tapes. There is no 'real'
  * medium sense call. So we just do a normal sense.
  */
 static void
@@ -44,7 +44,7 @@
 
 		/*
 		 * This isn't quite correct. But since INTERVENTION_REQUIRED
-		 * means that the drive is 'neither ready nor online' it is
+		 * means that the drive is 'neither ready nor on-line' it is
 		 * only slightly inaccurate to say there is no tape loaded if
 		 * the drive isn't online...
 		 */
@@ -133,7 +133,7 @@
 }
 
 /*
- * Done Handler is called when dev stat = DEVICE-END (successfull operation)
+ * Done Handler is called when dev stat = DEVICE-END (successful operation)
  */
 static int
 tape_34xx_done(struct tape_device *device, struct tape_request *request)
@@ -153,10 +153,10 @@
 }
 
 static inline int
-tape_34xx_erp_succeded(struct tape_device *device,
+tape_34xx_erp_succeeded(struct tape_device *device,
 		       struct tape_request *request)
 {
-	DBF_EVENT(3, "Error Recovery successfull for %s\n",
+	DBF_EVENT(3, "Error Recovery successful for %s\n",
 		  tape_op_verbose[request->op]);
 	return tape_34xx_done(device, request);
 }
@@ -417,13 +417,13 @@
 	case 0x22:
 		/*
 		 * Path equipment check. Might be drive adapter error, buffer
-		 * error on the lower interface, internal path not useable,
+		 * error on the lower interface, internal path not usable,
 		 * or error during cartridge load.
 		 */
 		PRINT_WARN("A path equipment check occurred. One of the "
 			   "following conditions occurred:\n");
 		PRINT_WARN("drive adapter error, buffer error on the lower "
-			   "interface, internal path not useable, error "
+			   "interface, internal path not usable, error "
 			   "during cartridge load.\n");
 		return tape_34xx_erp_failed(device, request, -EIO);
 	case 0x24:
@@ -432,20 +432,20 @@
 		 * but the drive is displaying a drive check message. Can
 		 * be threated as "device end".
 		 */
-		return tape_34xx_erp_succeded(device, request);
+		return tape_34xx_erp_succeeded(device, request);
 	case 0x27:
 		/*
 		 * Command reject. May indicate illegal channel program or
-		 * buffer over/underrun. Since all channel programms are
+		 * buffer over/underrun. Since all channel programs are
 		 * issued by this driver and ought be correct, we assume a
-		 * over/underrun situaltion and retry the channel program.
+		 * over/underrun situation and retry the channel program.
 		 */
 		return tape_34xx_erp_retry(device, request);
 	case 0x29:
 		/*
 		 * Function incompatible. Either the tape is idrc compressed
 		 * but the hardware isn't capable to do idrc, or a perform
-		 * subsystem func is issued and the CU is not online.
+		 * subsystem func is issued and the CU is not on-line.
 		 */
 		PRINT_WARN ("Function incompatible. Try to switch off idrc\n");
 		return tape_34xx_erp_failed(device, request, -EIO);
@@ -463,7 +463,7 @@
 		if (request->op == TO_RUN) {
 			/* Rewind unload completed ok. */
 			tape_med_state_set(device, MS_UNLOADED);
-			return tape_34xx_erp_succeded(device, request);
+			return tape_34xx_erp_succeeded(device, request);
 		}
 		/* tape_34xx doesn't use read buffered log commands. */
 		return tape_34xx_erp_bug(device, request, irb, sense[3]);
@@ -497,7 +497,7 @@
 		return tape_34xx_erp_failed(device, request, -EIO);
 	case 0x33:
 		/*
-		 * Load Failure. The catridge was not inserted correctly or
+		 * Load Failure. The cartridge was not inserted correctly or
 		 * the tape is not threaded correctly.
 		 */
 		PRINT_WARN("Cartridge load failure. Reload the cartridge "
@@ -548,7 +548,7 @@
 			return tape_34xx_erp_failed(device, request, -ENOSPC);
 		return tape_34xx_erp_failed(device, request, -EIO);
 	case 0x39:
-		/* Backward at Beginnig of tape. */
+		/* Backward at Beginning of tape. */
 		return tape_34xx_erp_failed(device, request, -EIO);
 	case 0x3a:
 		/* Drive switched to not ready. */
@@ -562,14 +562,14 @@
 	case 0x42:
 		/*
 		 * Degraded mode. A condition that can cause degraded
-		 * performace is detected.
+		 * performance is detected.
 		 */
 		PRINT_WARN("Subsystem is running in degraded mode.\n");
 		return tape_34xx_erp_retry(device, request);
 	case 0x43:
 		/* Drive not ready. */
 		tape_med_state_set(device, MS_UNLOADED);
-		/* Some commands commands are sucessful even in this case */
+		/* Some commands commands are successful even in this case */
 		if(sense[1] & SENSE_DRIVE_ONLINE) {
 			switch(request->op) {
 				case TO_ASSIGN:
@@ -584,7 +584,7 @@
 		PRINT_WARN("The drive is not ready.\n");
 		return tape_34xx_erp_failed(device, request, -ENOMEDIUM);
 	case 0x44:
-		/* Locate Block unsuccessfull. */
+		/* Locate Block unsuccessful. */
 		if (request->op != TO_BLOCK && request->op != TO_LBL)
 			/* No locate block was issued. */
 			return tape_34xx_erp_bug(device, request,
@@ -596,11 +596,11 @@
 		return tape_34xx_erp_failed(device, request, -EIO);
 	case 0x46:
 		/*
-		 * Drive not online. Drive may be switched offline,
+		 * Drive not on-line. Drive may be switched offline,
 		 * the power supply may be switched off or
 		 * the drive address may not be set correctly.
 		 */
-		PRINT_WARN("The drive is not online.");
+		PRINT_WARN("The drive is not on-line.");
 		return tape_34xx_erp_failed(device, request, -EIO);
 	case 0x47:
 		/* Volume fenced. CU reports volume integrity is lost. */
@@ -645,7 +645,7 @@
 	case 0x4e:
 		if (device->cdev->id.driver_info == tape_3490) {
 			/*
-			 * Maximum block size exeeded. This indicates, that
+			 * Maximum block size exceeded. This indicates, that
 			 * the block to be written is larger than allowed for
 			 * buffered mode.
 			 */
@@ -675,7 +675,7 @@
 		/* End of Volume complete. Rewind unload completed ok. */
 		if (request->op == TO_RUN) {
 			tape_med_state_set(device, MS_UNLOADED);
-			return tape_34xx_erp_succeded(device, request);
+			return tape_34xx_erp_succeeded(device, request);
 		}
 		return tape_34xx_erp_bug(device, request, irb, sense[3]);
 	case 0x53:
@@ -700,7 +700,7 @@
 			return tape_34xx_erp_retry(device, request);
 		} else {
 			/* Global status intercept. */
-			PRINT_WARN("An global status intercept was recieved, "
+			PRINT_WARN("An global status intercept was received, "
 				   "which will be recovered.\n");
 			return tape_34xx_erp_retry(device, request);
 		}
@@ -734,7 +734,7 @@
 	case 0x5e:
 		/* Compaction algorithm incompatible. */
 		PRINT_WARN("The volume is recorded using an incompatible "
-			   "compaction algorith, which is not supported by "
+			   "compaction algorithm, which is not supported by "
 			   "the control unit.\n");
 		return tape_34xx_erp_failed(device, request, -EMEDIUMTYPE);
 
@@ -1042,7 +1042,7 @@
 {
 	int rc;
 
-	DBF_EVENT(3, "34xx init: $Revision: 1.6 $\n");
+	DBF_EVENT(3, "34xx init: $Revision: 1.7 $\n");
 	/* Register driver for 3480/3490 tapes. */
 	rc = ccw_driver_register(&tape_34xx_driver);
 	if (rc)
@@ -1061,7 +1061,7 @@
 MODULE_DEVICE_TABLE(ccw, tape_34xx_ids);
 MODULE_AUTHOR("(C) 2001-2002 IBM Deutschland Entwicklung GmbH");
 MODULE_DESCRIPTION("Linux on zSeries channel attached 3480 tape "
-		   "device driver ($Revision: 1.6 $)");
+		   "device driver ($Revision: 1.7 $)");
 MODULE_LICENSE("GPL");
 
 module_init(tape_34xx_init);
diff -urN linux-2.5.62/drivers/s390/char/tape_core.c linux-2.5.62-s390/drivers/s390/char/tape_core.c
--- linux-2.5.62/drivers/s390/char/tape_core.c	Mon Feb 17 23:56:09 2003
+++ linux-2.5.62-s390/drivers/s390/char/tape_core.c	Mon Feb 24 18:24:47 2003
@@ -904,7 +904,7 @@
 {
 	tape_dbf_area = debug_register ( "tape", 1, 2, 3*sizeof(long));
 	debug_register_view(tape_dbf_area, &debug_sprintf_view);
-	DBF_EVENT(3, "tape init: ($Revision: 1.21 $)\n");
+	DBF_EVENT(3, "tape init: ($Revision: 1.23 $)\n");
 	tape_proc_init();
 	tapechar_init ();
 	tapeblock_init ();
@@ -929,7 +929,7 @@
 MODULE_AUTHOR("(C) 2001 IBM Deutschland Entwicklung GmbH by Carsten Otte and "
 	      "Michael Holzheu (cotte@de.ibm.com,holzheu@de.ibm.com)");
 MODULE_DESCRIPTION("Linux on zSeries channel attached "
-		   "tape device driver ($Revision: 1.21 $)");
+		   "tape device driver ($Revision: 1.23 $)");
 
 module_init(tape_init);
 module_exit(tape_exit);
diff -urN linux-2.5.62/drivers/s390/net/ctcmain.c linux-2.5.62-s390/drivers/s390/net/ctcmain.c
--- linux-2.5.62/drivers/s390/net/ctcmain.c	Mon Feb 24 18:23:59 2003
+++ linux-2.5.62-s390/drivers/s390/net/ctcmain.c	Mon Feb 24 18:24:47 2003
@@ -1,5 +1,5 @@
 /*
- * $Id: ctcmain.c,v 1.35 2003/01/17 13:46:13 cohuck Exp $
+ * $Id: ctcmain.c,v 1.36 2003/02/18 09:15:14 mschwide Exp $
  *
  * CTC / ESCON network driver
  *
@@ -36,7 +36,7 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
- * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.35 $
+ * RELEASE-TAG: CTC/ESCON network driver $Revision: 1.36 $
  *
  */
 
@@ -273,7 +273,7 @@
 print_banner(void)
 {
 	static int printed = 0;
-	char vbuf[] = "$Revision: 1.35 $";
+	char vbuf[] = "$Revision: 1.36 $";
 	char *version = vbuf;
 
 	if (printed)
@@ -1198,7 +1198,7 @@
 		fsm_deltimer(&ch->timer);
 		ccw_check_return_code(ch, rc);
 	}
-	pr_debug(KERN_DEBUG "ctc: %s(): leaving\n", __FUNCTION__);
+	pr_debug("ctc: %s(): leaving\n", __FUNCTION__);
 }
 
 /**
diff -urN linux-2.5.62/drivers/s390/net/lcs.c linux-2.5.62-s390/drivers/s390/net/lcs.c
--- linux-2.5.62/drivers/s390/net/lcs.c	Mon Feb 17 23:55:55 2003
+++ linux-2.5.62-s390/drivers/s390/net/lcs.c	Mon Feb 24 18:24:47 2003
@@ -11,7 +11,7 @@
  *			  Frank Pavlic (pavlic@de.ibm.com) and
  *		 	  Martin Schwidefsky <schwidefsky@de.ibm.com>
  *
- *    $Revision: 1.42 $	 $Date: 2002/12/09 13:55:28 $
+ *    $Revision: 1.44 $	 $Date: 2003/02/18 19:49:02 $
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -59,7 +59,7 @@
 /**
  * initialization string for output
  */
-#define VERSION_LCS_C  "$Revision: 1.42 $"
+#define VERSION_LCS_C  "$Revision: 1.44 $"
 
 static char version[] __initdata = "LCS driver ("VERSION_LCS_C "/" VERSION_LCS_H ")";
 

