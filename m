Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266189AbUIVWEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266189AbUIVWEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 18:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268001AbUIVWEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 18:04:33 -0400
Received: from webmail.sub.ru ([213.247.139.22]:59663 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S266189AbUIVWE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 18:04:27 -0400
Subject: 2.6.8.1, USB , "IRQ 11 disabled" on plugging in a device
From: Mikhail Ramendik <mr@ramendik.ru>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1095890664.3522.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-6aspMR) 
Date: Thu, 23 Sep 2004 02:04:25 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I use 2.6.8.1. On 2.6.7 things were OK. My motherboard is an Asus
P4P800, with the Intel i865PE chipset. USB stuff is compiled into the
kernel (not as modules).

When I plug in a USB device it is not recognized. It does not even
appear in lsusb. And it says that it disables IRQ 11 - which is even 
NOT the IRQ used by USB!

The system works OK with USB devices that were plugged in at boot time.
But when I unplug one, wait some seconds and plug it in again, the
system does not see it anymore.

On the first plugging-in of any USB device, the following appears in
/var/log/messages : 

===

Sep 19 11:49:07 localhost kernel: irq 11: nobody cared!
Sep 19 11:49:07 localhost kernel:  [<c010784c>]
__report_bad_irq+0x2a/0x8b
Sep 19 11:49:07 localhost kernel:  [<c0107936>] note_interrupt+0x6f/0x9f
Sep 19 11:49:07 localhost kernel:  [<c0107b2c>] do_IRQ+0xe3/0xe5
Sep 19 11:49:07 localhost kernel:  [<c0106104>]
common_interrupt+0x18/0x20
Sep 19 11:49:07 localhost kernel:  [<c01077e2>]
handle_IRQ_event+0x24/0x64
Sep 19 11:49:07 localhost kernel:  [<c0107abb>] do_IRQ+0x72/0xe5
Sep 19 11:49:07 localhost kernel:  [<c0106104>]
common_interrupt+0x18/0x20
Sep 19 11:49:07 localhost kernel:  [<c011d47f>] __do_softirq+0x2f/0x83
Sep 19 11:49:07 localhost kernel:  [<c011d4f9>] do_softirq+0x26/0x28
Sep 19 11:49:07 localhost kernel:  [<c0107b13>] do_IRQ+0xca/0xe5
Sep 19 11:49:07 localhost kernel:  [<c010401e>] default_idle+0x0/0x27
Sep 19 11:49:07 localhost kernel:  [<c0106104>]
common_interrupt+0x18/0x20
Sep 19 11:49:07 localhost kernel:  [<c010401e>] default_idle+0x0/0x27
Sep 19 11:49:07 localhost kernel:  [<c0104042>] default_idle+0x24/0x27
Sep 19 11:49:07 localhost kernel:  [<c01040a9>] cpu_idle+0x2e/0x37
Sep 19 11:49:07 localhost kernel:  [<c03e26ca>] start_kernel+0x17e/0x1bd
Sep 19 11:49:07 localhost kernel:  [<c03e22e4>]
unknown_bootoption+0x0/0x16f
Sep 19 11:49:07 localhost kernel: handlers:
Sep 19 11:49:07 localhost kernel: [<d099d725>]
(ohci_irq_handler+0x0/0x78d [ohci1394])
Sep 19 11:49:07 localhost kernel: [<d0aa06a5>] (SkGeIsrOnePort+0x0/0x146
[sk98lin])
Sep 19 11:49:07 localhost kernel: [<d0b07796>]
(snd_intel8x0_interrupt+0x0/0x1ef [snd_intel8x0])
Sep 19 11:49:07 localhost kernel: Disabling IRQ #11
===

Here is /proc/interrupts:

===
           CPU0       
  0:   21993633          XT-PIC  timer
  1:       9543          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:     178551          XT-PIC  uhci_hcd, uhci_hcd, eth0
  8:          1          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:    1864080          XT-PIC  uhci_hcd, uhci_hcd, radeon@PCI:1:0:0
 11:      32714          XT-PIC  ohci1394, SysKonnect SK-98xx, Intel ICH5
 14:     154802          XT-PIC  ide0
 15:         57          XT-PIC  ide1
NMI:          0 
ERR:          0
===

So, uhci_hcd is not on IRQ 11 at all! ohci1394 is the IEEE1394 device, 
which seems to work just fine. 

What can this be?..

Yours, Mikhail Ramendik



