Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262358AbSJWAjF>; Tue, 22 Oct 2002 20:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262360AbSJWAjE>; Tue, 22 Oct 2002 20:39:04 -0400
Received: from nycsmtp3out.rdc-nyc.rr.com ([24.29.99.228]:12729 "EHLO
	nycsmtp3out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S262358AbSJWAi6>; Tue, 22 Oct 2002 20:38:58 -0400
Date: Tue, 22 Oct 2002 20:37:27 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com, <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] 2.5.44-ac1 : drivers/scsi/53c700.c
Message-ID: <Pine.LNX.4.44.0210222035560.913-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch removes an outdated macro STATIC.
Regards,
Frank

--- linux/drivers/scsi/53c700.c.old	Sat Oct 19 12:05:38 2002
+++ linux/drivers/scsi/53c700.c	Tue Oct 22 19:26:58 2002
@@ -148,12 +148,6 @@
  * complaining */
 #define to32bit(x)	((__u32)((unsigned long)(x)))
 
-#ifdef NCR_700_DEBUG
-#define STATIC
-#else
-#define STATIC static
-#endif
-
 MODULE_AUTHOR("James Bottomley");
 MODULE_DESCRIPTION("53c700 and 53c700-66 Driver");
 MODULE_LICENSE("GPL");
@@ -162,16 +156,16 @@
 #include "53c700_d.h"
 
 
-STATIC int NCR_700_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
-STATIC int NCR_700_abort(Scsi_Cmnd * SCpnt);
-STATIC int NCR_700_bus_reset(Scsi_Cmnd * SCpnt);
-STATIC int NCR_700_dev_reset(Scsi_Cmnd * SCpnt);
-STATIC int NCR_700_host_reset(Scsi_Cmnd * SCpnt);
-STATIC int NCR_700_proc_directory_info(char *, char **, off_t, int, int, int);
-STATIC void NCR_700_chip_setup(struct Scsi_Host *host);
-STATIC void NCR_700_chip_reset(struct Scsi_Host *host);
-STATIC int NCR_700_slave_attach(Scsi_Device *SDpnt);
-STATIC void NCR_700_slave_detach(Scsi_Device *SDpnt);
+static int NCR_700_queuecommand(Scsi_Cmnd *, void (*done)(Scsi_Cmnd *));
+static int NCR_700_abort(Scsi_Cmnd * SCpnt);
+static int NCR_700_bus_reset(Scsi_Cmnd * SCpnt);
+static int NCR_700_dev_reset(Scsi_Cmnd * SCpnt);
+static int NCR_700_host_reset(Scsi_Cmnd * SCpnt);
+static int NCR_700_proc_directory_info(char *, char **, off_t, int, int, int);
+static void NCR_700_chip_setup(struct Scsi_Host *host);
+static void NCR_700_chip_reset(struct Scsi_Host *host);
+static int NCR_700_slave_attach(Scsi_Device *SDpnt);
+static void NCR_700_slave_detach(Scsi_Device *SDpnt);
 
 static char *NCR_700_phase[] = {
 	"",
@@ -469,7 +463,7 @@
 }
 
 /* Pull a slot off the free list */
-STATIC struct NCR_700_command_slot *
+static struct NCR_700_command_slot *
 find_empty_slot(struct NCR_700_Host_Parameters *hostdata)
 {
 	struct NCR_700_command_slot *slot = hostdata->free_list;
@@ -500,7 +494,7 @@
 	return slot;
 }
 
