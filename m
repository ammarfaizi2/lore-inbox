Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTEPF2y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 01:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbTEPF2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 01:28:53 -0400
Received: from web80105.mail.yahoo.com ([66.163.169.78]:6918 "HELO
	web80105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264137AbTEPF2u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 01:28:50 -0400
Message-ID: <20030516054141.17385.qmail@web80105.mail.yahoo.com>
Date: Thu, 15 May 2003 22:41:41 -0700 (PDT)
From: Jordan Breeding <jordan.breeding@sbcglobal.net>
Subject: 2.5.69-mm5 errors in dmesg
To: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  When booting 2.5.69-mm5 I have two errors showing up
in dmesg, the first is the usb irq handler message
below which is listed multiple times at boot:

irq 16: nobody cared!
Call Trace:
 [<f010cf72>] report_bad_irq+0x3b/0x9c
 [<f010d042>] note_interrupt+0x6f/0x83
 [<f010d2d5>] do_IRQ+0xe7/0x193
 [<f010b608>] common_interrupt+0x18/0x20
 [<f03bdca0>] cfb_imageblit+0x390/0x610
 [<f010d349>] do_IRQ+0x15b/0x193
 [<f010b608>] common_interrupt+0x18/0x20
 [<f03b0ef3>] putcs_aligned+0x169/0x1ba
 [<f010cf0d>] handle_IRQ_event+0x3a/0x64
 [<f03b1274>] accel_putcs+0x93/0xc5
 [<f03b2982>] fbcon_redraw+0x1a2/0x209
 [<f03b306e>] fbcon_scroll+0x685/0xc5d
 [<f031f8ed>] scrup+0x12f/0x139
 [<f0321039>] lf+0x73/0x75
 [<f032397e>] vt_console_print+0x129/0x303
 [<f0123f3c>] __call_console_drivers+0x57/0x59
 [<f012402b>] call_console_drivers+0x78/0x113
 [<f01243a9>] release_console_sem+0x6f/0xf4
 [<f01242b9>] printk+0x18b/0x1d7
 [<f03c63f5>] usb_hcd_pci_probe+0x2ed/0x427
 [<f02e6aba>] pci_device_probe+0x5e/0x6c
 [<f0340f38>] bus_match+0x45/0x73
 [<f034103e>] driver_attach+0x59/0x5d
 [<f03412d4>] bus_add_driver+0xa9/0xbc
 [<f02e6bcf>] pci_register_driver+0x44/0x54
 [<f0655796>] uhci_hcd_init+0xd9/0x13b
 [<f0636874>] do_initcalls+0x27/0x93
 [<f01332f3>] init_workqueues+0xf/0x28
 [<f01050e2>] init+0x5a/0x1d0
 [<f0105088>] init+0x0/0x1d0
 [<f0108ab5>] kernel_thread_helper+0x5/0xb

handlers:
[<f03c3162>] (usb_hcd_irq+0x0/0x58)

  The second error message is a message from the
aic7xxx driver which I have seen before from some of
Justin's updates, I only get this error from my
Maxtor(Quantum) Atlas 10k III:

(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x83 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (56 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x83 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (56 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x83 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (56 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x83 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (56 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x83 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (56 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error
(scsi1:A:0:0): CDB: 0x12 0x1 0x80 0x0 0x60 0x0
(scsi1:A:0:0): Saw underflow (80 of 96 bytes). Treated
as error

  Please cc: me in replies, this is a new address and
I am not subscribed at it yet.

Jordan
