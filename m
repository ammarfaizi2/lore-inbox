Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265222AbUJNO3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265222AbUJNO3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUJNO3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 10:29:54 -0400
Received: from ida.rowland.org ([192.131.102.52]:4868 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S265222AbUJNO0y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 10:26:54 -0400
Date: Thu, 14 Oct 2004 10:26:53 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Ganesan R <rganesan@myrealbox.com>
cc: John Stoffel <stoffel@lucent.com>, <linux-kernel@vger.kernel.org>,
       <linux-usb-devel@lists.sourceforge.net>,
       <torsten.scherer@uni-bielefeld.de>
Subject: Re: [linux-usb-devel] Re: Linux 2.6.x wrongly recognizes USB 2.0
 DVD writer
In-Reply-To: <416E7E39.4040102@myrealbox.com>
Message-ID: <Pine.LNX.4.44L0.0410141025360.952-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Oct 2004, Ganesan R wrote:

> Thanks for the info. As I mentioned, the enclosure works flawlessly for 
> me under 2.4.27. It's getting detected incorrectly only in 2.6.x. 
> Another user reported a similar problem but was able to get dvd burning 
> working by removing the checks from the writing tool. So, it looks like 
> detection has been messed up only in 2.6.x.
> 
> Once again, 2.6.8 reports it as
> 
> ======
> scsi3 : SCSI emulation for USB Mass Storage devices
>   Vendor: Revoltec  Model: USB/IDE Bridge (  Rev: 0103
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> Attached scsi removable disk sdb at scsi3, channel 0, id 0, lun 0
> ======
> 
> whereas 2.4.27 correctly reports
> 
> ========                                                               
> scsi2 : SCSI emulation for USB Mass Storage                            
>    Vendor: _NEC      Model: DVD_RW ND-2500A                            
>    Type:   CD-ROM    ANSI SCSI revision: 02                            
> Attached scsi CD-ROM sr1 at scsi2, channel 0, id 0, lun 0              
> sr1: scsi-1 drive                                                      
> USB Mass Storage support registered.                                   
> ========                                                               
> 
> I checked the kernel sources. Sure enough, 
> drivers/usb/storage/unusual_devs.h
> has a new entry in the 2.6 tree:
> 
> ========
> /* <torsten.scherer@uni-bielefeld.de>: I don't know the name of the bridge
>  * manufacturer, but I've got an external USB drive by the Revoltec company
>  * that needs this. otherwise the drive is recognized as /dev/sda, but any
>  * access to it blocks indefinitely.
>  */
> UNUSUAL_DEV(  0x0402, 0x5621, 0x0103, 0x0103,
>         "Revoltec",
>         "USB/IDE Bridge (ATA/ATAPI)",
>         US_SC_DEVICE, US_PR_DEVICE, NULL, US_FL_FIX_INQUIRY),
> ========
> 
> I have not yet tested after removing this entry, but this looks to be 
> the likely problem. The enclosure actually supports both 3.5 IDE hard 
> disks as well as 5.25 CD/DVD drives. I have no clue why this entry 
> should cause the drive to be wrongly detected. CCing linux-usb-devel for 
> help.

Certainly that entry is the problem.  It has been removed in the latest 
development kernels; it may already be gone in 2.6.9-rc4.

Alan Stern

