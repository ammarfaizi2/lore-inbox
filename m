Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUHBTps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUHBTps (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 15:45:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUHBTps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 15:45:48 -0400
Received: from internal-bristol34.naxs.com ([216.98.66.34]:62093 "EHLO
	mail.electro-mechanical.com") by vger.kernel.org with ESMTP
	id S262605AbUHBTpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 15:45:43 -0400
Date: Mon, 2 Aug 2004 15:45:42 -0400
From: William Thompson <wt@electro-mechanical.com>
To: linux-kernel@vger.kernel.org
Subject: USB quits working on 2.6.7
Message-ID: <20040802194542.GA11965@electro-mechanical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have USB host controllers and HID compiled in due to the keyboard.

irq 10: nobody cared!
 [__report_bad_irq+42/144] __report_bad_irq+0x2a/0x90
 [note_interrupt+112/176] note_interrupt+0x70/0xb0
 [do_IRQ+273/288] do_IRQ+0x111/0x120
 [common_interrupt+24/32] common_interrupt+0x18/0x20
 [default_idle+0/64] default_idle+0x0/0x40
 [default_idle+44/64] default_idle+0x2c/0x40
 [cpu_idle+59/80] cpu_idle+0x3b/0x50
 [printk+339/400] printk+0x153/0x190

handlers:
 [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
 [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
 [usb_hcd_irq+0/112] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #10

This occured while I was at lunch (not touching the computer).  This happened
at 12:38 (I left for lunch at 11:50).

I don't have this problem on 2.4.26, but I did not compile it into the kernel.
(Actually, that was something I forgot to do).

Another thing I'm having problems with is the fact this keyboard has extra
keys which work under 2.4, but not 2.6.  Appears that the keycode table is
missing 16 sets at the end which correspond to 6 of those keys.  I think I
can fix this myself.

Not sure if this helps or not:

lspci -v on the usb controllers:
0000:00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at dc00 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e000 [size=32]
        Capabilities: [80] Power Management version 2

0000:00:11.4 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1b) (prog-if 00 [UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Flags: bus master, medium devsel, latency 32, IRQ 10
        I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
