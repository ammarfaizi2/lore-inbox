Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317675AbSG2DkS>; Sun, 28 Jul 2002 23:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317697AbSG2DkR>; Sun, 28 Jul 2002 23:40:17 -0400
Received: from babel.apana.org.au ([202.12.88.4]:61956 "EHLO
	babel.apana.org.au") by vger.kernel.org with ESMTP
	id <S317675AbSG2DkR>; Sun, 28 Jul 2002 23:40:17 -0400
Date: Mon, 29 Jul 2002 13:43:34 +1000
From: John August <johna@babel.apana.org.au>
To: linux-kernel@vger.kernel.org
Subject: Fuji 1300, 2.4.18, help wanted partition read
Message-ID: <20020729134334.A1620@babel.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've a problem when reading this device with 2.4.18. The most obvious
source of the problem is that when reading the partition table, a 4096
byte read is performed, but on the earler 2.4.10 kernel when it works,
the read is 1024 bytes and this is performed successfully.

I'm assuming that the problem might be fixed by "forcing" a 1024 byte
read at this point, so I need to understand how the command which 
eventually reads the device is generated from the kernel.

I note the routine check_partition occurs in linux/fs/partition/check.c,
and this seems to output the partition information to the screen.  I'm
not sure where the request to read partition information from the device
is actually generated, if people could fill me in on this, or point me
to relevant information, that would be appreciated.

(Ideally, it would be a .h definition somewhere, but I would not know
where)

Here's where it fails :

usb-storage: Command READ_10 (10 bytes)
usb-storage: 28 00 00 00 00 00 00 00 08 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 4096 bytes
usb-storage: USB IRQ recieved for device on host 0
usb-storage: -- IRQ data length is 2
usb-storage: -- IRQ state is 0
usb-storage: -- Interrupt Status (0x0, 0x0)
usb-storage: -- Current value of ip_waitq is: 0
usb-storage: command_abort() called
usb-storage: usb_stor_bulk_msg() returned -104 xferred 4032/4096
usb-storage: usb_stor_transfer_partial(): unknown error
usb-storage: CBI data stage result is 0x2
usb-storage: Current value of ip_waitq is: 1
usb-storage: Got interrupt data (0x0, 0x0)
usb-storage: scsi cmd done, result=0x0
usb-storage: *** thread sleeping.

Here's where it works :

usb-storage: Command READ_10 (10 bytes)
usb-storage: 28 00 00 00 00 00 00 00 02 00 00 00
usb-storage: Call to usb_stor_control_msg() returned 12
usb-storage: usb_stor_transfer_partial(): xfer 1024 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 1024/1024
...

Byte 8 of the command stream, corresponding to a READ_10 (scsi?)
command is where the difference is. I believe the command originates
with a partition check, I just need to know where along the way this
value is set.

Thanks for for any help. I'm not on the list, please copy emails to
me.

John August

