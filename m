Return-Path: <linux-kernel-owner+w=401wt.eu-S1750892AbXAFRqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750892AbXAFRqa (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbXAFRqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 12:46:30 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:53127 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbXAFRq3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 12:46:29 -0500
Date: Sat, 6 Jan 2007 09:46:30 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] DAC960: kmalloc->kzalloc/Casting cleanups
Message-Id: <20070106094630.51aa62e8.randy.dunlap@oracle.com>
In-Reply-To: <20070106131725.GB19020@Ahmed>
References: <20070106131725.GB19020@Ahmed>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 15:17:25 +0200 Ahmed S. Darwish wrote:

> Hi all,
> I'm not able to find the DAC960 block driver maintainer. If someones knows
> please reply :).

It's orphaned.  Andrew can decide to merge this, or one of the
storage or block maintainers could possibly do that.
or it could go thru KJ, but then Andrew may still end up
merging it.


> A patch to switch kmalloc->kzalloc and to clean unneeded kammloc,
> pci_alloc_consistent casts
> 
> Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> 
> diff --git a/drivers/block/DAC960.c b/drivers/block/DAC960.c
> index 8d81a3a..4febe7f 100644
> --- a/drivers/block/DAC960.c
> +++ b/drivers/block/DAC960.c
> @@ -1373,8 +1373,7 @@ static boolean DAC960_V2_EnableMemoryMailboxInterface(DAC960_Controller_T
>    Controller->BounceBufferLimit = DAC690_V2_PciDmaMask;
>  
>    /* This is a temporary dma mapping, used only in the scope of this function */
> -  CommandMailbox =
> -	  (DAC960_V2_CommandMailbox_T *)pci_alloc_consistent( PCI_Device,
> +  CommandMailbox = pci_alloc_consistent(PCI_Device,
>  		sizeof(DAC960_V2_CommandMailbox_T), &CommandMailboxDMA);
>    if (CommandMailbox == NULL)
>  	  return false;
> @@ -1879,8 +1878,8 @@ static boolean DAC960_V2_ReadControllerConfiguration(DAC960_Controller_T
>        if (NewLogicalDeviceInfo->LogicalDeviceState !=
>  	  DAC960_V2_LogicalDevice_Offline)
>  	Controller->LogicalDriveInitiallyAccessible[LogicalDeviceNumber] = true;
> -      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
> -	kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
> +      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T),
> +				   GFP_ATOMIC);
>        if (LogicalDeviceInfo == NULL)
>  	return DAC960_Failure(Controller, "LOGICAL DEVICE ALLOCATION");
>        Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
> @@ -2113,8 +2112,8 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
>        if (!DAC960_V2_NewPhysicalDeviceInfo(Controller, Channel, TargetID, LogicalUnit))
>  	  break;
>  
> -      PhysicalDeviceInfo = (DAC960_V2_PhysicalDeviceInfo_T *)
> -		kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T), GFP_ATOMIC);
> +      PhysicalDeviceInfo = kmalloc(sizeof(DAC960_V2_PhysicalDeviceInfo_T),
> +				    GFP_ATOMIC);
>        if (PhysicalDeviceInfo == NULL)
>  		return DAC960_Failure(Controller, "PHYSICAL DEVICE ALLOCATION");
>        Controller->V2.PhysicalDeviceInformation[PhysicalDeviceIndex] =
> @@ -2122,8 +2121,8 @@ static boolean DAC960_V2_ReadDeviceConfiguration(DAC960_Controller_T
>        memcpy(PhysicalDeviceInfo, NewPhysicalDeviceInfo,
>  		sizeof(DAC960_V2_PhysicalDeviceInfo_T));
>  
> -      InquiryUnitSerialNumber = (DAC960_SCSI_Inquiry_UnitSerialNumber_T *)
> -	kmalloc(sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
> +      InquiryUnitSerialNumber = kmalloc(
> +	      sizeof(DAC960_SCSI_Inquiry_UnitSerialNumber_T), GFP_ATOMIC);
>        if (InquiryUnitSerialNumber == NULL) {
>  	kfree(PhysicalDeviceInfo);
>  	return DAC960_Failure(Controller, "SERIAL NUMBER ALLOCATION");
> @@ -4949,8 +4948,8 @@ static void DAC960_V2_ProcessCompletedCommand(DAC960_Command_T *Command)
>  	      PhysicalDevice.LogicalUnit = NewLogicalDeviceInfo->LogicalUnit;
>  	      Controller->V2.LogicalDriveToVirtualDevice[LogicalDeviceNumber] =
>  		PhysicalDevice;
> -	      LogicalDeviceInfo = (DAC960_V2_LogicalDeviceInfo_T *)
> -		kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T), GFP_ATOMIC);
> +	      LogicalDeviceInfo = kmalloc(sizeof(DAC960_V2_LogicalDeviceInfo_T),
> +					  GFP_ATOMIC);
>  	      Controller->V2.LogicalDeviceInformation[LogicalDeviceNumber] =
>  		LogicalDeviceInfo;
>  	      DAC960_Critical("Logical Drive %d (/dev/rd/c%dd%d) "
> @@ -5709,14 +5708,14 @@ static boolean DAC960_CheckStatusBuffer(DAC960_Controller_T *Controller,
>        unsigned int NewStatusBufferLength = DAC960_InitialStatusBufferSize;
>        while (NewStatusBufferLength < ByteCount)
>  	NewStatusBufferLength *= 2;
> -      Controller->CombinedStatusBuffer =
> -	(unsigned char *) kmalloc(NewStatusBufferLength, GFP_ATOMIC);
> +      Controller->CombinedStatusBuffer = kmalloc(NewStatusBufferLength, 
> +						  GFP_ATOMIC);
>        if (Controller->CombinedStatusBuffer == NULL) return false;
>        Controller->CombinedStatusBufferLength = NewStatusBufferLength;
>        return true;
>      }
> -  NewStatusBuffer = (unsigned char *)
> -    kmalloc(2 * Controller->CombinedStatusBufferLength, GFP_ATOMIC);
> +  NewStatusBuffer = kmalloc(2 * Controller->CombinedStatusBufferLength, 
> +			     GFP_ATOMIC);
>    if (NewStatusBuffer == NULL)
>      {
>        DAC960_Warning("Unable to expand Combined Status Buffer - Truncating\n",
> 
> 
> -- 


---
~Randy
