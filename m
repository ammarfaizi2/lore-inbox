Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTKKJ4Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 04:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTKKJ4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 04:56:16 -0500
Received: from yate.wa.csiro.au ([130.116.131.40]:1284 "EHLO
	yate.nexus.csiro.au") by vger.kernel.org with ESMTP id S264281AbTKKJ4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 04:56:13 -0500
Subject: [BUG] 2.4.23-rc1 USB2 (ICH4) ehci-hcd and usb-storage lockups
From: Frank Horowitz <itsme.mario.fghorow@spamgourmet.com>
Reply-To: itsme.mario.fghorow@spamgourmet.com
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1068544570.930.38.camel@bonzo.ned.dem.csiro.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 11 Nov 2003 17:56:11 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing repeatable lockups with the USB ehci-hcd driver and
usb-storage under vanilla 2.4.23-rc1. The "magic sys req key" chords do
not allow recovery. 

Under the usb-uhci driver, all works well (but slowly ;-).

Recipe to recreate problem:
modprobe usb-storage with ehci-hcd already loaded. Mount an ext3
filesystem in external USB2->IDE case. Try to cp ~15Gb tar file to fs
mounted on /dev/hdc1 and the messages logged below are written to
/var/log/debug. After last message, console shows "usb_control/bulk_msg:
timeout" and system hangs. 

Config: SMP. Modularized everything relevant to USB. usb-storage
compiled with debug enabled (see log).
Chipset: Intel E7505 (ICH4 controlling USB2)
Dual Xeon 2.4GHz, 2 Gig RAM (CONFIG_HIGHMEM4G=y)

Relevant portion of logfile:

Nov 11 16:43:20 bonzo kernel: usb-storage: queuecommand() called
Nov 11 16:43:20 bonzo kernel: usb-storage: *** thread awakened.
Nov 11 16:43:20 bonzo kernel: usb-storage: Command READ_10 (10 bytes)
Nov 11 16:43:20 bonzo kernel: usb-storage: 28 00 00 00 00 00 00 00 fe 00
00 00
Nov 11 16:43:20 bonzo kernel: usb-storage: Bulk command S 0x43425355 T
0x6 Trg 0 LUN 0 L 130048 F 128 CL 10
Nov 11 16:43:20 bonzo kernel: usb-storage: Bulk command transfer
result=0
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_transfer_partial():
xfer 4096 bytes
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_bulk_msg() returned
0 xferred 4096/4096
[***Many duplicates of last 2 messages removed for brevity***]
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_bulk_msg() returned
0 xferred 4096/4096
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_transfer_partial():
transfer complete
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_transfer_partial():
xfer 3072 bytes
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_bulk_msg() returned
0 xferred 3072/3072
Nov 11 16:43:20 bonzo kernel: usb-storage: usb_stor_transfer_partial():
transfer complete
Nov 11 16:43:20 bonzo kernel: usb-storage: Bulk data transfer result 0x0
Nov 11 16:43:20 bonzo kernel: usb-storage: Attempting to get CSW...
Nov 11 16:43:50 bonzo kernel: usb-storage: command_abort() called
Nov 11 16:43:50 bonzo kernel: usb-storage: -- transport indicates
command was aborted
Nov 11 16:43:50 bonzo kernel: usb-storage: Bulk reset requested
Nov 11 16:43:55 bonzo kernel: usb-storage: Bulk soft reset failed -110
Nov 11 16:43:55 bonzo kernel: usb-storage: scsi command aborted
Nov 11 16:43:55 bonzo kernel: usb-storage: *** thread sleeping.
Nov 11 16:43:55 bonzo kernel: usb-storage: queuecommand() called
Nov 11 16:43:55 bonzo kernel: usb-storage: *** thread awakened.
Nov 11 16:43:55 bonzo kernel: usb-storage: Command TEST_UNIT_READY (6
bytes)
Nov 11 16:43:55 bonzo kernel: usb-storage: 00 00 00 00 00 00 00 00 fe 00
00 00
Nov 11 16:43:55 bonzo kernel: usb-storage: Bulk command S 0x43425355 T
0x7 Trg 0 LUN 0 L 0 F 0 CL 6
Nov 11 16:43:55 bonzo kernel: usb-storage: Bulk command transfer
result=0
Nov 11 16:43:55 bonzo kernel: usb-storage: Attempting to get CSW...
Nov 11 16:44:05 bonzo kernel: usb-storage: command_abort() called
Nov 11 16:44:05 bonzo kernel: usb-storage: -- transport indicates
command was aborted
Nov 11 16:44:05 bonzo kernel: usb-storage: Bulk reset requested

TIA for any help...

	Frank Horowitz


