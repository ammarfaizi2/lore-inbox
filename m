Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311626AbSCNOcf>; Thu, 14 Mar 2002 09:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311627AbSCNOcZ>; Thu, 14 Mar 2002 09:32:25 -0500
Received: from smtp.actcom.co.il ([192.114.47.13]:3235 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S311626AbSCNOcQ>; Thu, 14 Mar 2002 09:32:16 -0500
Message-Id: <200203141432.g2EEWL628078@lmail.actcom.co.il>
Content-Type: text/plain; charset=US-ASCII
From: Itai Nahshon <nahshon@actcom.co.il>
To: Greg KH <greg@kroah.com>
Subject: USB-Storage in 2.4.19-pre
Date: Thu, 14 Mar 2002 16:32:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have used usb-storage with stock redhat kernels for some times. That is usable
with just few problems. Recently I switched to 2.4.17, and then to 2.4.19-pre1.

On the stock redhat kernels (up to the latest update 2.4.9-31) and on 2.4.17  I had to
umount the disk before shutdown. Normal shutdown did not unmount the disk cleanly.
It looks like the scsi layer lost access to the physical disk - maybe after unmouting
of usbdevfs. (even when I unmount the disk I had some scsi errors reported).

This problem was fixed with 2.4.19-pre1.

Now I'm trying the latest changes. 2.4.19-pre2-ac{3.4} and 2.4.19-pre3 and I cannot
use usb-storage at all. I get all kind of erros similar to these:

Mar 14 13:41:06 itai kernel: hub.c: USB new device connect on bus1/2, assigned device number 2
Mar 14 13:41:06 itai kernel: usb-uhci.c: interrupt, status 2, frame# 673
Mar 14 13:41:06 itai kernel: usb.c: USB device not responding, giving up (error=-84)
Mar 14 13:41:09 itai kernel: hub.c: USB new device connect on bus1/2, assigned device number 3
Mar 14 13:41:09 itai kernel: usb.c: USB device not responding, giving up (error=-84)


Switching back to 2.4.19-pre1 - It looks like the disk is reported too early. The Vendor-Model-Rev
fields are still empty. (Is it just cosmetics or a real problem?)

Mar 14 15:02:19 itai kernel: hub.c: USB new device connect on bus1/2, assigned device number 3
Mar 14 15:02:19 itai kernel: usb.c: USB device 3 (vend/prod 0x4e6/0x1) is not claimed by any active driver.
Mar 14 15:02:19 itai kernel: Initializing USB Mass Storage driver...
Mar 14 15:02:19 itai kernel: usb.c: registered new driver usb-storage
Mar 14 15:02:19 itai kernel: scsi2 : SCSI emulation for USB Mass Storage devices
Mar 14 15:02:19 itai kernel:   Vendor:           Model:                   Rev:
Mar 14 15:02:19 itai kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 14 15:02:19 itai kernel: Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
Mar 14 15:02:20 itai kernel: SCSI device sdb: 33750865 512-byte hdwr sectors (17280 MB)
Mar 14 15:02:20 itai kernel:  sdb: sdb1 sdb2 sdb4 < sdb5 >
Mar 14 15:02:20 itai kernel: USB Mass Storage support registered.

And from /proc/scsi/scsi:

Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor 9 Model: 1728D8           Rev: GAS5
  Type:   Direct-Access                    ANSI SCSI revision: 02

-- Itai
