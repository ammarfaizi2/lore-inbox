Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWFNOEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWFNOEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWFNOEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:04:01 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:16174 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S964961AbWFNOD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:03:58 -0400
Date: Wed, 14 Jun 2006 16:03:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, horst.hummel@de.ibm.com
Subject: [patch 15/24] s390: dasd whitespace and other cosmetics.
Message-ID: <20060614140358.GP9475@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[S390] dasd whitespace and other cosmetics.

Dasd code cleanup: 1) remove white space, 2) remove the emacs override
sections, and 3) use kzalloc instead of kmalloc.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/block/dasd.c          |   54 +++-------
 drivers/s390/block/dasd_3370_erp.c |   27 -----
 drivers/s390/block/dasd_3990_erp.c |  189 ++++++++++++++++---------------------
 drivers/s390/block/dasd_9336_erp.c |   27 -----
 drivers/s390/block/dasd_9343_erp.c |    2 
 drivers/s390/block/dasd_devmap.c   |   22 ++--
 drivers/s390/block/dasd_diag.c     |    6 -
 drivers/s390/block/dasd_diag.h     |    2 
 drivers/s390/block/dasd_eckd.c     |   52 +++-------
 drivers/s390/block/dasd_eckd.h     |    8 -
 drivers/s390/block/dasd_erp.c      |    8 -
 drivers/s390/block/dasd_fba.c      |   29 -----
 drivers/s390/block/dasd_fba.h      |    2 
 drivers/s390/block/dasd_int.h      |   37 +------
 drivers/s390/block/dasd_ioctl.c    |   12 +-
 15 files changed, 173 insertions(+), 304 deletions(-)

diff -urpN linux-2.6/drivers/s390/block/dasd_3370_erp.c linux-2.6-patched/drivers/s390/block/dasd_3370_erp.c
--- linux-2.6/drivers/s390/block/dasd_3370_erp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_3370_erp.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_3370_erp.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
@@ -12,10 +12,10 @@
 
 
 /*
- * DASD_3370_ERP_EXAMINE 
+ * DASD_3370_ERP_EXAMINE
  *
  * DESCRIPTION
- *   Checks only for fatal/no/recover error. 
+ *   Checks only for fatal/no/recover error.
  *   A detailed examination of the sense data is done later outside
  *   the interrupt handler.
  *
@@ -23,7 +23,7 @@
  *   'Chapter 7. 3370 Sense Data'.
  *
  * RETURN VALUES
- *   dasd_era_none	no error 
+ *   dasd_era_none	no error
  *   dasd_era_fatal	for all fatal (unrecoverable errors)
  *   dasd_era_recover	for all others.
  */
@@ -82,22 +82,3 @@ dasd_3370_erp_examine(struct dasd_ccw_re
 	return dasd_era_recover;
 
 }				/* END dasd_3370_erp_examine */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_3990_erp.c linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c
--- linux-2.6/drivers/s390/block/dasd_3990_erp.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_3990_erp.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,6 +1,6 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_3990_erp.c
- * Author(s)......: Horst  Hummel    <Horst.Hummel@de.ibm.com> 
+ * Author(s)......: Horst  Hummel    <Horst.Hummel@de.ibm.com>
  *		    Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 2000, 2001
@@ -25,23 +25,23 @@ struct DCTL_data {
 } __attribute__ ((packed));
 
 /*
- ***************************************************************************** 
+ *****************************************************************************
  * SECTION ERP EXAMINATION
- ***************************************************************************** 
+ *****************************************************************************
  */
 
 /*
- * DASD_3990_ERP_EXAMINE_24 
+ * DASD_3990_ERP_EXAMINE_24
  *
  * DESCRIPTION
- *   Checks only for fatal (unrecoverable) error. 
+ *   Checks only for fatal (unrecoverable) error.
  *   A detailed examination of the sense data is done later outside
  *   the interrupt handler.
  *
  *   Each bit configuration leading to an action code 2 (Exit with
  *   programming error or unusual condition indication)
  *   are handled as fatal error´s.
- * 
+ *
  *   All other configurations are handled as recoverable errors.
  *
  * RETURN VALUES
@@ -93,15 +93,15 @@ dasd_3990_erp_examine_24(struct dasd_ccw
 }				/* END dasd_3990_erp_examine_24 */
 
 /*
- * DASD_3990_ERP_EXAMINE_32 
+ * DASD_3990_ERP_EXAMINE_32
  *
  * DESCRIPTION
- *   Checks only for fatal/no/recoverable error. 
+ *   Checks only for fatal/no/recoverable error.
  *   A detailed examination of the sense data is done later outside
  *   the interrupt handler.
  *
  * RETURN VALUES
- *   dasd_era_none	no error 
+ *   dasd_era_none	no error
  *   dasd_era_fatal	for all fatal (unrecoverable errors)
  *   dasd_era_recover	for recoverable others.
  */
@@ -128,10 +128,10 @@ dasd_3990_erp_examine_32(struct dasd_ccw
 }				/* end dasd_3990_erp_examine_32 */
 
 /*
- * DASD_3990_ERP_EXAMINE 
+ * DASD_3990_ERP_EXAMINE
  *
  * DESCRIPTION
- *   Checks only for fatal/no/recover error. 
+ *   Checks only for fatal/no/recover error.
  *   A detailed examination of the sense data is done later outside
  *   the interrupt handler.
  *
@@ -139,7 +139,7 @@ dasd_3990_erp_examine_32(struct dasd_ccw
  *   'Chapter 7. Error Recovery Procedures'.
  *
  * RETURN VALUES
- *   dasd_era_none	no error 
+ *   dasd_era_none	no error
  *   dasd_era_fatal	for all fatal (unrecoverable errors)
  *   dasd_era_recover	for all others.
  */
