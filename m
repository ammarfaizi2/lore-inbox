Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261830AbVE3X2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261830AbVE3X2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 19:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVE3X0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 19:26:18 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:5346 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S261822AbVE3XYS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 19:24:18 -0400
Message-ID: <429BA001.2030405@keyaccess.nl>
Date: Tue, 31 May 2005 01:21:37 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: External USB2 HDD affects speed hda
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej.

My Maxtor 6Y120P0 on AMD756 (UDMA66) normally gives me 50 MB/s according 
to hdparm -t:

===
# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  152 MB in  3.01 seconds =  50.57 MB/sec
===

However, the second I switch on my external USB2 drive (Western Digital 
Essential 160G, connected via a PCI card USB2 controller, on a private IRQ):

===
usb 1-3: new high speed USB device using ehci_hcd and address 3
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
   Vendor: WD        Model: 1600BB External   Rev: 0412
   Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: assuming drive cache: write through
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: assuming drive cache: write through
  sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
usb-storage: device scan complete
===

the hdparm -t result drops down to 42MB/s:

===
# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  130 MB in  3.04 seconds =  42.77 MB/sec
===

Switching the USB2 HDD off again does not work to bring back the 50 MB/s:

===
# eject sda
# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  128 MB in  3.01 seconds =  42.57 MB/sec

[ push button ]

usb 1-3: USB disconnect, address 3

# hdparm -t /dev/hda

/dev/hda:
  Timing buffered disk reads:  130 MB in  3.04 seconds =  42.73 MB/sec
===

After a reboot, it's 50 MB/s again. Any idea what this is?

The USB HDD is not firing interrupts or anything. It just sits idle. 
Fully repeatable on 2.6.11.11 and 2.6.12-rc5.

Rene.
