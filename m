Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261642AbSK0G6c>; Wed, 27 Nov 2002 01:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261615AbSK0G6c>; Wed, 27 Nov 2002 01:58:32 -0500
Received: from 12-241-212-92.client.attbi.com ([12.241.212.92]:5251 "EHLO
	stinkycat.com") by vger.kernel.org with ESMTP id <S261609AbSK0G62>;
	Wed, 27 Nov 2002 01:58:28 -0500
Date: Tue, 26 Nov 2002 22:41:50 -0800
From: Rusty Lynch <rusty@stinkycat.com>
Message-Id: <200211270641.gAR6foX11138@stinkycat.com>
To: patsman@us.ibm.com
Subject: Re:[BUG][2.5.49 SCSI]Duplicate Proc Entries for SCSI
Cc: groudier@free.fr, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 14:24, Patrick Mansfield wrote:
> Did you figure out anything? Was there anything of interest in your dmesg?
> 
> I tried out 2.5.49, and all scsi devices showed up just once, both for
> the aic driver built into the kernel, and for qla driver built as a
> module, with SCSI revision 2 and 3 devices attached to the qla.
> 
> Maybe it is specific to ide-scsi or the usb-scsi pseudo adapter drivers.
> 

I only see the duplicate entries when I have the "Probe All LUNs on
each  SCI device (SCSI_MULTI_LUN) turned on.

To make things more complicated, my flash drive doesn't seem to be
working (I have never got this cheap little flash drive to work on
Linux and it just barely works on Windows), but cdrom is doing the
same thing.

Here is what I see when I plug in usb flash reader:
scsi logging level set to 0x00000100
drivers/usb/core/hub.c: new USB device 00:1f.4-2.2, assigned address 3
Product: USB to CF + SM Combo (LC1)
Manufacturer: DataFab Systems Inc.
SerialNumber: B574D25574
scsi0 : SCSI emulation for USB Mass Storage devices
scsi scan: INQUIRY to host 0 channel 0 id 0 lun 0
scsi scan: 1st INQUIRY successful with code 0x0
  Vendor: Datafab   Model: USB to CF + SM C  Rev: 0017
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi scan: host 0 channel 0 id 0 lun 0 name/id: ''
scsi scan: Sequential scan of host 0 channel 0 id 0
scsi scan: INQUIRY to host 0 channel 0 id 0 lun 1
scsi scan: 1st INQUIRY successful with code 0x0
  Vendor: Datafab   Model: USB to CF + SM C  Rev: 0017
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi scan: host 0 channel 0 id 0 lun 1 name/id: ''
scsi scan: INQUIRY to host 0 channel 0 id 0 lun 2
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 1 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 2 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 3 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 4 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 5 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 6 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000
scsi scan: INQUIRY to host 0 channel 0 id 7 lun 0
scsi scan: 1st INQUIRY failed with code 0x40000

If I turn off the multi lun option the I see the same
output minus the:
scsi scan: Sequential scan of host 0 channel 0 id 0

... and the extra:
  Vendor: Datafab   Model: USB to CF + SM C  Rev: 0017
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi scan: host 0 channel 0 id 0 lun 1 name/id: ''
scsi scan: INQUIRY to host 0 channel 0 id 0 lun 2

This is one of those Compaq/SmartMedia combo drives so
maybe that is screwing things up, except the cdrom does
the same thing.

Oh well, the cdrom appears to be working, so the duplicate /proc/scsi/scsi might just be cosmetic.

	-rusty

> Try turning on scsi scan logging before inserting the flash card via:
> 
> echo scsi log scan 4  >/proc/scsi/scsi
> 
> And send the output.
> 
> My single lun scsi 2 disks display the following, showing that
> lun 1 is (correctly) not configured off of id 1 and id 2:
> 
> [ junk deleted ]
> scsi scan: INQUIRY to host 2 channel 0 id 1 lun 0
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
>   Vendor: SEAGATE   Model: ST39173F CLAR09   Rev: 351B
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi scan: host 2 channel 0 id 1 lun 0 name/id: '32000002037109657'
> scsi scan: Sequential scan of host 2 channel 0 id 1
> scsi scan: INQUIRY to host 2 channel 0 id 1 lun 1
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
> scsi scan: peripheral qualifier of 3, no device added
> scsi scan: INQUIRY to host 2 channel 0 id 2 lun 0
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
>   Vendor: SEAGATE   Model: ST39173F CLAR09   Rev: 351B
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi scan: host 2 channel 0 id 2 lun 0 name/id: '32000002037109db0'
> scsi scan: Sequential scan of host 2 channel 0 id 2
> scsi scan: INQUIRY to host 2 channel 0 id 2 lun 1
> scsi scan: 1st INQUIRY successful with code 0x0
> scsi scan: 2nd INQUIRY successful with code 0x0
> scsi scan: peripheral qualifier of 3, no device added
> [ lots of stuff deleted, as this fcp adapter goes up to id 255 ]
> 
> -- Patrick Mansfield

