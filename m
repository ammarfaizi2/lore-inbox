Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVFQWru@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVFQWru (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVFQWru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:47:50 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:24250 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261276AbVFQWiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:38:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qC/5M+ifaht76isiJQeN7TUV4X+PZoMA5ws3RPsFYigr0hxWK5naq7v6JJDQ2bE8O9PpZsKUpt6lLfb5BzrPSr9vjhPqasdZWf0GCkcBPsRtaeHtu6GNDjW34CjcMCdXpdOltgkFFSmXcCUInLxWcH/xoCEhzpAaawT4x3enaMQ=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Donald.Huang@ite.com.tw, akpm@osdl.org
Subject: [PATCH 1/3] iteraid: fix trivial sparse warnings
Date: Sat, 18 Jun 2005 02:40:29 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506180240.29240.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/iteraid.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

Index: linux-iteraid/drivers/scsi/iteraid.c
===================================================================
--- linux-iteraid.orig/drivers/scsi/iteraid.c	2005-06-17 23:58:33.000000000 +0400
+++ linux-iteraid/drivers/scsi/iteraid.c	2005-06-18 00:53:07.000000000 +0400
@@ -269,16 +269,16 @@ MODULE_LICENSE("GPL");
 
 #define	PRD_BYTES		8	/* PRD table size               */
 #define PRD_ENTRIES		(PAGE_SIZE / (2 * PRD_BYTES))
-struct Scsi_Host *ite_vhost = 0;	/* SCSI virtual host            */
-Scsi_Cmnd *it8212_req_last = 0;	/* SRB request list             */
-unsigned int NumAdapters = 0;	/* Adapters number              */
-PITE_ADAPTER ite_adapters[2];	/* How many adapters support    */
+static struct Scsi_Host *ite_vhost = NULL;	/* SCSI virtual host    */
+static Scsi_Cmnd *it8212_req_last = NULL;	/* SRB request list     */
+static unsigned int NumAdapters = 0;	/* Adapters number              */
+static PITE_ADAPTER ite_adapters[2];	/* How many adapters support    */
 
 /************************************************************************
  * Notifier blockto get a notify on system shutdown/halt/reboot.
  ************************************************************************/
 static int ite_halt(struct notifier_block *nb, ulong event, void *buf);
-struct notifier_block ite_notifier = { ite_halt, NULL, 0
+static struct notifier_block ite_notifier = { ite_halt, NULL, 0
 };
 static struct semaphore mimd_entry_mtx;
 static spinlock_t queue_request_lock = SPIN_LOCK_UNLOCKED;
@@ -967,7 +967,7 @@ IdeSetupDma(PChannel pChan, unsigned lon
 /************************************************************************
  * This will be only used in RAID mode.
  ************************************************************************/
-void IT8212ReconfigChannel(PChannel pChan, u8 ArrayId, u8 Operation)
+static void IT8212ReconfigChannel(PChannel pChan, u8 ArrayId, u8 Operation)
 {
 	u8 enableVirtualChannel;
 	struct pci_dev *pPciDev = pChan->pPciDev;
@@ -999,7 +999,7 @@ void IT8212ReconfigChannel(PChannel pCha
  * Only after receiving SET CHIP STATUS command, the corresponding virtual
  * device will be active.
  ************************************************************************/
-u8 IT8212GetChipStatus(uioctl_t * ioc)
+static u8 IT8212GetChipStatus(uioctl_t * ioc)
 {
 	u8 PriMasterIsNull = FALSE;
 	u8 statusByte;
@@ -1128,7 +1128,7 @@ exit:
 /************************************************************************
  * Erase the partition table.
  ************************************************************************/
-unsigned char IT8212ErasePartition(uioctl_t * pioc)
+static unsigned char IT8212ErasePartition(uioctl_t * pioc)
 {
 	unsigned char drvSelect;
 	unsigned char statusByte = 0;
@@ -1880,7 +1880,7 @@ static u8 IT8212ResetAdapter(PITE_ADAPTE
 /************************************************************************
  * Rebuild disk array.
  ************************************************************************/
-u8 IT8212Rebuild(uioctl_t * pioc)
+static u8 IT8212Rebuild(uioctl_t * pioc)
 {
 	u8 rebuildDirection;
 	u8 statusByte = 0;
@@ -3299,7 +3299,7 @@ static u8 IdeVerify(PChannel pChan, PSCS
  * This function is used to copy memory with overlapped destination and
  * source. I guess ScsiPortMoveMemory cannot handle this well. Can it?
  ************************************************************************/
-void
+static void
 IT8212MoveMemory(unsigned char *DestAddr, unsigned char *SrcAddr, u32 ByteCount)
 {
 	long i;
@@ -5321,7 +5321,7 @@ exit:
 		/*
 		 * Return TURE or FALSE to user space.
 		 */
-		put_user(status, (u8 *) arg);
+		put_user(status, (u8 __user *) arg);
 		return 0;
 	case ITE_IOC_GET_DRIVER_VERSION:
 		dprintk("ITE_IOC_GET_DRIVER_VERSION\n");
@@ -5329,7 +5329,7 @@ exit:
 		/*
 		 * Get the current driver version.
 		 */
-		put_user(driver_ver, (int *)arg);
+		put_user(driver_ver, (int __user *)arg);
 		return 0;
 	default:
 		return -EINVAL;
