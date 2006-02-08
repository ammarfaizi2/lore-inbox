Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932403AbWBHJ3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWBHJ3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 04:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWBHJ3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 04:29:13 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:41654 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP id S932403AbWBHJ3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 04:29:13 -0500
Date: Wed, 8 Feb 2006 10:29:15 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH GIT] drivers/block/ub.c - misc. cleanup/indentation, removed unneeded return
Message-ID: <20060208092914.GA8628@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="x+6KMIRAuhnl3hBn"
Content-Disposition: inline
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-gce4b50f2
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hey hackers. ;)

I created this little patch while reading through drivers/block/ub.c. It fixes
some indentation/whitespace as well as some empty commenting, an hardcoded
module name and an unneeded return.

The patch is against the latest -git.

Marc

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ub.c.patch-git"

--- ub.c.orig	2006-02-07 23:35:32.000000000 +0100
+++ ub.c	2006-02-07 23:53:56.000000000 +0100
@@ -33,10 +33,10 @@
 #include <linux/timer.h>
 #include <scsi/scsi.h>
 
-#define DRV_NAME "ub"
-#define DEVFS_NAME DRV_NAME
+#define DRV_NAME		"ub"
+#define DEVFS_NAME		DRV_NAME
 
-#define UB_MAJOR 180
+#define UB_MAJOR		180
 
 /*
  * The command state machine is the key model for understanding of this driver.
@@ -109,19 +109,13 @@
  * This many LUNs per USB device.
  * Every one of them takes a host, see UB_MAX_HOSTS.
  */
-#define UB_MAX_LUNS   9
+#define UB_MAX_LUNS		9
 
-/*
- */
-
-#define UB_PARTS_PER_LUN      8
+#define UB_PARTS_PER_LUN	8
 
-#define UB_MAX_CDB_SIZE      16		/* Corresponds to Bulk */
+#define UB_MAX_CDB_SIZE		16	/* Corresponds to Bulk */
 
-#define UB_SENSE_SIZE  18
-
-/*
- */
+#define UB_SENSE_SIZE		18
 
 /* command block wrapper */
 struct bulk_cb_wrap {
@@ -161,28 +155,28 @@
  */
 struct ub_dev;
 
-#define UB_MAX_REQ_SG	9	/* cdrecord requires 32KB and maybe a header */
-#define UB_MAX_SECTORS 64
+#define UB_MAX_REQ_SG		9	/* cdrecord requires 32KB and maybe a header */
+#define UB_MAX_SECTORS		64
 
 /*
  * A second is more than enough for a 32K transfer (UB_MAX_SECTORS)
  * even if a webcam hogs the bus, but some devices need time to spin up.
  */
-#define UB_URB_TIMEOUT	(HZ*2)
-#define UB_DATA_TIMEOUT	(HZ*5)	/* ZIP does spin-ups in the data phase */
-#define UB_STAT_TIMEOUT	(HZ*5)	/* Same spinups and eject for a dataless cmd. */
-#define UB_CTRL_TIMEOUT	(HZ/2)	/* 500ms ought to be enough to clear a stall */
+#define UB_URB_TIMEOUT		(HZ*2)
+#define UB_DATA_TIMEOUT		(HZ*5)	/* ZIP does spin-ups in the data phase */
+#define UB_STAT_TIMEOUT		(HZ*5)	/* Same spinups and eject for a dataless cmd. */
+#define UB_CTRL_TIMEOUT		(HZ/2)	/* 500ms ought to be enough to clear a stall */
 
 /*
  * An instance of a SCSI command in transit.
  */
-#define UB_DIR_NONE	0
-#define UB_DIR_READ	1
-#define UB_DIR_ILLEGAL2	2
-#define UB_DIR_WRITE	3
+#define UB_DIR_NONE		0
+#define UB_DIR_READ		1
+#define UB_DIR_ILLEGAL2		2
+#define UB_DIR_WRITE		3
 
-#define UB_DIR_CHAR(c)  (((c)==UB_DIR_WRITE)? 'w': \
-			 (((c)==UB_DIR_READ)? 'r': 'n'))
+#define UB_DIR_CHAR(c)		(((c)==UB_DIR_WRITE)? 'w': \
+					(((c)==UB_DIR_READ)? 'r': 'n'))
 
 enum ub_scsi_cmd_state {
 	UB_CMDST_INIT,			/* Initial state */
@@ -241,8 +235,6 @@
 	struct scatterlist sgv[UB_MAX_REQ_SG];
 };
 
