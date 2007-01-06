Return-Path: <linux-kernel-owner+w=401wt.eu-S1751383AbXAFNRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbXAFNRn (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 08:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAFNRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 08:17:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:27654 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbXAFNRl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 08:17:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent:from;
        b=McveFKzQZe5jhwxCfIsiNnR64fav5+fQQZw/Bs4jQHQs78FFR0Dg0IBp9drmAuormd635WmSHfLpaq9o9ZabTL2kWKF920na+hHnSYwuIRof9/XDwdTX0RidkB/N5qVr0zDXBhguEFpaSPrqji/v/WniXKDdHmRp4d/Ea2kq+sc=
Date: Sat, 6 Jan 2007 15:17:25 +0200
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Message-ID: <20070106131725.GB19020@Ahmed>
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm not able to find the DAC960 block driver maintainer. If someones knows
please reply :).

A patch to switch kmalloc->kzalloc and to clean unneeded kammloc,
pci_alloc_consistent casts

Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>

diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
index 8d81a3a..4febe7f 100644
--- a/drivers/block/DAC960.c
+++ b/drivers/block/DAC960.c
@@ -1373,8 +1373,7 @@ static boolean DAC960_V2_EnableMemoryMailboxInterface(DAC960_Controller_T
   Controller->BounceBufferLimit = DAC690_V2_PciDmaMask;
 
   /* This is a temporary dma mapping, used only in the scope of this function */
-  CommandMailbox =
-	  (DAC960_V2_CommandMailbox_T *)pci_alloc_consistent( PCI_Device,
+  CommandMailbox = pci_alloc_consistent(PCI_Device,
 		sizeof(DAC960_V2_CommandMailbox_T), &CommandMailboxDMA);
   if (CommandMailbox == NULL)
 	  return false;
@@ -1879,8 +1878,8 @@ static boolean DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
       if (NewLogicalDeviceInfo->LogicalDeviceState !=
 	  DAC960_V2_LogicalDevice_Offline)
 	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber] = true;
-      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T),
+				   GFP_ATOMIC);
       if (LogicalDeviceInfo == NULL)
 	return DAC960_Failure(Controller, "LOGICAL DEVICE ALLOCATION");
       Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
@@ -2113,8 +2112,8 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
       if (!DAC960_V2_NewPhysicalDeviceInfo(Controller, Channel, TargetID, LogicalUnit))
 	  break;
 
-      PhysicalDeviceInfo = (DAC960_V2_PhysicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
+      PhysicalDeviceInfo = kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T),
+				    GFP_ATOMIC);
       if (PhysicalDeviceInfo == NULL)
 		return DAC960_Failure(Controller, "PHYSICAL DEVICE ALLOCATION");
       Controller->V2.PhysicalDeviceInformation[PhysicalDeviceIndex] =
@@ -2122,8 +2121,8 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
       memcpy(PhysicalDeviceInfo, NewPhysicalDeviceInfo,
 		sizeof(DAC960_V2_PhysicalDeviceInfo_T));
 
-      InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
-	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
+      InquiryUnitSerialNumber = kmalloc(
+	      sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
       if (InquiryUnitSerialNumber == NULL) {
 	kfree(PhysicalDeviceInfo);
 	return DAC960_Failure(Controller, "SERIAL NUMBER ALLOCATION");
@@ -4949,8 +4948,8 @@ static void DAC960_V2_ProcessCompletedCommand(DAC960_Command_T *Command)
 	      PhysicalDevice.LogicalUnit = NewLogicalDeviceInfo->LogicalUnit;
 	      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
 		PhysicalDevice;
-	      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
-		kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
+	      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T),
+					  GFP_ATOMIC);
 	      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
 		LogicalDeviceInfo;
 	      DAC960_Critical("Logical Drive %d (/dev/rd/c%dd%d) "
@@ -5709,14 +5708,14 @@ static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
       unsigned int NewStatusBufferLength = DAC960_InitialStatusBufferSize;
       while (NewStatusBufferLength < ByteCount)
 	NewStatusBufferLength *= 2;
-      Controller->CombinedStatusBuffer =
-	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
+      Controller->CombinedStatusBuffer = kmalloc(NewStatusBufferLength, 
+						  GFP_ATOMIC);
       if (Controller->CombinedStatusBuffer == NULL) return false;
       Controller->CombinedStatusBufferLength = NewStatusBufferLength;
       return true;
     }
-  NewStatusBuffer = (unsigned char *)
-    kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
+  NewStatusBuffer = kmalloc(2 * Controller->CombinedStatusBufferLength, 
+			     GFP_ATOMIC);
   if (NewStatusBuffer == NULL)
     {
       DAC960_Warning("Unable to expand Combined Status Buffer - Truncating\n",


-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
