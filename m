Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSDNJyi>; Sun, 14 Apr 2002 05:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311948AbSDNJyh>; Sun, 14 Apr 2002 05:54:37 -0400
Received: from hssx-sktn-167-47.sasknet.sk.ca ([142.165.167.47]:35718 "HELO
	mail.thock.com") by vger.kernel.org with SMTP id <S311936AbSDNJyd>;
	Sun, 14 Apr 2002 05:54:33 -0400
Message-ID: <3CB951D7.7090107@thock.com>
Date: Sun, 14 Apr 2002 03:54:31 -0600
From: Dylan Griffiths <dylang+kernel@thock.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9+) Gecko/20020412
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Sandisk USB CF reader and 2.4.18; usb-storage bug?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two problems here.  The first is that even after poking in SCSI's core, 
modprobing usb-storage hangs and is unkillable:

Module                  Size  Used by
usb-storage            53360   2  (initializing)
...
scsi_mod               83376   3  [usb-storage sd_mod sg]
...
usbcore                49088   1  [usb-storage dc2xx hid uhci]

The dmesg (w/ verbose) looks like this:

SCSI subsystem driver Revision: 1.00
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
usb-storage: act_altsettting is 0
usb-storage: id_index calculated to be: 36
usb-storage: Array length appears to be: 64
usb-storage: Vendor: Sandisk
usb-storage: Product: ImageMate SDDR-31
usb-storage: USB Mass Storage device detected
usb-storage: Endpoints: In: 0xc749a880 Out: 0xc749a894 Int: 0x00000000 
(Period 0)
usb-storage: New GUID 078100020000000000000000
usb-storage: GetMaxLUN command result is -32, data is 220
usb-storage: clearing endpoint halt for pipe 0x80000480
usb-storage: Transport: Bulk
usb-storage: Protocol: Transparent SCSI
usb-storage: *** thread sleeping.
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: queuecommand() called
usb-storage: *** thread awakened.
usb-storage: Command INQUIRY (6 bytes)
usb-storage: 12 00 00 00 ff 00 00 00 15 bb 1a c0
usb-storage: Bulk command S 0x43425355 T 0x1 Trg 0 LUN 0 L 255 F 128 CL 6
usb-storage: Bulk command transfer result=0
usb-storage: usb_stor_transfer_partial(): xfer 255 bytes
usb-storage: usb_stor_bulk_msg() returned 0 xferred 56/255
usb-storage: Bulk data transfer result 0x1
usb-storage: Attempting to get CSW...
usb-storage: command_abort() called
usb-storage: Bulk status result = -104
usb-storage: Bulk reset requested
usb-storage: Bulk soft reset failed -32
usb-storage: -- transport indicates transport failure
usb-storage: Fixing INQUIRY data to show SCSI rev 2
usb-storage: scsi cmd done, result=0x70000
usb-storage: *** thread sleeping.


Bug or no?  It never finishes initialization, and never wakes up, and 
/dev/sda never works properly.
SCSI reads:

/proc/scsi$ cat scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor:          Model:                  Rev:
   Type:   <NULL>                ANSI SCSI revision: ffffffff


Note: Please CC me as I'm not on the list..

-- 
     www.kuro5hin.org -- technology and culture, from the trenches.
                          -=-=-=-=-=-
"This chart is a visual representation of amici's understanding of
the decline of the growth of public domain as a result of repeated
  copyright term extensions."
  http://eon.law.harvard.edu/openlaw/eldredvashcroft/pubdomain.html
                          -=-=-=-=-=-


