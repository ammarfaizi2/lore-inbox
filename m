Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSIRBdA>; Tue, 17 Sep 2002 21:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264909AbSIRBdA>; Tue, 17 Sep 2002 21:33:00 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39644 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264903AbSIRBc6>; Tue, 17 Sep 2002 21:32:58 -0400
Date: Tue, 17 Sep 2002 21:37:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200209180137.g8I1bwB09553@devserv.devel.redhat.com>
To: Mark C <gen-lists@blueyonder.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems accessing USB Mass Storage
In-Reply-To: <mailman.1032306001.9987.linux-kernel2news@redhat.com>
References: <1032261937.1170.13.camel@stimpy.angelnet.internal>   <20020917151816.GB2144@kroah.com> <3D876861.9000601@cypress.com>   <20020917174631.GD2569@kroah.com> <20020917234302.A26741@bitwizard.nl>   <3D87A6E3.5090407@cypress.com>    <20020917152102.A17561@eng2.beaverton.ibm.com> <mailman.1032306001.9987.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You should be able to run the equivalent:
>> 
>> 	dd if=/dev/sda of=/dev/zero bs=512 count=8
> 
> I done that and please find the output below:

> SCSI device sda: 16384 512-byte hdwr sectors (8 MB)
> usb-storage: queuecommand() called
> usb-storage: *** thread awakened.
> usb-storage: Command MODE_SENSE (6 bytes)
> usb-storage: 1a 00 3f 00 ff 00 00 00 00 00 e9 df
> usb-storage: Bulk command S 0x43425355 T 0x23 Trg 0 LUN 0 L 255 F 128 CL
> 6
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
> usb-storage: usb_stor_bulk_msg() returned -32 xferred 0/255
> usb-storage: clearing endpoint halt for pipe 0xc0038280
> usb-storage: usb_stor_clear_halt: result=0
> usb-storage: usb_stor_transfer_partial(): unknown error
> usb-storage: Bulk data transfer result 0x2
> usb-storage: Attempting to get CSW...
> usb-storage: Bulk status result = 0
> usb-storage: Bulk status Sig 0x53425355 T 0x23 R 255 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk command S 0x43425355 T 0x23 Trg 0 LUN 0 L 18 F 128 CL
> 6
> usb-storage: Bulk command transfer result=0
> usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
> usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
> usb-storage: usb_stor_transfer_partial(): transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: Bulk status result = 0
> usb-storage: Bulk status Sig 0x53425355 T 0x23 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x5, ASC: 0x24, ASCQ: 0x0
> usb-storage: Illegal Request: invalid field in CDB
> usb-storage: scsi cmd done, result=0x2
> usb-storage: *** thread sleeping.
> sda: test WP failed, assume Write Enabled
>  sda: I/O error: dev 08:00, sector 0
>  I/O error: dev 08:00, sector 0
>  unable to read partition table
  <------------------------------------ this is wrong. Error without a command.
> usb-storage: queuecommand() called
> usb-storage: *** thread awakened.
> usb-storage: Command ALLOW_MEDIUM_REMOVAL (6 bytes)
> usb-storage: 1e 00 00 00 01 00 d7 d4 b7 1e 14 c0
> usb-storage: Bulk command S 0x43425355 T 0x24 Trg 0 LUN 0 L 0 F 0 CL 6
> usb-storage: Bulk command transfer result=0
> usb-storage: Attempting to get CSW...
> usb-storage: Bulk status result = 0
> usb-storage: Bulk status Sig 0x53425355 T 0x24 R 0 Stat 0x0
> usb-storage: scsi cmd done, result=0x0
> usb-storage: *** thread sleeping.
>  I/O error: dev 08:00, sector 0

Seems like media check gets confused.

The missing MODE SENSE is bad, but not fatal. Everything should work.

-- Pete
