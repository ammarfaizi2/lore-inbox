Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVB0AzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVB0AzA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 19:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVB0Ay7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 19:54:59 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:3334 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261324AbVB0AyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 19:54:22 -0500
Date: Sun, 27 Feb 2005 01:54:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/aacraid/: cleanups
Message-ID: <20050227005417.GT3311@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- commsup.c: remove the unused global function aac_consumer_avail

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/aacraid/aachba.c   |   10 +++++-----
 drivers/scsi/aacraid/aacraid.h  |    2 --
 drivers/scsi/aacraid/commctrl.c |    4 ++--
 drivers/scsi/aacraid/comminit.c |    2 +-
 drivers/scsi/aacraid/commsup.c  |    7 +------
 drivers/scsi/aacraid/linit.c    |    2 +-
 drivers/scsi/aacraid/sa.c       |    2 +-
 7 files changed, 11 insertions(+), 18 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/aachba.c.old	2005-02-27 01:05:38.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/aachba.c	2005-02-27 01:06:18.000000000 +0100
@@ -560,10 +560,10 @@
 	inqstrcpy ("V1.0", str->prl);
 }
 
-void set_sense(u8 *sense_buf, u8 sense_key, u8 sense_code,
-		    u8 a_sense_code, u8 incorrect_length,
-		    u8 bit_pointer, u16 field_pointer,
-		    u32 residue)
+static void set_sense(u8 *sense_buf, u8 sense_key, u8 sense_code,
+		      u8 a_sense_code, u8 incorrect_length,
+		      u8 bit_pointer, u16 field_pointer,
+		      u32 residue)
 {
 	sense_buf[0] = 0xF0;	/* Sense data valid, err code 70h (current error) */
 	sense_buf[1] = 0;	/* Segment number, always zero */
@@ -807,7 +807,7 @@
 	aac_io_done(scsicmd);
 }
 
-int aac_read(struct scsi_cmnd * scsicmd, int cid)
+static int aac_read(struct scsi_cmnd * scsicmd, int cid)
 {
 	u32 lba;
 	u32 count;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commctrl.c.old	2005-02-27 01:06:31.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commctrl.c	2005-02-27 01:07:03.000000000 +0100
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
 
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/comminit.c.old	2005-02-27 01:07:25.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/comminit.c	2005-02-27 01:07:34.000000000 +0100
@@ -204,7 +204,7 @@
  *		0 - If there were errors initing. This is a fatal error.
  */
  
-int aac_comm_init(struct aac_dev * dev)
+static int aac_comm_init(struct aac_dev * dev)
 {
 	unsigned long hdrsize = (sizeof(u32) * NUMBER_OF_COMM_QUEUES) * 2;
 	unsigned long queuesize = sizeof(struct aac_entry) * TOTAL_QUEUE_ENTRIES;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/aacraid.h.old	2005-02-27 01:04:59.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/aacraid.h	2005-02-27 01:09:03.000000000 +0100
@@ -1595,11 +1595,9 @@
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
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commsup.c.old	2005-02-27 01:08:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commsup.c	2005-02-27 01:09:11.000000000 +0100
@@ -210,7 +210,7 @@
  *	caller.
  */
  
-void fib_dealloc(struct fib * fibptr)
+static void fib_dealloc(struct fib * fibptr)
 {
 	struct hw_fib *hw_fib = fibptr->hw_fib;
 	if(hw_fib->header.StructType != FIB_MAGIC) 
@@ -566,11 +566,6 @@
 	return(status);
 }
 
-int aac_consumer_avail(struct aac_dev *dev, struct aac_queue * q)
-{
-	return (le32_to_cpu(*q->headers.producer) != le32_to_cpu(*q->headers.consumer));
-}
-
 
 /**
  *	aac_consumer_free	-	free consumer entry
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/linit.c.old	2005-02-27 01:09:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/linit.c	2005-02-27 01:09:38.000000000 +0100
@@ -215,7 +215,7 @@
  *	Returns a static string describing the device in question
  */
 
-const char *aac_info(struct Scsi_Host *shost)
+static const char *aac_info(struct Scsi_Host *shost)
 {
 	struct aac_dev *dev = (struct aac_dev *)shost->hostdata;
 	return aac_drivers[dev->cardtype].name;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/sa.c.old	2005-02-27 01:09:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/sa.c	2005-02-27 01:10:05.000000000 +0100
@@ -89,7 +89,7 @@
  *	Notify the adapter of an event
  */
  
-void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
+static void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
 {
 	switch (event) {
 