@@ -178,18 +178,18 @@ dasd_3990_erp_examine(struct dasd_ccw_re
 }				/* END dasd_3990_erp_examine */
 
 /*
- ***************************************************************************** 
+ *****************************************************************************
  * SECTION ERP HANDLING
- ***************************************************************************** 
+ *****************************************************************************
  */
 /*
- ***************************************************************************** 
+ *****************************************************************************
  * 24 and 32 byte sense ERP functions
- ***************************************************************************** 
+ *****************************************************************************
  */
 
 /*
- * DASD_3990_ERP_CLEANUP 
+ * DASD_3990_ERP_CLEANUP
  *
  * DESCRIPTION
  *   Removes the already build but not necessary ERP request and sets
@@ -197,10 +197,10 @@ dasd_3990_erp_examine(struct dasd_ccw_re
  *
  *  PARAMETER
  *   erp		request to be blocked
- *   final_status	either DASD_CQR_DONE or DASD_CQR_FAILED 
+ *   final_status	either DASD_CQR_DONE or DASD_CQR_FAILED
  *
  * RETURN VALUES
- *   cqr		original cqr		   
+ *   cqr		original cqr
  */
 static struct dasd_ccw_req *
 dasd_3990_erp_cleanup(struct dasd_ccw_req * erp, char final_status)
@@ -214,7 +214,7 @@ dasd_3990_erp_cleanup(struct dasd_ccw_re
 }				/* end dasd_3990_erp_cleanup */
 
 /*
- * DASD_3990_ERP_BLOCK_QUEUE 
+ * DASD_3990_ERP_BLOCK_QUEUE
  *
  * DESCRIPTION
  *   Block the given device request queue to prevent from further
@@ -237,7 +237,7 @@ dasd_3990_erp_block_queue(struct dasd_cc
 }
 
 /*
- * DASD_3990_ERP_INT_REQ 
+ * DASD_3990_ERP_INT_REQ
  *
  * DESCRIPTION
  *   Handles 'Intervention Required' error.
@@ -277,7 +277,7 @@ dasd_3990_erp_int_req(struct dasd_ccw_re
 }				/* end dasd_3990_erp_int_req */
 
 /*
- * DASD_3990_ERP_ALTERNATE_PATH 
+ * DASD_3990_ERP_ALTERNATE_PATH
  *
  * DESCRIPTION
  *   Repeat the operation on a different channel path.
@@ -330,15 +330,15 @@ dasd_3990_erp_alternate_path(struct dasd
  * DASD_3990_ERP_DCTL
  *
  * DESCRIPTION
- *   Setup cqr to do the Diagnostic Control (DCTL) command with an 
+ *   Setup cqr to do the Diagnostic Control (DCTL) command with an
  *   Inhibit Write subcommand (0x20) and the given modifier.
  *
  *  PARAMETER
  *   erp		pointer to the current (failed) ERP
  *   modifier		subcommand modifier
- *   
+ *
  * RETURN VALUES
- *   dctl_cqr		pointer to NEW dctl_cqr 
+ *   dctl_cqr		pointer to NEW dctl_cqr
  *
  */
 static struct dasd_ccw_req *
@@ -386,7 +386,7 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req *
 }				/* end dasd_3990_erp_DCTL */
 
 /*
- * DASD_3990_ERP_ACTION_1 
+ * DASD_3990_ERP_ACTION_1
  *
  * DESCRIPTION
  *   Setup ERP to do the ERP action 1 (see Reference manual).
@@ -415,7 +415,7 @@ dasd_3990_erp_action_1(struct dasd_ccw_r
 }				/* end dasd_3990_erp_action_1 */
 
 /*
- * DASD_3990_ERP_ACTION_4 
+ * DASD_3990_ERP_ACTION_4
  *
  * DESCRIPTION
  *   Setup ERP to do the ERP action 4 (see Reference manual).
@@ -453,11 +453,11 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 
 		if (sense[25] == 0x1D) {	/* state change pending */
 
