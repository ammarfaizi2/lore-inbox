Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267536AbUHXLhG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267536AbUHXLhG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267549AbUHXLf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:35:58 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:486 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S267536AbUHXLf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:35:27 -0400
Date: Tue, 24 Aug 2004 13:35:26 +0200
To: linux-kernel@vger.kernel.org, pp@ee.oulu.fi,
       acpi-devel@lists.sourceforge.net
Subject: acpi and b44: irq disabled, b44: Error, poll already scheduled
Message-ID: <20040824113526.GA25947@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list, hi Pekka!

I am using 2.6.8.1-mm4 and try to get suspend to work. I can suspend to
disk, and resume, but after loading the b44 module and some activity
suddenly millions of
	b44: Error, poll already scheduled
and no response otherwise, not even sysrq.

THis problem only occurs after suspending/resuming (to disk).

I suspect an interrupt problem here, because in the dmesg output of the
resume:
irq 5: nobody cared!
...
 [<c01082aa>] __report_bad_irq+0x24/0x7b
 [<c0108383>] note_interrupt+0x64/0x88
 [<c0108264>] handle_IRQ_event+0x2e/0x50
 [<c010862a>] do_IRQ+0x120/0x12f
 [<c0106870>] common_interrupt+0x18/0x20
 [<c011fef4>] __do_softirq+0x2c/0x80
 [<c011ff6e>] do_softirq+0x26/0x28
 [<c010860b>] do_IRQ+0x101/0x12f
 [<c0106870>] common_interrupt+0x18/0x20
 [<c01b007b>] cbc_encrypt+0xa/0x3c
 [<c0108aff>] setup_irq+0x73/0xdf
 [<e08dbd90>] usb_hcd_irq+0x0/0x5d [usbcore]
 [<c01086df>] request_irq+0x74/0xad
 [<e08df7fd>] usb_hcd_pci_probe+0x1c4/0x494 [usbcore]
 [<c01ba25d>] pci_device_probe_static+0x46/0x55
 [<c01ba29c>] __pci_device_probe+0x30/0x40
 [<c01ba2cf>] pci_device_probe+0x23/0x3f
 [<c0208070>] bus_match+0x32/0x5b
 [<c0208171>] driver_attach+0x51/0x7b
 [<c01b3d69>] kobject_register+0x22/0x53
 [<c0208577>] bus_add_driver+0x88/0xa3
 [<c02089e3>] driver_register+0x28/0x2c
 [<c01ba4ad>] pci_register_driver+0x56/0x7c
 [<e08600ac>] uhci_hcd_init+0xac/0x107 [uhci_hcd]
 [<c01306c1>] sys_init_module+0xdf/0x203
 [<c0105f03>] syscall_call+0x7/0xb
handlers:
[<e08dbd90>] (usb_hcd_irq+0x0/0x5d [usbcore])
Disabling IRQ #5

and usb and eth0 are hanging on irq5.

What can I do about this? Thanks a lot and all the best

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
Now it is such a bizarrely improbable coincidence that
anything so mindboggingly useful could have evolved purely
by chance that some thinkers have chosen to see it as the
final and clinching proof of the non-existence of God.
The argument goes something like this: `I refuse to prove
that I exist,' says God, `for proof denies faith, and
without faith I am nothing.'
The Babel fish is a dead giveaway, isn't
it? It could not have evolved by chance. It proves you
exist, and so therefore, by your own arguments, you don't.
QED.'
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
