Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbUKOCE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbUKOCE1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbUKOCEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:04:21 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:35594 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261404AbUKOCCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:02:48 -0500
Date: Mon, 15 Nov 2004 02:49:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI aacraid: make some code static
Message-ID: <20041115014955.GC2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes some needlessly global code static.

It also removes the completely unused global function 
aac_consumer_avail.


diffstat output:
 drivers/scsi/aacraid/aachba.c   |   10 +++++-----
 drivers/scsi/aacraid/aacraid.h  |    2 --
 drivers/scsi/aacraid/commctrl.c |    4 ++--
 drivers/scsi/aacraid/comminit.c |    2 +-
 drivers/scsi/aacraid/commsup.c  |    8 +-------
 drivers/scsi/aacraid/linit.c    |    2 +-
 drivers/scsi/aacraid/sa.c       |    6 +++---
 7 files changed, 13 insertions(+), 21 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/aacraid.h.old	2004-11-13 16:35:24.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/aacraid.h	2004-11-13 16:39:15.000000000 +0100
@@ -1564,11 +1564,9 @@
 void fib_map_free(struct aac_dev *dev);
 void fib_free(struct fib * context);
 void fib_init(struct fib * context);
-void fib_dealloc(struct fib * context);
 void aac_printf(struct aac_dev *dev, u32 val);
 int fib_send(u16 command, struct fib * context, unsigned long size, int priority, int wait, int reply, fib_callback callback, void *ctxt);
 int aac_consumer_get(struct aac_dev * dev, struct aac_queue * q, struct aac_entry **entry);
-int aac_consumer_avail(struct aac_dev * dev, struct aac_queue * q);
 void aac_consumer_free(struct aac_dev * dev, struct aac_queue * q, u32 qnum);
 int fib_complete(struct fib * context);
 #define fib_data(fibctx) ((void *)(fibctx)->hw_fib->data)
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/aachba.c.old	2004-11-13 16:35:30.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/aachba.c	2004-11-13 16:36:39.000000000 +0100
@@ -560,10 +560,10 @@
 	inqstrcpy ("V1.0", str->prl);
 }
 
-void set_sense(u8 *sense_buf, u8 sense_key, u8 sense_code,
-		    u8 a_sense_code, u8 incorrect_length,
-		    u8 bit_pointer, u16 field_pointer,
-		    u32 residue)
+static void set_sense(u8 *sense_buf, u8 sense_key, u8 sense_code,
+			 u8 a_sense_code, u8 incorrect_length,
+			 u8 bit_pointer, u16 field_pointer,
+			 u32 residue)
 {
 	sense_buf[0] = 0xF0;	/* Sense data valid, err code 70h (current error) */
 	sense_buf[1] = 0;	/* Segment number, always zero */
@@ -785,7 +785,7 @@
 	aac_io_done(scsicmd);
 }
 
-int aac_read(struct scsi_cmnd * scsicmd, int cid)
+static int aac_read(struct scsi_cmnd * scsicmd, int cid)
 {
 	u32 lba;
 	u32 count;
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/commctrl.c.old	2004-11-13 16:37:30.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/commctrl.c	2004-11-13 16:37:54.000000000 +0100
@@ -403,7 +403,7 @@
  *
  */
 
-int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
+static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 {
 	struct fib* srbfib;
 	int status;
@@ -621,7 +621,7 @@
 };
 
 
-int aac_get_pci_info(struct aac_dev* dev, void __user *arg)
+static int aac_get_pci_info(struct aac_dev* dev, void __user *arg)
 {
         struct aac_pci_info pci_info;
 
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/comminit.c.old	2004-11-13 16:38:09.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/comminit.c	2004-11-13 16:38:18.000000000 +0100
@@ -204,7 +204,7 @@
  *		0 - If there were errors initing. This is a fatal error.
  */
  
-int aac_comm_init(struct aac_dev * dev)
+static int aac_comm_init(struct aac_dev * dev)
 {
 	unsigned long hdrsize = (sizeof(u32) * NUMBER_OF_COMM_QUEUES) * 2;
 	unsigned long queuesize = sizeof(struct aac_entry) * TOTAL_QUEUE_ENTRIES;
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/commsup.c.old	2004-11-13 16:38:49.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/commsup.c	2004-11-13 16:39:30.000000000 +0100
@@ -210,7 +210,7 @@
  *	caller.
  */
  
-void fib_dealloc(struct fib * fibptr)
+static void fib_dealloc(struct fib * fibptr)
 {
 	struct hw_fib *hw_fib = fibptr->hw_fib;
 	if(hw_fib->header.StructType != FIB_MAGIC) 
@@ -566,12 +566,6 @@
 	return(status);
 }
 
-int aac_consumer_avail(struct aac_dev *dev, struct aac_queue * q)
-{
-	return (le32_to_cpu(*q->headers.producer) != le32_to_cpu(*q->headers.consumer));
-}
-
-
 /**
  *	aac_consumer_free	-	free consumer entry
  *	@dev: Adapter
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/linit.c.old	2004-11-13 16:39:44.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/linit.c	2004-11-13 16:40:16.000000000 +0100
@@ -228,7 +228,7 @@
  *	Returns a static string describing the device in question
  */
 
-const char *aac_info(struct Scsi_Host *shost)
+static const char *aac_info(struct Scsi_Host *shost)
 {
 	struct aac_dev *dev = (struct aac_dev *)shost->hostdata;
 	return aac_drivers[dev->cardtype].name;
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/sa.c.old	2004-11-13 16:40:32.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/aacraid/sa.c	2004-11-13 16:41:08.000000000 +0100
@@ -90,7 +90,7 @@
  * 	the host.
  */
  
-void aac_sa_enable_interrupt(struct aac_dev *dev, u32 event)
+static void aac_sa_enable_interrupt(struct aac_dev *dev, u32 event)
 {
 	switch (event) {
 
@@ -121,7 +121,7 @@
  * 	the host.
  */
 
-void aac_sa_disable_interrupt (struct aac_dev *dev, u32 event)
+static void aac_sa_disable_interrupt (struct aac_dev *dev, u32 event)
 {
 	switch (event) {
 
@@ -151,7 +151,7 @@
  *	Notify the adapter of an event
  */
  
-void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
+static void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
 {
 	switch (event) {
 

