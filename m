Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261461AbUKOCmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261461AbUKOCmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Nov 2004 21:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbUKOCks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Nov 2004 21:40:48 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:28679 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261461AbUKOChc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Nov 2004 21:37:32 -0500
Date: Mon, 15 Nov 2004 03:23:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] SCSI psi240i.c: make 4 functions static
Message-ID: <20041115022355.GW2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below makes 4 needlessly global functions static.


diffstat output:
 drivers/scsi/psi240i.c |    8 ++++----
 drivers/scsi/psi240i.h |    4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/drivers/scsi/psi240i.h.old	2004-11-13 22:46:35.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/psi240i.h	2004-11-13 23:09:48.000000000 +0100
@@ -309,11 +309,7 @@
 #endif	// PSI_EIDE_SCSIOP
 
 // function prototypes
-int Psi240i_Detect			(Scsi_Host_Template *tpnt);
 int Psi240i_Command			(Scsi_Cmnd *SCpnt);
-int Psi240i_QueueCommand	(Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *));
 int Psi240i_Abort			(Scsi_Cmnd *SCpnt);
 int Psi240i_Reset			(Scsi_Cmnd *SCpnt, unsigned int flags);
-int Psi240i_BiosParam		(struct scsi_device *sdev, struct block_device *bdev,
-					sector_t capacity, int geom[]);
 #endif
--- linux-2.6.10-rc1-mm5-full/drivers/scsi/psi240i.c.old	2004-11-13 22:47:12.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/drivers/scsi/psi240i.c	2004-11-13 22:47:59.000000000 +0100
@@ -390,7 +390,7 @@
  *	Returns:		Status code.
  *
  ****************************************************************/
-int Psi240i_QueueCommand (Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
+static int Psi240i_QueueCommand (Scsi_Cmnd *SCpnt, void (*done)(Scsi_Cmnd *))
 	{
 	UCHAR		   *cdb = (UCHAR *)SCpnt->cmnd;					// Pointer to SCSI CDB
 	PADAPTER240I	padapter = HOSTDATA (SCpnt->device->host); 			// Pointer to adapter control structure
@@ -509,7 +509,7 @@
  *	Returns:		Nothing.
  *
  **************************************************************************/
-void ReadChipMemory (void *pdata, USHORT base, USHORT length, USHORT port)
+static void ReadChipMemory (void *pdata, USHORT base, USHORT length, USHORT port)
 	{
 	USHORT	z, zz;
 	UCHAR	*pd = (UCHAR *)pdata;
@@ -538,7 +538,7 @@
  *	Returns:		Number of adapters found.
  *
  ****************************************************************/
-int Psi240i_Detect (Scsi_Host_Template *tpnt)
+static int Psi240i_Detect (Scsi_Host_Template *tpnt)
 	{
 	int					board;
 	int					count = 0;
@@ -654,7 +654,7 @@
  *	Returns:		zero.
  *
  ****************************************************************/
-int Psi240i_BiosParam (struct scsi_device *sdev, struct block_device *dev,
+static int Psi240i_BiosParam (struct scsi_device *sdev, struct block_device *dev,
 		sector_t capacity, int geom[])
 	{
 	POUR_DEVICE	pdev;