-STATIC void 
+static void 
 free_slot(struct NCR_700_command_slot *slot,
 	  struct NCR_700_Host_Parameters *hostdata)
 {
@@ -522,7 +516,7 @@
 
 /* This routine really does very little.  The command is indexed on
    the ITL and (if tagged) the ITLQ lists in _queuecommand */
-STATIC void
+static void
 save_for_reselection(struct NCR_700_Host_Parameters *hostdata,
 		     Scsi_Cmnd *SCp, __u32 dsp)
 {
@@ -542,7 +536,7 @@
  *
  * NOTE: According to SCSI-2, the true transfer period (in ns) is
  *       actually four times this period value */
-STATIC inline __u8
+static inline __u8
 NCR_700_offset_period_to_sxfer(struct NCR_700_Host_Parameters *hostdata,
 			       __u8 offset, __u8 period)
 {
@@ -571,7 +565,7 @@
 	return (offset & 0x0f) | (XFERP & 0x07)<<4;
 }
 
-STATIC inline void
+static inline void
 NCR_700_unmap(struct NCR_700_Host_Parameters *hostdata, Scsi_Cmnd *SCp,
 	      struct NCR_700_command_slot *slot)
 {
@@ -590,7 +584,7 @@
 	}
 }
 
-STATIC inline void
+static inline void
 NCR_700_scsi_done(struct NCR_700_Host_Parameters *hostdata,
 	       Scsi_Cmnd *SCp, int result)
 {
@@ -644,7 +638,7 @@
 }
 
 
-STATIC void
+static void
 NCR_700_internal_bus_reset(struct Scsi_Host *host)
 {
 	/* Bus reset */
@@ -654,7 +648,7 @@
 
 }
 
-STATIC void
+static void
 NCR_700_chip_setup(struct Scsi_Host *host)
 {
 	struct NCR_700_Host_Parameters *hostdata = 
@@ -748,7 +742,7 @@
 		NCR_700_SDTR_msg[4] = NCR_710_MAX_OFFSET;
 }
 
-STATIC void
+static void
 NCR_700_chip_reset(struct Scsi_Host *host)
 {
 	struct NCR_700_Host_Parameters *hostdata = 
@@ -776,7 +770,7 @@
  * scripts and set temp to be the normal case + 8 (skipping the CLEAR
  * ACK) so that the routine returns correctly to resume its activity
  * */
-STATIC __u32
+static __u32
 process_extended_message(struct Scsi_Host *host, 
 			 struct NCR_700_Host_Parameters *hostdata,
 			 Scsi_Cmnd *SCp, __u32 dsp, __u32 dsps)
@@ -857,7 +851,7 @@
 	return resume_offset;
 }
 
-STATIC __u32
+static __u32
 process_message(struct Scsi_Host *host,	struct NCR_700_Host_Parameters *hostdata,
 		Scsi_Cmnd *SCp, __u32 dsp, __u32 dsps)
 {
@@ -939,7 +933,7 @@
 	return resume_offset;
 }
 
-STATIC __u32
+static __u32
 process_script_interrupt(__u32 dsps, __u32 dsp, Scsi_Cmnd *SCp,
 			 struct Scsi_Host *host,
 			 struct NCR_700_Host_Parameters *hostdata)
@@ -1258,7 +1252,7 @@
  * to find out what the scripts engine is doing and complete the
  * function if necessary (i.e. process the pending disconnect or save
  * the interrupted initial selection */
-STATIC inline __u32
+static inline __u32
 process_selection(struct Scsi_Host *host, __u32 dsp)
 {
 	__u8 id = 0;	/* Squash compiler warning */
@@ -1367,7 +1361,7 @@
 
 /* The queue lock with interrupts disabled must be held on entry to
  * this function */
-STATIC int
+static int
 NCR_700_start_command(Scsi_Cmnd *SCp)
 {
 	struct NCR_700_command_slot *slot =
@@ -1716,7 +1710,7 @@
 
 /* FIXME: Need to put some proc information in and plumb it
  * into the scsi proc system */
-STATIC int
+static int
 NCR_700_proc_directory_info(char *proc_buf, char **startp,
 			 off_t offset, int bytes_available,
 			 int host_no, int write)
@@ -1751,7 +1745,7 @@
 	return len;
 }
 
-STATIC int
+static int
 NCR_700_queuecommand(Scsi_Cmnd *SCp, void (*done)(Scsi_Cmnd *))
 {
 	struct NCR_700_Host_Parameters *hostdata = 
@@ -1936,7 +1930,7 @@
 	return 0;
 }
 
-STATIC int
+static int
 NCR_700_abort(Scsi_Cmnd * SCp)
 {
 	struct NCR_700_command_slot *slot;
@@ -1968,7 +1962,7 @@
 
 }
 
-STATIC int
+static int
 NCR_700_bus_reset(Scsi_Cmnd * SCp)
 {
 	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants BUS reset, cmd %p\n\t",
@@ -1978,7 +1972,7 @@
 	return SUCCESS;
 }
 
-STATIC int
+static int
 NCR_700_dev_reset(Scsi_Cmnd * SCp)
 {
 	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants device reset\n\t",
@@ -1988,7 +1982,7 @@
 	return FAILED;
 }
 
-STATIC int
+static int
 NCR_700_host_reset(Scsi_Cmnd * SCp)
 {
 	printk(KERN_INFO "scsi%d (%d:%d) New error handler wants HOST reset\n\t",
@@ -2000,7 +1994,7 @@
 	return SUCCESS;
 }
 
-STATIC int
+static int
 NCR_700_slave_attach(Scsi_Device *SDp)
 {
 	/* to do here: allocate memory; build a queue_full list */
@@ -2013,7 +2007,7 @@
 	return 0;
 }
 
-STATIC void
+static void
 NCR_700_slave_detach(Scsi_Device *SDp)
 {
 	/* to do here: deallocate memory */