-/*
- */
 struct ub_capacity {
 	unsigned long nsec;		/* Linux size - 512 byte sectors */
 	unsigned int bsize;		/* Linux hardsect_size */
@@ -253,8 +245,8 @@
  * The SCSI command tracing structure.
  */
 
-#define SCMD_ST_HIST_SZ   8
-#define SCMD_TRACE_SZ    63		/* Less than 4KB of 61-byte lines */
+#define SCMD_ST_HIST_SZ		8	/* history size */
+#define SCMD_TRACE_SZ		63	/* Less than 4KB of 61-byte lines */
 
 struct ub_scsi_cmd_trace {
 	int hcur;
@@ -263,7 +255,7 @@
 	unsigned char op;
 	unsigned char dir;
 	unsigned char key, asc, ascq;
-	char st_hst[SCMD_ST_HIST_SZ];	
+	char st_hst[SCMD_ST_HIST_SZ];
 };
 
 struct ub_scsi_trace {
@@ -313,8 +305,6 @@
 	return ret;
 }
 
-/*
- */
 struct ub_scsi_cmd_queue {
 	int qlen, qmax;
 	struct ub_scsi_cmd *head, *tail;
@@ -393,8 +383,6 @@
 	struct ub_scsi_trace tr;
 };
 
-/*
- */
 static void ub_cleanup(struct ub_dev *sc);
 static int ub_request_fn_1(struct ub_lun *lun, struct request *rq);
 static void ub_cmd_build_block(struct ub_dev *sc, struct ub_lun *lun,
@@ -428,8 +416,6 @@
 static int ub_probe_clear_stall(struct ub_dev *sc, int stalled_pipe);
 static int ub_probe_lun(struct ub_dev *sc, int lnum);
 
-/*
- */
 #ifdef CONFIG_USB_LIBUSUAL
 
 #define ub_usb_ids  storage_usb_ids
@@ -450,10 +436,10 @@
  * This has to be thought out in detail before changing.
  * If UB_MAX_HOST was 1000, we'd use a bitmap. Or a better data structure.
  */
-#define UB_MAX_HOSTS  26
+#define UB_MAX_HOSTS		26
 static char ub_hostv[UB_MAX_HOSTS];
 
-#define UB_QLOCK_NUM 5
+#define UB_QLOCK_NUM		5
 static spinlock_t ub_qlockv[UB_QLOCK_NUM];
 static int ub_qlock_next = 0;
 
@@ -785,12 +771,11 @@
 	return cmd;
 }
 
-#define ub_cmdq_peek(sc)  ((sc)->cmd_queue.head)
+#define ub_cmdq_peek(sc)	((sc)->cmd_queue.head)
 
 /*
  * The request function is our main entry point
  */
-
 static void ub_request_fn(request_queue_t *q)
 {
 	struct ub_lun *lun = q->queuedata;
@@ -1420,19 +1405,19 @@
 		}
 
 		switch (bcs->Status) {
-		case US_BULK_STAT_OK:
-			break;
-		case US_BULK_STAT_FAIL:
-			ub_state_sense(sc, cmd);
-			return;
-		case US_BULK_STAT_PHASE:
-			/* P3 */ printk("%s: status PHASE\n", sc->name);
-			goto Bad_End;
-		default:
-			printk(KERN_INFO "%s: unknown CSW status 0x%x\n",
-			    sc->name, bcs->Status);
-			ub_state_done(sc, cmd, -EINVAL);
-			return;
+			case US_BULK_STAT_OK:
+				break;
+			case US_BULK_STAT_FAIL:
+				ub_state_sense(sc, cmd);
+				return;
+			case US_BULK_STAT_PHASE:
+				/* P3 */ printk("%s: status PHASE\n", sc->name);
+				goto Bad_End;
+			default:
+				printk(KERN_INFO "%s: unknown CSW status 0x%x\n",
+				sc->name, bcs->Status);
+				ub_state_done(sc, cmd, -EINVAL);
+				return;
 		}
 
 		/* Not zeroing error to preserve a babble indicator */
@@ -1548,7 +1533,6 @@
  */
 static void ub_state_stat(struct ub_dev *sc, struct ub_scsi_cmd *cmd)
 {
-
 	if (__ub_state_stat(sc, cmd) != 0)
 		return;
 
@@ -1660,8 +1644,6 @@
 	return 0;
 }
 
-/*
- */
 static void ub_top_sense_done(struct ub_dev *sc, struct ub_scsi_cmd *scmd)
 {
 	unsigned char *sense = sc->top_sense;
@@ -1705,10 +1687,8 @@
  * XXX Move usb_reset_device to khubd. Hogging kevent is not a good thing.
  * XXX Make usb_sync_reset asynchronous.
  */
-
 static void ub_reset_enter(struct ub_dev *sc, int try)
 {
-
 	if (sc->reset) {
 		/* This happens often on multi-LUN devices. */
 		return;
@@ -1799,7 +1779,6 @@
  */
 static void ub_revalidate(struct ub_dev *sc, struct ub_lun *lun)
 {
-
 	lun->readonly = 0;	/* XXX Query this from the device */
 
 	lun->capacity.nsec = 0;
@@ -1894,8 +1873,6 @@
 	return rc;
 }
 
-/*
- */
 static int ub_bd_release(struct inode *inode, struct file *filp)
 {
 	struct gendisk *disk = inode->i_bdev->bd_disk;
@@ -1969,7 +1946,6 @@
 	 */
 	if (ub_sync_tur(lun->udev, lun) != 0) {
 		lun->changed = 1;
-		return 1;
 	}
 
 	return lun->changed;
@@ -2132,8 +2108,6 @@
 	return rc;
 }
 
-/*
- */
 static void ub_probe_urb_complete(struct urb *urb, struct pt_regs *pt)
 {
 	struct completion *cop = urb->context;
@@ -2686,7 +2660,6 @@
 	 * At this point there must be no commands coming from anyone
 	 * and no URBs left in transit.
 	 */
-
 	device_remove_file(&sc->intf->dev, &dev_attr_diag);
 	usb_set_intfdata(intf, NULL);
 	// usb_put_intf(sc->intf);
@@ -2698,7 +2671,7 @@
 }
 
 static struct usb_driver ub_driver = {
-	.name =		"ub",
+	.name =		DRV_NAME,
 	.probe =	ub_probe,
 	.disconnect =	ub_disconnect,
 	.id_table =	ub_usb_ids,

--x+6KMIRAuhnl3hBn--
