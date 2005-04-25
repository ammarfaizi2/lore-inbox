Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVDYLwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVDYLwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 07:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVDYLwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 07:52:39 -0400
Received: from magic.adaptec.com ([216.52.22.17]:26281 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262570AbVDYLvx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 07:51:53 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/scsi/aacraid/: make some functions static
Date: Mon, 25 Apr 2005 07:51:51 -0400
Message-ID: <60807403EABEB443939A5A7AA8A7458B0112CFE3@otce2k01.adaptec.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/scsi/aacraid/: make some functions static
Thread-Index: AcVIUPba4vZi7IOyR2SkU85c1SURpgBO+Jzw
From: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
To: "Adrian Bunk" <bunk@stusta.de>, <linux-scsi@vger.kernel.org>
Cc: <James.Bottomley@SteelEye.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I approve, original was applied to Adaptec Branch on November 24th 2004.

Why is this one taking so long to propagate?

Sincerely -- Mark Salyzyn

-----Original Message-----
From: linux-scsi-owner@vger.kernel.org
[mailto:linux-scsi-owner@vger.kernel.org] On Behalf Of Adrian Bunk
Sent: Saturday, April 23, 2005 6:07 PM
To: linux-scsi@vger.kernel.org
Cc: James.Bottomley@SteelEye.com; linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/scsi/aacraid/: make some functions static

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/scsi/aacraid/aachba.c   |   10 +++++-----
 drivers/scsi/aacraid/aacraid.h  |    1 -
 drivers/scsi/aacraid/commctrl.c |    4 ++--
 drivers/scsi/aacraid/comminit.c |    2 +-
 drivers/scsi/aacraid/commsup.c  |    2 +-
 drivers/scsi/aacraid/linit.c    |    2 +-
 drivers/scsi/aacraid/sa.c       |    2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

This patch contains the following cleanups:
- make needlessly global functions static

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

--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/aachba.c.old
2005-02-27 01:05:38.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/aachba.c
2005-02-27 01:06:18.000000000 +0100
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
 	sense_buf[0] = 0xF0;	/* Sense data valid, err code 70h
(current error) */
 	sense_buf[1] = 0;	/* Segment number, always zero */
@@ -807,7 +807,7 @@
 	aac_io_done(scsicmd);
 }
 
-int aac_read(struct scsi_cmnd * scsicmd, int cid)
+static int aac_read(struct scsi_cmnd * scsicmd, int cid)
 {
 	u32 lba;
 	u32 count;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commctrl.c.old
2005-02-27 01:06:31.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commctrl.c
2005-02-27 01:07:03.000000000 +0100
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
 
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/comminit.c.old
2005-02-27 01:07:25.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/comminit.c
2005-02-27 01:07:34.000000000 +0100
@@ -204,7 +204,7 @@
  *		0 - If there were errors initing. This is a fatal error.
  */
  
-int aac_comm_init(struct aac_dev * dev)
+static int aac_comm_init(struct aac_dev * dev)
 {
 	unsigned long hdrsize = (sizeof(u32) * NUMBER_OF_COMM_QUEUES) *
2;
 	unsigned long queuesize = sizeof(struct aac_entry) *
TOTAL_QUEUE_ENTRIES;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commsup.c.old
2005-02-27 01:08:23.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/commsup.c
2005-02-27 01:09:11.000000000 +0100
@@ -210,7 +210,7 @@
  *	caller.
  */
  
-void fib_dealloc(struct fib * fibptr)
+static void fib_dealloc(struct fib * fibptr)
 {
 	struct hw_fib *hw_fib = fibptr->hw_fib;
 	if(hw_fib->header.StructType != FIB_MAGIC) 
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/linit.c.old
2005-02-27 01:09:30.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/linit.c
2005-02-27 01:09:38.000000000 +0100
@@ -215,7 +215,7 @@
  *	Returns a static string describing the device in question
  */
 
-const char *aac_info(struct Scsi_Host *shost)
+static const char *aac_info(struct Scsi_Host *shost)
 {
 	struct aac_dev *dev = (struct aac_dev *)shost->hostdata;
 	return aac_drivers[dev->cardtype].name;
--- linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/sa.c.old
2005-02-27 01:09:56.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/scsi/aacraid/sa.c	2005-02-27
01:10:05.000000000 +0100
@@ -89,7 +89,7 @@
  *	Notify the adapter of an event
  */
  
-void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
+static void aac_sa_notify_adapter(struct aac_dev *dev, u32 event)
 {
 	switch (event) {
 

--- linux-2.6.12-rc2-mm3-full/drivers/scsi/aacraid/aacraid.h.old
2005-04-23 21:51:56.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/scsi/aacraid/aacraid.h
2005-04-23 21:52:06.000000000 +0200
@@ -1597,7 +1597,6 @@
 void fib_map_free(struct aac_dev *dev);
 void fib_free(struct fib * context);
 void fib_init(struct fib * context);
-void fib_dealloc(struct fib * context);
 void aac_printf(struct aac_dev *dev, u32 val);
 int fib_send(u16 command, struct fib * context, unsigned long size, int
priority, int wait, int reply, fib_callback callback, void *ctxt);
 int aac_consumer_get(struct aac_dev * dev, struct aac_queue * q, struct
aac_entry **entry);

-
To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
