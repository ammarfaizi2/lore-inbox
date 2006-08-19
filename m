Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWHSTpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWHSTpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWHSTpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 15:45:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42468 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750955AbWHSTpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 15:45:49 -0400
Date: Sat, 19 Aug 2006 15:45:37 -0400
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: plugging usb disk gets lockdep warning
Message-ID: <20060819194537.GE25402@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I plugged in my mp3 player, and this happened..

usb 5-7.3: new high speed USB device using ehci_hcd and address 6
PM: Adding info for usb:5-7.3
PM: Adding info for No Bus:usbdev5.6_ep00
usb 5-7.3: configuration #2 chosen from 1 choice
PM: Adding info for usb:5-7.3:2.0
scsi4 : SCSI emulation for USB Mass Storage devices
PM: Adding info for No Bus:host4
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
PM: Adding info for No Bus:usbdev5.6_ep82
PM: Adding info for No Bus:usbdev5.6_ep01
PM: Adding info for No Bus:usbdev5.6_ep83
PM: Adding info for No Bus:target4:0:0
usb 5-7.3: reset high speed USB device using ehci_hcd and address 6
PM: Removing info for No Bus:usbdev5.6_ep82
PM: Removing info for No Bus:usbdev5.6_ep01
PM: Removing info for No Bus:usbdev5.6_ep83
PM: Adding info for No Bus:usbdev5.6_ep82
PM: Adding info for No Bus:usbdev5.6_ep01
PM: Adding info for No Bus:usbdev5.6_ep83
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.

Call Trace:
 [<ffffffff8026e8fd>] show_trace+0xae/0x319
 [<ffffffff8026eb7d>] dump_stack+0x15/0x17
 [<ffffffff802a826a>] __lock_acquire+0x135/0xa64
 [<ffffffff802a913c>] lock_acquire+0x4b/0x69
 [<ffffffff80267b3f>] _spin_lock_irq+0x2b/0x38
 [<ffffffff802655b3>] wait_for_completion_timeout+0x35/0xd7
 [<ffffffff8803654c>] :scsi_mod:scsi_send_eh_cmnd+0x238/0x3d3
 [<ffffffff88036767>] :scsi_mod:scsi_eh_tur+0x3d/0x91
 [<ffffffff88037009>] :scsi_mod:scsi_error_handler+0x400/0xa8c
 [<ffffffff802352ea>] kthread+0x100/0x136
 [<ffffffff802614de>] child_rip+0x8/0x12
DWARF2 unwinder stuck at child_rip+0x8/0x12
Leftover inexact backtrace:
 [<ffffffff80267bb2>] _spin_unlock_irq+0x2b/0x31
 [<ffffffff80260b1c>] restore_args+0x0/0x30
 [<ffffffff8024fa61>] run_workqueue+0x19/0xfa
 [<ffffffff802351ea>] kthread+0x0/0x136
 [<ffffffff802614d6>] child_rip+0x0/0x12

usb 5-7.3: reset high speed USB device using ehci_hcd and address 6
PM: Removing info for No Bus:usbdev5.6_ep82
PM: Removing info for No Bus:usbdev5.6_ep01
PM: Removing info for No Bus:usbdev5.6_ep83
PM: Adding info for No Bus:usbdev5.6_ep82
PM: Adding info for No Bus:usbdev5.6_ep01
PM: Adding info for No Bus:usbdev5.6_ep83
usb 5-7.3: reset high speed USB device using ehci_hcd and address 6
PM: Removing info for No Bus:usbdev5.6_ep82
PM: Removing info for No Bus:usbdev5.6_ep01
PM: Removing info for No Bus:usbdev5.6_ep83
PM: Adding info for No Bus:usbdev5.6_ep82
PM: Adding info for No Bus:usbdev5.6_ep01
PM: Adding info for No Bus:usbdev5.6_ep83
usb 5-7.3: reset high speed USB device using ehci_hcd and address 6
PM: Removing info for No Bus:usbdev5.6_ep82
PM: Removing info for No Bus:usbdev5.6_ep01
PM: Removing info for No Bus:usbdev5.6_ep83
PM: Adding info for No Bus:usbdev5.6_ep82
PM: Adding info for No Bus:usbdev5.6_ep01
PM: Adding info for No Bus:usbdev5.6_ep83
scsi 4:0:0:0: scsi: Device offlined - not ready after error recovery
PM: Removing info for No Bus:target4:0:0
PM: Adding info for No Bus:target4:0:1
PM: Removing info for No Bus:target4:0:1
PM: Adding info for No Bus:target4:0:2
PM: Removing info for No Bus:target4:0:2
PM: Adding info for No Bus:target4:0:3
PM: Removing info for No Bus:target4:0:3
PM: Adding info for No Bus:target4:0:4
PM: Removing info for No Bus:target4:0:4
PM: Adding info for No Bus:target4:0:5
PM: Removing info for No Bus:target4:0:5
PM: Adding info for No Bus:target4:0:6
PM: Removing info for No Bus:target4:0:6
PM: Adding info for No Bus:target4:0:7
PM: Removing info for No Bus:target4:0:7
usb-storage: device scan complete


-- 
http://www.codemonkey.org.uk