-			DEV_MESSAGE(KERN_INFO, device, 
+			DEV_MESSAGE(KERN_INFO, device,
 				    "waiting for state change pending "
 				    "interrupt, %d retries left",
 				    erp->retries);
-			
+
 			dasd_3990_erp_block_queue(erp, 30*HZ);
 
                 } else if (sense[25] == 0x1E) {	/* busy */
@@ -469,9 +469,9 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 		} else {
 
 			/* no state change pending - retry */
-			DEV_MESSAGE (KERN_INFO, device, 
+			DEV_MESSAGE (KERN_INFO, device,
 				     "redriving request immediately, "
-				     "%d retries left", 
+				     "%d retries left",
 				     erp->retries);
 			erp->status = DASD_CQR_QUEUED;
 		}
@@ -482,13 +482,13 @@ dasd_3990_erp_action_4(struct dasd_ccw_r
 }				/* end dasd_3990_erp_action_4 */
 
 /*
- ***************************************************************************** 
+ *****************************************************************************
  * 24 byte sense ERP functions (only)
- ***************************************************************************** 
+ *****************************************************************************
  */
 
 /*
- * DASD_3990_ERP_ACTION_5 
+ * DASD_3990_ERP_ACTION_5
  *
  * DESCRIPTION
  *   Setup ERP to do the ERP action 5 (see Reference manual).
@@ -523,7 +523,7 @@ dasd_3990_erp_action_5(struct dasd_ccw_r
  *
  * PARAMETER
  *   sense		current sense data
- *   
+ *
  * RETURN VALUES
  *   void
  */
@@ -1150,9 +1150,9 @@ dasd_3990_handle_env_data(struct dasd_cc
  * PARAMETER
  *   erp		current erp_head
  *   sense		current sense data
- * 
+ *
  * RETURN VALUES
- *   erp		'new' erp_head - pointer to new ERP 
+ *   erp		'new' erp_head - pointer to new ERP
  */
 static struct dasd_ccw_req *
 dasd_3990_erp_com_rej(struct dasd_ccw_req * erp, char *sense)
@@ -1185,7 +1185,7 @@ dasd_3990_erp_com_rej(struct dasd_ccw_re
 }				/* end dasd_3990_erp_com_rej */
 
 /*
- * DASD_3990_ERP_BUS_OUT 
+ * DASD_3990_ERP_BUS_OUT
  *
  * DESCRIPTION
  *   Handles 24 byte 'Bus Out Parity Check' error.
@@ -1483,7 +1483,7 @@ dasd_3990_erp_env_data(struct dasd_ccw_r
  *
  * PARAMETER
  *   erp		already added default ERP
- *		
+ *
  * RETURN VALUES
  *   erp		new erp_head - pointer to new ERP
  */
@@ -1527,11 +1527,11 @@ dasd_3990_erp_file_prot(struct dasd_ccw_
 }				/* end dasd_3990_erp_file_prot */
 
 /*
- * DASD_3990_ERP_INSPECT_24 
+ * DASD_3990_ERP_INSPECT_24
  *
  * DESCRIPTION
  *   Does a detailed inspection of the 24 byte sense data
- *   and sets up a related error recovery action.  
+ *   and sets up a related error recovery action.
  *
  * PARAMETER
  *   sense		sense data of the actual error
@@ -1602,13 +1602,13 @@ dasd_3990_erp_inspect_24(struct dasd_ccw
 }				/* END dasd_3990_erp_inspect_24 */
 
 /*
- ***************************************************************************** 
+ *****************************************************************************
  * 32 byte sense ERP functions (only)
- ***************************************************************************** 
+ *****************************************************************************
  */
 
 /*
- * DASD_3990_ERPACTION_10_32 
+ * DASD_3990_ERPACTION_10_32
  *
  * DESCRIPTION
  *   Handles 32 byte 'Action 10' of Single Program Action Codes.
@@ -1616,7 +1616,7 @@ dasd_3990_erp_inspect_24(struct dasd_ccw
  *
  * PARAMETER
  *   erp		current erp_head
- *   sense		current sense data 
+ *   sense		current sense data
  * RETURN VALUES
  *   erp		modified erp_head
  */
@@ -1640,18 +1640,18 @@ dasd_3990_erp_action_10_32(struct dasd_c
  *
  * DESCRIPTION
  *   Handles 32 byte 'Action 1B' of Single Program Action Codes.
- *   A write operation could not be finished because of an unexpected 
+ *   A write operation could not be finished because of an unexpected
  *   condition.
- *   The already created 'default erp' is used to get the link to 
- *   the erp chain, but it can not be used for this recovery 
+ *   The already created 'default erp' is used to get the link to
+ *   the erp chain, but it can not be used for this recovery
  *   action because it contains no DE/LO data space.
  *
  * PARAMETER
  *   default_erp	already added default erp.
- *   sense		current sense data 
+ *   sense		current sense data
  *
  * RETURN VALUES
- *   erp		new erp or 
+ *   erp		new erp or
  *			default_erp in case of imprecise ending or error
  */
 static struct dasd_ccw_req *
@@ -1789,16 +1789,16 @@ dasd_3990_erp_action_1B_32(struct dasd_c
  * DASD_3990_UPDATE_1B
  *
  * DESCRIPTION
- *   Handles the update to the 32 byte 'Action 1B' of Single Program 
+ *   Handles the update to the 32 byte 'Action 1B' of Single Program
  *   Action Codes in case the first action was not successful.
  *   The already created 'previous_erp' is the currently not successful
- *   ERP. 
+ *   ERP.
  *
  * PARAMETER
  *   previous_erp	already created previous erp.
- *   sense		current sense data 
+ *   sense		current sense data
  * RETURN VALUES
- *   erp		modified erp 
+ *   erp		modified erp
  */
 static struct dasd_ccw_req *
 dasd_3990_update_1B(struct dasd_ccw_req * previous_erp, char *sense)
@@ -1897,7 +1897,7 @@ dasd_3990_update_1B(struct dasd_ccw_req 
 }				/* end dasd_3990_update_1B */
 
 /*
- * DASD_3990_ERP_COMPOUND_RETRY 
+ * DASD_3990_ERP_COMPOUND_RETRY
  *
  * DESCRIPTION
  *   Handles the compound ERP action retry code.
@@ -1943,7 +1943,7 @@ dasd_3990_erp_compound_retry(struct dasd
 }				/* end dasd_3990_erp_compound_retry */
 
 /*
- * DASD_3990_ERP_COMPOUND_PATH 
+ * DASD_3990_ERP_COMPOUND_PATH
  *
  * DESCRIPTION
  *   Handles the compound ERP action for retry on alternate
@@ -1965,7 +1965,7 @@ dasd_3990_erp_compound_path(struct dasd_
 		dasd_3990_erp_alternate_path(erp);
 
 		if (erp->status == DASD_CQR_FAILED) {
-			/* reset the lpm and the status to be able to 
+			/* reset the lpm and the status to be able to
 			 * try further actions. */
 
 			erp->lpm = 0;
@@ -1980,7 +1980,7 @@ dasd_3990_erp_compound_path(struct dasd_
 }				/* end dasd_3990_erp_compound_path */
 
 /*
- * DASD_3990_ERP_COMPOUND_CODE 
+ * DASD_3990_ERP_COMPOUND_CODE
  *
  * DESCRIPTION
  *   Handles the compound ERP action for retry code.
@@ -2001,18 +2001,18 @@ dasd_3990_erp_compound_code(struct dasd_
 
 		switch (sense[28]) {
 		case 0x17:
-			/* issue a Diagnostic Control command with an 
+			/* issue a Diagnostic Control command with an
 			 * Inhibit Write subcommand and controler modifier */
 			erp = dasd_3990_erp_DCTL(erp, 0x20);
 			break;
-			
+
 		case 0x25:
 			/* wait for 5 seconds and retry again */
 			erp->retries = 1;
-			
+
 			dasd_3990_erp_block_queue (erp, 5*HZ);
 			break;
-			
+
 		default:
 			/* should not happen - continue */
 			break;
@@ -2026,7 +2026,7 @@ dasd_3990_erp_compound_code(struct dasd_
 }				/* end dasd_3990_erp_compound_code */
 
 /*
- * DASD_3990_ERP_COMPOUND_CONFIG 
+ * DASD_3990_ERP_COMPOUND_CONFIG
  *
  * DESCRIPTION
  *   Handles the compound ERP action for configruation
@@ -2063,10 +2063,10 @@ dasd_3990_erp_compound_config(struct das
 }				/* end dasd_3990_erp_compound_config */
 
 /*
- * DASD_3990_ERP_COMPOUND 
+ * DASD_3990_ERP_COMPOUND
  *
  * DESCRIPTION
- *   Does the further compound program action if 
+ *   Does the further compound program action if
  *   compound retry was not successful.
  *
  * PARAMETER
@@ -2110,11 +2110,11 @@ dasd_3990_erp_compound(struct dasd_ccw_r
 }				/* end dasd_3990_erp_compound */
 
 /*
- * DASD_3990_ERP_INSPECT_32 
+ * DASD_3990_ERP_INSPECT_32
  *
  * DESCRIPTION
  *   Does a detailed inspection of the 32 byte sense data
- *   and sets up a related error recovery action.  
+ *   and sets up a related error recovery action.
  *
  * PARAMETER
  *   sense		sense data of the actual error
@@ -2228,9 +2228,9 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
 }				/* end dasd_3990_erp_inspect_32 */
 
 /*
- ***************************************************************************** 
+ *****************************************************************************
  * main ERP control fuctions (24 and 32 byte sense)
- ***************************************************************************** 
+ *****************************************************************************
  */
 
 /*
@@ -2243,7 +2243,7 @@ dasd_3990_erp_inspect_32(struct dasd_ccw
  * PARAMETER
  *   erp		pointer to the currently created default ERP
  * RETURN VALUES
- *   erp_new		contens was possibly modified 
+ *   erp_new		contens was possibly modified
  */
 static struct dasd_ccw_req *
 dasd_3990_erp_inspect(struct dasd_ccw_req * erp)
@@ -2272,14 +2272,14 @@ dasd_3990_erp_inspect(struct dasd_ccw_re
 
 /*
  * DASD_3990_ERP_ADD_ERP
- * 
+ *
  * DESCRIPTION
  *   This funtion adds an additional request block (ERP) to the head of
  *   the given cqr (or erp).
  *   This erp is initialized as an default erp (retry TIC)
  *
  * PARAMETER
- *   cqr		head of the current ERP-chain (or single cqr if 
+ *   cqr		head of the current ERP-chain (or single cqr if
  *			first error)
  * RETURN VALUES
  *   erp		pointer to new ERP-chain head
@@ -2332,15 +2332,15 @@ dasd_3990_erp_add_erp(struct dasd_ccw_re
 }
 
 /*
- * DASD_3990_ERP_ADDITIONAL_ERP 
- * 
+ * DASD_3990_ERP_ADDITIONAL_ERP
+ *
  * DESCRIPTION
  *   An additional ERP is needed to handle the current error.
  *   Add ERP to the head of the ERP-chain containing the ERP processing
  *   determined based on the sense data.
  *
  * PARAMETER
- *   cqr		head of the current ERP-chain (or single cqr if 
+ *   cqr		head of the current ERP-chain (or single cqr if
  *			first error)
  *
  * RETURN VALUES
@@ -2376,7 +2376,7 @@ dasd_3990_erp_additional_erp(struct dasd
  *   24 byte sense byte 25 and 27 is set as well.
  *
  * PARAMETER
- *   cqr1		first cqr, which will be compared with the 
+ *   cqr1		first cqr, which will be compared with the
  *   cqr2		second cqr.
  *
  * RETURN VALUES
@@ -2415,7 +2415,7 @@ dasd_3990_erp_error_match(struct dasd_cc
  *   cqr		failed cqr (either original cqr or already an erp)
  *
  * RETURN VALUES
- *   erp		erp-pointer to the already defined error 
+ *   erp		erp-pointer to the already defined error
  *			recovery procedure OR
  *			NULL if a 'new' error occurred.
  */
@@ -2451,10 +2451,10 @@ dasd_3990_erp_in_erp(struct dasd_ccw_req
  * DASD_3990_ERP_FURTHER_ERP (24 & 32 byte sense)
  *
  * DESCRIPTION
- *   No retry is left for the current ERP. Check what has to be done 
+ *   No retry is left for the current ERP. Check what has to be done
  *   with the ERP.
  *     - do further defined ERP action or
- *     - wait for interrupt or	
+ *     - wait for interrupt or
  *     - exit with permanent error
  *
  * PARAMETER
@@ -2485,7 +2485,7 @@ dasd_3990_erp_further_erp(struct dasd_cc
 
 		if (!(sense[2] & DASD_SENSE_BIT_0)) {
 
-			/* issue a Diagnostic Control command with an 
+			/* issue a Diagnostic Control command with an
 			 * Inhibit Write subcommand */
 
 			switch (sense[25]) {
@@ -2535,14 +2535,14 @@ dasd_3990_erp_further_erp(struct dasd_cc
 }				/* end dasd_3990_erp_further_erp */
 
 /*
- * DASD_3990_ERP_HANDLE_MATCH_ERP 
+ * DASD_3990_ERP_HANDLE_MATCH_ERP
  *
  * DESCRIPTION
  *   An error occurred again and an ERP has been detected which is already
- *   used to handle this error (e.g. retries). 
+ *   used to handle this error (e.g. retries).
  *   All prior ERP's are asumed to be successful and therefore removed
  *   from queue.
- *   If retry counter of matching erp is already 0, it is checked if further 
+ *   If retry counter of matching erp is already 0, it is checked if further
  *   action is needed (besides retry) or if the ERP has failed.
  *
  * PARAMETER
@@ -2631,7 +2631,7 @@ dasd_3990_erp_handle_match_erp(struct da
  *   erp		erp-pointer to the head of the ERP action chain.
  *			This means:
  *			 - either a ptr to an additional ERP cqr or
- *			 - the original given cqr (which's status might 
+ *			 - the original given cqr (which's status might
  *			   be modified)
  */
 struct dasd_ccw_req *
@@ -2723,22 +2723,3 @@ dasd_3990_erp_action(struct dasd_ccw_req
 	return erp;
 
 }				/* end dasd_3990_erp_action */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_9336_erp.c linux-2.6-patched/drivers/s390/block/dasd_9336_erp.c
--- linux-2.6/drivers/s390/block/dasd_9336_erp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_9336_erp.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_9336_erp.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
@@ -12,10 +12,10 @@
 
 
 /*
- * DASD_9336_ERP_EXAMINE 
+ * DASD_9336_ERP_EXAMINE
  *
  * DESCRIPTION
- *   Checks only for fatal/no/recover error. 
+ *   Checks only for fatal/no/recover error.
  *   A detailed examination of the sense data is done later outside
  *   the interrupt handler.
  *
@@ -23,7 +23,7 @@
  *   'Chapter 7. 9336 Sense Data'.
  *
  * RETURN VALUES
- *   dasd_era_none	no error 
+ *   dasd_era_none	no error
  *   dasd_era_fatal	for all fatal (unrecoverable errors)
  *   dasd_era_recover	for all others.
  */
@@ -39,22 +39,3 @@ dasd_9336_erp_examine(struct dasd_ccw_re
 	return dasd_era_recover;
 
 }				/* END dasd_9336_erp_examine */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_9343_erp.c linux-2.6-patched/drivers/s390/block/dasd_9343_erp.c
--- linux-2.6/drivers/s390/block/dasd_9343_erp.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_9343_erp.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_9345_erp.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
diff -urpN linux-2.6/drivers/s390/block/dasd.c linux-2.6-patched/drivers/s390/block/dasd.c
--- linux-2.6/drivers/s390/block/dasd.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd.c	2006-06-14 14:29:51.000000000 +0200
@@ -95,7 +95,7 @@ dasd_alloc_device(void)
 	spin_lock_init(&device->mem_lock);
 	spin_lock_init(&device->request_queue_lock);
 	atomic_set (&device->tasklet_scheduled, 0);
-	tasklet_init(&device->tasklet, 
+	tasklet_init(&device->tasklet,
 		     (void (*)(unsigned long)) dasd_tasklet,
 		     (unsigned long) device);
 	INIT_LIST_HEAD(&device->ccw_queue);
@@ -128,7 +128,7 @@ dasd_state_new_to_known(struct dasd_devi
 	int rc;
 
 	/*
-	 * As long as the device is not in state DASD_STATE_NEW we want to 
+	 * As long as the device is not in state DASD_STATE_NEW we want to
 	 * keep the reference count > 0.
 	 */
 	dasd_get_device(device);
@@ -336,7 +336,7 @@ dasd_decrease_state(struct dasd_device *
 	if (device->state == DASD_STATE_ONLINE &&
 	    device->target <= DASD_STATE_READY)
 		dasd_state_online_to_ready(device);
-	
+
 	if (device->state == DASD_STATE_READY &&
 	    device->target <= DASD_STATE_BASIC)
 		dasd_state_ready_to_basic(device);
@@ -348,7 +348,7 @@ dasd_decrease_state(struct dasd_device *
 	if (device->state == DASD_STATE_BASIC &&
 	    device->target <= DASD_STATE_KNOWN)
 		dasd_state_basic_to_known(device);
-	
+
 	if (device->state == DASD_STATE_KNOWN &&
 	    device->target <= DASD_STATE_NEW)
 		dasd_state_known_to_new(device);
@@ -994,7 +994,7 @@ dasd_int_handler(struct ccw_device *cdev
 		      ((irb->scsw.cstat << 8) | irb->scsw.dstat), cqr);
 
  	/* Find out the appropriate era_action. */
-	if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC) 
+	if (irb->scsw.fctl & SCSW_FCTL_HALT_FUNC)
 		era = dasd_era_fatal;
 	else if (irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END) &&
 		 irb->scsw.cstat == 0 &&
@@ -1004,7 +1004,7 @@ dasd_int_handler(struct ccw_device *cdev
  	        era = dasd_era_fatal; /* don't recover this request */
 	else if (irb->esw.esw0.erw.cons)
 		era = device->discipline->examine_error(cqr, irb);
-	else 
+	else
 		era = dasd_era_recover;
 
 	DBF_DEV_EVENT(DBF_DEBUG, device, "era_code %d", era);
@@ -1287,7 +1287,7 @@ __dasd_start_head(struct dasd_device * d
 }
 
 /*
- * Remove requests from the ccw queue. 
+ * Remove requests from the ccw queue.
  */
 static void
 dasd_flush_ccw_queue(struct dasd_device * device, int all)
@@ -1450,23 +1450,23 @@ dasd_sleep_on(struct dasd_ccw_req * cqr)
 	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
-	
+
 	device = cqr->device;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	
+
 	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
 	cqr->callback_data = (void *) &wait_q;
 	cqr->status = DASD_CQR_QUEUED;
 	list_add_tail(&cqr->list, &device->ccw_queue);
-	
+
 	/* let the bh start the request to keep them in order */
 	dasd_schedule_bh(device);
-	
+
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
 	wait_event(wait_q, _wait_for_wakeup(cqr));
-	
+
 	/* Request status is either done or failed. */
 	rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
 	return rc;
@@ -1568,7 +1568,7 @@ dasd_sleep_on_immediatly(struct dasd_ccw
 	wait_queue_head_t wait_q;
 	struct dasd_device *device;
 	int rc;
-	
+
 	device = cqr->device;
 	spin_lock_irq(get_ccwdev_lock(device->cdev));
 	rc = _dasd_term_running_cqr(device);
@@ -1576,20 +1576,20 @@ dasd_sleep_on_immediatly(struct dasd_ccw
 		spin_unlock_irq(get_ccwdev_lock(device->cdev));
 		return rc;
 	}
-	
+
 	init_waitqueue_head (&wait_q);
 	cqr->callback = dasd_wakeup_cb;
 	cqr->callback_data = (void *) &wait_q;
 	cqr->status = DASD_CQR_QUEUED;
 	list_add(&cqr->list, &device->ccw_queue);
-	
+
 	/* let the bh start the request to keep them in order */
 	dasd_schedule_bh(device);
-	
+
 	spin_unlock_irq(get_ccwdev_lock(device->cdev));
 
 	wait_event(wait_q, _wait_for_wakeup(cqr));
-	
+
 	/* Request status is either done or failed. */
 	rc = (cqr->status == DASD_CQR_FAILED) ? -EIO : 0;
 	return rc;
@@ -1725,7 +1725,7 @@ dasd_flush_request_queue(struct dasd_dev
 
 	if (!device->request_queue)
 		return;
-	
+
 	spin_lock_irq(&device->request_queue_lock);
 	while (!list_empty(&device->request_queue->queue_head)) {
 		req = elv_next_request(device->request_queue);
@@ -2172,21 +2172,3 @@ EXPORT_SYMBOL_GPL(dasd_generic_set_onlin
 EXPORT_SYMBOL_GPL(dasd_generic_set_offline);
 EXPORT_SYMBOL_GPL(dasd_generic_auto_online);
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_devmap.c linux-2.6-patched/drivers/s390/block/dasd_devmap.c
--- linux-2.6/drivers/s390/block/dasd_devmap.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_devmap.c	2006-06-14 14:29:51.000000000 +0200
@@ -123,7 +123,7 @@ static inline int
 dasd_busid(char **str, int *id0, int *id1, int *devno)
 {
 	int val, old_style;
- 
+
 	/* check for leading '0x' */
 	old_style = 0;
 	if ((*str)[0] == '0' && (*str)[1] == 'x') {
@@ -179,7 +179,7 @@ dasd_feature_list(char *str, char **endp
 	features = 0;
 
 	while (1) {
-		for (len = 0; 
+		for (len = 0;
 		     str[len] && str[len] != ':' && str[len] != ')'; len++);
 		if (len == 2 && !strncmp(str, "ro", 2))
 			features |= DASD_FEATURE_READONLY;
@@ -359,7 +359,7 @@ dasd_parse(void)
  * Add a devmap for the device specified by busid. It is possible that
  * the devmap already exists (dasd= parameter). The order of the devices
  * added through this function will define the kdevs for the individual
- * devices. 
+ * devices.
  */
 static struct dasd_devmap *
 dasd_add_busid(char *bus_id, int features)
@@ -368,7 +368,7 @@ dasd_add_busid(char *bus_id, int feature
 	int hash;
 
 	new = (struct dasd_devmap *)
-		kmalloc(sizeof(struct dasd_devmap), GFP_KERNEL);
+		kzalloc(sizeof(struct dasd_devmap), GFP_KERNEL);
 	if (!new)
 		return ERR_PTR(-ENOMEM);
 	spin_lock(&dasd_devmap_lock);
@@ -630,7 +630,8 @@ dasd_ro_show(struct device *dev, struct 
 }
 
 static ssize_t
-dasd_ro_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+dasd_ro_store(struct device *dev, struct device_attribute *attr,
+	      const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
 	int ro_flag;
@@ -658,7 +659,7 @@ static DEVICE_ATTR(readonly, 0644, dasd_
  * use_diag controls whether the driver should use diag rather than ssch
  * to talk to the device
  */
-static ssize_t 
+static ssize_t
 dasd_use_diag_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dasd_devmap *devmap;
@@ -673,7 +674,8 @@ dasd_use_diag_show(struct device *dev, s
 }
 
 static ssize_t
-dasd_use_diag_store(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
+dasd_use_diag_store(struct device *dev, struct device_attribute *attr,
+		    const char *buf, size_t count)
 {
 	struct dasd_devmap *devmap;
 	ssize_t rc;
@@ -697,11 +699,11 @@ dasd_use_diag_store(struct device *dev, 
 	return rc;
 }
 
-static
-DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
+static DEVICE_ATTR(use_diag, 0644, dasd_use_diag_show, dasd_use_diag_store);
 
 static ssize_t
-dasd_discipline_show(struct device *dev, struct device_attribute *attr, char *buf)
+dasd_discipline_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
 {
 	struct dasd_devmap *devmap;
 	char *dname;
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.c linux-2.6-patched/drivers/s390/block/dasd_diag.c
--- linux-2.6/drivers/s390/block/dasd_diag.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_diag.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Based on.......: linux/drivers/s390/block/mdisk.c
@@ -336,7 +336,7 @@ dasd_diag_check_device(struct dasd_devic
 
 	private = (struct dasd_diag_private *) device->private;
 	if (private == NULL) {
-		private = kmalloc(sizeof(struct dasd_diag_private),GFP_KERNEL);
+		private = kzalloc(sizeof(struct dasd_diag_private),GFP_KERNEL);
 		if (private == NULL) {
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
 				"memory allocation failed for private data");
@@ -527,7 +527,7 @@ dasd_diag_build_cp(struct dasd_device * 
 				   datasize, device);
 	if (IS_ERR(cqr))
 		return cqr;
-	
+
 	dreq = (struct dasd_diag_req *) cqr->data;
 	dreq->block_count = count;
 	dbio = dreq->bio;
diff -urpN linux-2.6/drivers/s390/block/dasd_diag.h linux-2.6-patched/drivers/s390/block/dasd_diag.h
--- linux-2.6/drivers/s390/block/dasd_diag.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_diag.h	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_diag.h
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Based on.......: linux/drivers/s390/block/mdisk.h
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.c linux-2.6-patched/drivers/s390/block/dasd_eckd.c
--- linux-2.6/drivers/s390/block/dasd_eckd.c	2006-06-14 14:29:48.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,7 +1,7 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_eckd.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- *		    Horst Hummel <Horst.Hummel@de.ibm.com> 
+ *		    Horst Hummel <Horst.Hummel@de.ibm.com>
  *		    Carsten Otte <Cotte@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
@@ -210,14 +210,14 @@ check_XRC (struct ccw1         *de_ccw,
 
         /* switch on System Time Stamp - needed for XRC Support */
         if (private->rdc_data.facilities.XRC_supported) {
-                
+
                 data->ga_extended |= 0x08; /* switch on 'Time Stamp Valid'   */
                 data->ga_extended |= 0x02; /* switch on 'Extended Parameter' */
-                
+
                 data->ep_sys_time = get_clock ();
-                
+
                 de_ccw->count = sizeof (struct DE_eckd_data);
-                de_ccw->flags |= CCW_FLAG_SLI;  
+		de_ccw->flags |= CCW_FLAG_SLI;
         }
 
         return;
@@ -296,8 +296,8 @@ define_extent(struct ccw1 * ccw, struct 
 	/* check for sequential prestage - enhance cylinder range */
 	if (data->attributes.operation == DASD_SEQ_PRESTAGE ||
 	    data->attributes.operation == DASD_SEQ_ACCESS) {
-		
-		if (end.cyl + private->attrib.nr_cyl < geo.cyl) 
+
+		if (end.cyl + private->attrib.nr_cyl < geo.cyl)
 			end.cyl += private->attrib.nr_cyl;
 		else
 			end.cyl = (geo.cyl - 1);
@@ -317,7 +317,7 @@ locate_record(struct ccw1 *ccw, struct L
 	struct dasd_eckd_private *private;
 	int sector;
 	int dn, d;
-				
+
 	private = (struct dasd_eckd_private *) device->private;
 
 	DBF_DEV_EVENT(DBF_INFO, device,
@@ -554,7 +554,7 @@ dasd_eckd_check_characteristics(struct d
 
 	private = (struct dasd_eckd_private *) device->private;
 	if (private == NULL) {
-		private = kmalloc(sizeof(struct dasd_eckd_private),
+		private = kzalloc(sizeof(struct dasd_eckd_private),
 				  GFP_KERNEL | GFP_DMA);
 		if (private == NULL) {
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
@@ -562,7 +562,6 @@ dasd_eckd_check_characteristics(struct d
 				    "data");
 			return -ENOMEM;
 		}
-		memset(private, 0, sizeof(struct dasd_eckd_private));
 		device->private = (void *) private;
 	}
 	/* Invalidate status of initial analysis. */
@@ -773,7 +772,7 @@ dasd_eckd_end_analysis(struct dasd_devic
 		    ((private->rdc_data.no_cyl *
 		      private->rdc_data.trk_per_cyl *
 		      blk_per_trk * (device->bp_block >> 9)) >> 1),
-		    ((blk_per_trk * device->bp_block) >> 10), 
+		    ((blk_per_trk * device->bp_block) >> 10),
 		    private->uses_cdl ?
 		    "compatible disk layout" : "linux disk layout");
 
@@ -970,7 +969,7 @@ dasd_eckd_format_device(struct dasd_devi
 				if (i < 3) {
 					ect->kl = 4;
 					ect->dl = sizes_trk0[i] - 4;
-				} 
+				}
 			}
 			if ((fdata->intensity & 0x08) &&
 			    fdata->start_unit == 1) {
@@ -1270,7 +1269,7 @@ dasd_eckd_fill_info(struct dasd_device *
 
 /*
  * Release device ioctl.
- * Buils a channel programm to releases a prior reserved 
+ * Buils a channel programm to releases a prior reserved
  * (see dasd_eckd_reserve) device.
  */
 static int
@@ -1310,8 +1309,8 @@ dasd_eckd_release(struct dasd_device *de
 /*
  * Reserve device ioctl.
  * Options are set to 'synchronous wait for interrupt' and
- * 'timeout the request'. This leads to a terminate IO if 
- * the interrupt is outstanding for a certain time. 
+ * 'timeout the request'. This leads to a terminate IO if
+ * the interrupt is outstanding for a certain time.
  */
 static int
 dasd_eckd_reserve(struct dasd_device *device)
@@ -1349,7 +1348,7 @@ dasd_eckd_reserve(struct dasd_device *de
 
 /*
  * Steal lock ioctl - unconditional reserve device.
- * Buils a channel programm to break a device's reservation. 
+ * Buils a channel programm to break a device's reservation.
  * (unconditional reserve)
  */
 static int
@@ -1706,22 +1705,3 @@ dasd_eckd_cleanup(void)
 
 module_init(dasd_eckd_init);
 module_exit(dasd_eckd_cleanup);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_eckd.h linux-2.6-patched/drivers/s390/block/dasd_eckd.h
--- linux-2.6/drivers/s390/block/dasd_eckd.h	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_eckd.h	2006-06-14 14:29:51.000000000 +0200
@@ -1,7 +1,7 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_eckd.h
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- *                  Horst Hummel <Horst.Hummel@de.ibm.com> 
+ *		    Horst Hummel <Horst.Hummel@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
  *
@@ -155,7 +155,7 @@ struct dasd_eckd_characteristics {
 		unsigned char reserved2:4;
 		unsigned char reserved3:8;
 		unsigned char defect_wr:1;
-		unsigned char XRC_supported:1; 
+		unsigned char XRC_supported:1;
 		unsigned char reserved4:1;
 		unsigned char striping:1;
 		unsigned char reserved5:4;
@@ -343,7 +343,7 @@ struct dasd_eckd_path {
 };
 
 /*
- * Perform Subsystem Function - Prepare for Read Subsystem Data	 
+ * Perform Subsystem Function - Prepare for Read Subsystem Data
  */
 struct dasd_psf_prssd_data {
 	unsigned char order;
diff -urpN linux-2.6/drivers/s390/block/dasd_erp.c linux-2.6-patched/drivers/s390/block/dasd_erp.c
--- linux-2.6/drivers/s390/block/dasd_erp.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_erp.c	2006-06-14 14:29:51.000000000 +0200
@@ -90,7 +90,7 @@ dasd_default_erp_action(struct dasd_ccw_
 
         /* just retry - there is nothing to save ... I got no sense data.... */
         if (cqr->retries > 0) {
-                DEV_MESSAGE (KERN_DEBUG, device, 
+		DEV_MESSAGE (KERN_DEBUG, device,
                              "default ERP called (%i retries left)",
                              cqr->retries);
 		cqr->lpm    = LPM_ANYPATH;
@@ -155,7 +155,7 @@ dasd_default_erp_postaction(struct dasd_
 
 /*
  * Print the hex dump of the memory used by a request. This includes
- * all error recovery ccws that have been chained in from of the 
+ * all error recovery ccws that have been chained in from of the
  * real request.
  */
 static inline void
@@ -227,12 +227,12 @@ dasd_log_ccw(struct dasd_ccw_req * cqr, 
 		/*
 		 * Log bytes arround failed CCW but only if we did
 		 * not log the whole CP of the CCW is outside the
-		 * logged CP. 
+		 * logged CP.
 		 */
 		if (cplength > 40 ||
 		    ((addr_t) cpa < (addr_t) lcqr->cpaddr &&
 		     (addr_t) cpa > (addr_t) (lcqr->cpaddr + cplength + 4))) {
-			
+
 			DEV_MESSAGE(KERN_ERR, device,
 				    "Failed CCW (%p) (area):",
 				    (void *) (long) cpa);
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.c linux-2.6-patched/drivers/s390/block/dasd_fba.c
--- linux-2.6/drivers/s390/block/dasd_fba.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.c	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_fba.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
@@ -125,13 +125,13 @@ static int
 dasd_fba_check_characteristics(struct dasd_device *device)
 {
 	struct dasd_fba_private *private;
-	struct ccw_device *cdev = device->cdev;	
+	struct ccw_device *cdev = device->cdev;
 	void *rdc_data;
 	int rc;
 
 	private = (struct dasd_fba_private *) device->private;
 	if (private == NULL) {
-		private = kmalloc(sizeof(struct dasd_fba_private), GFP_KERNEL);
+		private = kzalloc(sizeof(struct dasd_fba_private), GFP_KERNEL);
 		if (private == NULL) {
 			DEV_MESSAGE(KERN_WARNING, device, "%s",
 				    "memory allocation failed for private "
@@ -204,7 +204,7 @@ dasd_fba_examine_error(struct dasd_ccw_r
 	if (irb->scsw.cstat == 0x00 &&
 	    irb->scsw.dstat == (DEV_STAT_CHN_END | DEV_STAT_DEV_END))
 		return dasd_era_none;
-	
+
 	cdev = device->cdev;
 	switch (cdev->id.dev_type) {
 	case 0x3370:
@@ -539,7 +539,7 @@ dasd_fba_dump_sense(struct dasd_device *
  * 8192 bytes (=2 pages). For 64 bit one dasd_mchunkt_t structure has
  * 24 bytes, the struct dasd_ccw_req has 136 bytes and each block can use
  * up to 16 bytes (8 for the ccw and 8 for the idal pointer). In
- * addition we have one define extent ccw + 16 bytes of data and a 
+ * addition we have one define extent ccw + 16 bytes of data and a
  * locate record ccw for each block (stupid devices!) + 16 bytes of data.
  * That makes:
  * (8192 - 24 - 136 - 8 - 16) / 40 = 200.2 blocks at maximum.
@@ -589,22 +589,3 @@ dasd_fba_cleanup(void)
 
 module_init(dasd_fba_init);
 module_exit(dasd_fba_cleanup);
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_fba.h linux-2.6-patched/drivers/s390/block/dasd_fba.h
--- linux-2.6/drivers/s390/block/dasd_fba.h	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/drivers/s390/block/dasd_fba.h	2006-06-14 14:29:51.000000000 +0200
@@ -1,4 +1,4 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_fba.h
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
diff -urpN linux-2.6/drivers/s390/block/dasd_int.h linux-2.6-patched/drivers/s390/block/dasd_int.h
--- linux-2.6/drivers/s390/block/dasd_int.h	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_int.h	2006-06-14 14:29:51.000000000 +0200
@@ -1,7 +1,7 @@
-/* 
+/*
  * File...........: linux/drivers/s390/block/dasd_int.h
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
- *                  Horst Hummel <Horst.Hummel@de.ibm.com> 
+ *		    Horst Hummel <Horst.Hummel@de.ibm.com>
  *		    Martin Schwidefsky <schwidefsky@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
@@ -186,7 +186,7 @@ struct dasd_ccw_req {
         void *callback_data;
 };
 
-/* 
+/*
  * dasd_ccw_req -> status can be:
  */
 #define DASD_CQR_FILLED   0x00	/* request is ready to be processed */
@@ -248,7 +248,7 @@ struct dasd_discipline {
         /*
          * Error recovery functions. examine_error() returns a value that
          * indicates what to do for an error condition. If examine_error()
-         * returns 'dasd_era_recover' erp_action() is called to create a 
+	 * returns 'dasd_era_recover' erp_action() is called to create a
          * special error recovery ccw. erp_postaction() is called after
          * an error recovery ccw has finished its execution. dump_sense
          * is called for every error condition to print the sense data
@@ -302,11 +302,11 @@ struct dasd_device {
 	spinlock_t request_queue_lock;
 	struct block_device *bdev;
         unsigned int devindex;
-	unsigned long blocks;		/* size of volume in blocks */
-	unsigned int bp_block;		/* bytes per block */
-	unsigned int s2b_shift;		/* log2 (bp_block/512) */
-	unsigned long flags;		/* per device flags */
-	unsigned short features;        /* copy of devmap-features (read-only!) */
+	unsigned long blocks;	   /* size of volume in blocks */
+	unsigned int bp_block;	   /* bytes per block */
+	unsigned int s2b_shift;	   /* log2 (bp_block/512) */
+	unsigned long flags;	   /* per device flags */
+	unsigned short features;   /* copy of devmap-features (read-only!) */
 
 	/* extended error reporting stuff (eer) */
 	struct dasd_ccw_req *eer_cqr;
@@ -606,22 +606,3 @@ static inline int dasd_eer_enabled(struc
 #endif				/* __KERNEL__ */
 
 #endif				/* DASD_H */
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-indent-level: 4 
- * c-brace-imaginary-offset: 0
- * c-brace-offset: -4
- * c-argdecl-indent: 4
- * c-label-offset: -4
- * c-continued-statement-offset: 4
- * c-continued-brace-offset: 0
- * indent-tabs-mode: 1
- * tab-width: 8
- * End:
- */
diff -urpN linux-2.6/drivers/s390/block/dasd_ioctl.c linux-2.6-patched/drivers/s390/block/dasd_ioctl.c
--- linux-2.6/drivers/s390/block/dasd_ioctl.c	2006-06-14 14:29:18.000000000 +0200
+++ linux-2.6-patched/drivers/s390/block/dasd_ioctl.c	2006-06-14 14:29:51.000000000 +0200
@@ -90,10 +90,10 @@ static int
 dasd_ioctl_quiesce(struct dasd_device *device)
 {
 	unsigned long flags;
-	
+
 	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
-	
+
 	DEV_MESSAGE (KERN_DEBUG, device, "%s",
 		     "Quiesce IO on device");
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
@@ -110,13 +110,13 @@ static int
 dasd_ioctl_resume(struct dasd_device *device)
 {
 	unsigned long flags;
-	
-	if (!capable (CAP_SYS_ADMIN)) 
+
+	if (!capable (CAP_SYS_ADMIN))
 		return -EACCES;
 
 	DEV_MESSAGE (KERN_DEBUG, device, "%s",
 		     "resume IO on device");
-	
+
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	device->stopped &= ~DASD_STOPPED_QUIESCE;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
@@ -287,7 +287,7 @@ dasd_ioctl_information(struct dasd_devic
 	dasd_info->open_count = atomic_read(&device->open_count);
 	if (!device->bdev)
 		dasd_info->open_count++;
-	
+
 	/*
 	 * check if device is really formatted
 	 * LDL / CDL was returned by 'fill_info'
