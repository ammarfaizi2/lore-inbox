Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRAKLOI>; Thu, 11 Jan 2001 06:14:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129842AbRAKLN7>; Thu, 11 Jan 2001 06:13:59 -0500
Received: from barn.holstein.com ([198.134.143.193]:22026 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S129324AbRAKLNk>;
	Thu, 11 Jan 2001 06:13:40 -0500
Message-Id: <3A5D94B4.DD8511D1@holstein.com>
Date: Thu, 11 Jan 2001 06:10:44 -0500
From: "Todd M. Roy" <troy@holstein.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-ac6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: scsi/zip mounting problem with 2.4.0-ac4/6 (at least)
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 01/11/2001 06:08:38 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 01/11/2001 06:08:38 AM,
	Serialize complete at 01/11/2001 06:08:38 AM
X-Priority: 3 (Normal)
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan and All,

I've detected a bug somewhere in 2.4.0-acX, at least in ac4,
the first ac kernel I built.  It seems that I can't mount
a scsi zip disk in, unless the following has occurred:

1.  There is a disk in the zip drive when I boot.

2.  I fdisk the scsi block device and re-write the partition
    table.  (I accidently discovered this).

in other words I get this:
mount: /dev/sda4 is not a valid block device.
If I try to insert a zipdisk and mount it after I boot up.

This problem does NOT occur as late as 2.4.0-final.

Specifics of my system:

The SCSI board is a real cheap SYM810A based Fast SCSI-2 PCI board.

I use the sym53c8xx driver built in, as is scsi disk support.
The only thing I use the scsi board for is the external zip 100
drive.

It still occurs in ac6.  (I've only build ac4 and 6).

Here is the specifics from a dmesg of 2.4.0 booting:
(2.4.0-ac4 and 6) is the same.
SCSI subsystem driver Revision: 1.00
sym53c8xx: at PCI bus 0, device 13, function 0
sym53c8xx: setting PCI_COMMAND_PARITY...(fix-up)
sym53c8xx: 53c810a detected 
sym53c810a-0: rev 0x12 on pci bus 0 device 13 function 0 irq 10
sym53c810a-0: ID 7, Fast-10, Parity Checking
sym53c810a-0: restart (scsi reset).
scsi0 : sym53c8xx - version 1.6b
  Vendor: IOMEGA    Model: ZIP 100           Rev: C.22
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi removable disk sda at scsi0, channel 0, id 5, lun 0
sym53c810a-0-<5,*>: target did not report SYNC.
sym53c810a-0-<5,*>: target did not report SYNC.
sym53c810a-0-<5,*>: target did not report SYNC.
sym53c810a-0-<5,*>: target did not report SYNC.
sym53c810a-0-<5,*>: target did not report SYNC.
sda : READ CAPACITY failed.
sda : status = 1, message = 00, host = 0, driver = 28 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 unable to read partition table

Thanks,
  Todd
**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
