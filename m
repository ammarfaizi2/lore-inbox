Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVGKXd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVGKXd7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 19:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbVGKXdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 19:33:55 -0400
Received: from smtp2.nbnz.co.nz ([202.49.143.67]:7696 "HELO smtp2.nbnz.co.nz")
	by vger.kernel.org with SMTP id S262282AbVGKXdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 19:33:09 -0400
Message-ID: <40BC5D4C2DD333449FBDE8AE961E0C334F9389@psexc03.nbnz.co.nz>
From: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
To: "'Alan Stern'" <stern@rowland.harvard.edu>
Cc: "'Kernel development list'" <linux-kernel@vger.kernel.org>,
       "'USB development list'" <linux-usb-devel@lists.sourceforge.net>
Subject: RE: [linux-usb-devel] Kernel unable to read partition table on US
	B Memory Key
Date: Tue, 12 Jul 2005 11:32:52 +1200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

>How about the patch below instead?  It's a bit easier to use, in that it 
>doesn't require users to know about a new parameter.  Also it retries at 
>1-second intervals for up to 5 seconds, which makes it a little more 
>flexible.  If this works for you, I'll submit it for inclusion in the 
>official kernel.

Thanks; this patch works nicely for me, as can be seen here (the two-second
delay occurs before "ready" below):

Jul 12 11:22:20 pc196344 kernel: usb 1-6: new high speed USB device using
ehci_hcd and address 12
Jul 12 11:22:20 pc196344 kernel: scsi9 : SCSI emulation for USB Mass Storage
devices
Jul 12 11:22:20 pc196344 kernel: usb-storage: device found at 12
Jul 12 11:22:20 pc196344 kernel: usb-storage: waiting for device to settle
before scanning
Jul 12 11:22:22 pc196344 kernel:   Vendor: OTi       Model: Flash Disk
Rev: 2.00
Jul 12 11:22:22 pc196344 kernel:   Type:   Direct-Access
ANSI SCSI revision: 02
Jul 12 11:22:24 pc196344 kernel: ready
Jul 12 11:22:24 pc196344 kernel: SCSI device sda: 255488 512-byte hdwr
sectors (131 MB)
Jul 12 11:22:24 pc196344 kernel: sda: Write Protect is off
Jul 12 11:22:24 pc196344 kernel: sda: Mode Sense: 03 00 00 00
Jul 12 11:22:24 pc196344 kernel: sda: assuming drive cache: write through
Jul 12 11:22:24 pc196344 kernel: SCSI device sda: 255488 512-byte hdwr
sectors (131 MB)
Jul 12 11:22:24 pc196344 kernel: sda: Write Protect is off
Jul 12 11:22:24 pc196344 kernel: sda: Mode Sense: 03 00 00 00
Jul 12 11:22:24 pc196344 kernel: sda: assuming drive cache: write through
Jul 12 11:22:24 pc196344 kernel:  /dev/scsi/host9/bus0/target0/lun0: p1
Jul 12 11:22:24 pc196344 kernel: Attached scsi removable disk sda at scsi9,
channel 0, id 0, lun 0
Jul 12 11:22:24 pc196344 kernel: Attached scsi generic sg2 at scsi9, channel
0, id 0, lun 0,  type 0
Jul 12 11:22:24 pc196344 kernel: usb-storage: device scan complete
Jul 12 11:22:24 pc196344 scsi.agent[27155]: disk at
/devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.0/host9/target9:0:0/9:0:0:0
Jul 12 11:26:43 pc196344 kernel: usb 1-6: USB disconnect, address 12

Also, I checked with my older key, and as expected there was no problem
there either (patch had no effect):

Jul 12 11:26:55 pc196344 kernel: usb 4-2: new full speed USB device using
uhci_hcd and address 2
Jul 12 11:26:56 pc196344 kernel: scsi10 : SCSI emulation for USB Mass
Storage devices
Jul 12 11:26:56 pc196344 kernel: usb-storage: device found at 2
Jul 12 11:26:56 pc196344 kernel: usb-storage: waiting for device to settle
before scanning
Jul 12 11:26:58 pc196344 kernel:   Vendor: IBM       Model: Memory Key
Rev: 1.01
Jul 12 11:26:58 pc196344 kernel:   Type:   Direct-Access
ANSI SCSI revision: 00
Jul 12 11:26:58 pc196344 kernel: SCSI device sda: 64000 512-byte hdwr
sectors (33 MB)
Jul 12 11:26:58 pc196344 kernel: sda: Write Protect is off
Jul 12 11:26:58 pc196344 kernel: sda: Mode Sense: 43 00 00 00
Jul 12 11:26:58 pc196344 kernel: sda: assuming drive cache: write through
Jul 12 11:26:58 pc196344 kernel: SCSI device sda: 64000 512-byte hdwr
sectors (33 MB)
Jul 12 11:26:58 pc196344 kernel: sda: Write Protect is off
Jul 12 11:26:58 pc196344 kernel: sda: Mode Sense: 43 00 00 00
Jul 12 11:26:58 pc196344 kernel: sda: assuming drive cache: write through
Jul 12 11:26:58 pc196344 kernel:  /dev/scsi/host10/bus0/target0/lun0: p1
Jul 12 11:26:58 pc196344 kernel: Attached scsi removable disk sda at scsi10,
channel 0, id 0, lun 0
Jul 12 11:26:58 pc196344 kernel: Attached scsi generic sg2 at scsi10,
channel 0, id 0, lun 0,  type 0
Jul 12 11:26:58 pc196344 kernel: usb-storage: device scan complete
Jul 12 11:26:58 pc196344 scsi.agent[27309]: disk at
/devices/pci0000:00/0000:00:1d.2/usb4/4-2/4-2:1.0/host10/target10:0:0/10:0:0
:0

So, works very well.  Thanks very much for your help in solving this issue,
and hopefully we'll see this patch in 2.6.13 onwards.

James Roberts-Thomson
----------
Hardware:  The parts of a computer system that can be kicked.

Mailing list Readers:  Please ignore the following disclaimer - this email
is explicitly declared to be non confidential and does not contain
privileged information.

This communication is confidential and may contain privileged material.
If you are not the intended recipient you must not use, disclose, copy or retain it.
If you have received it in error please immediately notify me by return email
and delete the emails.
Thank you.
