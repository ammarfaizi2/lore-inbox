Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUHEHYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUHEHYQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 03:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267586AbUHEHYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 03:24:15 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:14810 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267585AbUHEHYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 03:24:13 -0400
Date: Thu, 5 Aug 2004 09:24:10 +0200
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: scheduling while atomic in visor/serial (2.6.8-rc2-mm2)
Message-ID: <20040805072410.GA10350@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi USB Gurus!

2.6.8-rc2-mm2

It just happened to me that my X stopped working (all frozen) while
syncing my palm. Sysrq/syslog brought forth:

vmunix: bad: scheduling while atomic!
vmunix:  [<c0306098>] schedule+0x3d8/0x3e0
vmunix:  [<f0cc273d>] usb_kill_urb+0xdd/0x160 [usbcore]
vmunix:  [<c0116ba0>] autoremove_wake_function+0x0/0x50
vmunix:  [<c0116ba0>] autoremove_wake_function+0x0/0x50
vmunix:  [<f0cc2650>] usb_unlink_urb+0x40/0x50 [usbcore]
vmunix:  [<f0de3608>] serial_throttle+0x38/0x90 [usbserial]
vmunix:  [<c01e8a7f>] n_tty_receive_buf+0x1cf/0xe50
vmunix:  [<f12c2828>] _nv001903rm+0x98/0xa4 [nvidia]
vmunix:  [<f0cbd912>] usb_get_dev+0x12/0x20 [usbcore]
vmunix:  [<f0bca72e>] uhci_submit_common+0x1ee/0x2a0 [uhci_hcd]
vmunix:  [<f0cc1b86>] hcd_submit_urb+0x106/0x190 [usbcore]
vmunix:  [<c01e7468>] flush_to_ldisc+0x98/0x100
vmunix:  [<f0dea741>] visor_read_bulk_callback+0x111/0x200 [visor]
vmunix:  [<f0bc9f45>] uhci_destroy_urb_priv+0xb5/0x100 [uhci_hcd]
vmunix:  [<f0cc20cd>] usb_hcd_giveback_urb+0x1d/0x60 [usbcore]
vmunix:  [<f0bcb549>] uhci_finish_urb+0x39/0x60 [uhci_hcd]
vmunix:  [<f0bcb5a3>] uhci_finish_completion+0x33/0x50 [uhci_hcd]
vmunix:  [<f0bcb789>] uhci_irq+0x179/0x1d0 [uhci_hcd]
vmunix:  [<f0cc213e>] usb_hcd_irq+0x2e/0x60 [usbcore]
vmunix:  [<c0106140>] handle_IRQ_event+0x30/0x60
vmunix:  [<c01064a0>] do_IRQ+0x90/0x130
vmunix:  [<c01048f4>] common_interrupt+0x18/0x20
vmunix: visor ttyUSB1: visor_unthrottle - failed submitting read urb, error -1 

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GLENWHILLY (n. Scots)
A small tartan pouch worn beneath the kilt during the thistle-harvest.
			--- Douglas Adams, The Meaning of Liff
