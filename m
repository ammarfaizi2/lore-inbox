Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbUEJUyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbUEJUyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 16:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbUEJUyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 16:54:12 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:47713 "EHLO
	mwinf0101.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261604AbUEJUyH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 16:54:07 -0400
Subject: usb_hcd_irq, nobody cared on 2.6.6
From: Thomas Cataldo <tomc@compaqnet.fr>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1084222439.3548.7.camel@buffy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Date: Mon, 10 May 2004 22:53:59 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Few minutes after boot I found that in my logs :

irq 10: nobody cared!
Call Trace:
 [<c01063aa>] __report_bad_irq+0x2a/0x90
 [<c01064a0>] note_interrupt+0x70/0xb0
 [<c0106751>] do_IRQ+0x111/0x120
 [<c010497c>] common_interrupt+0x18/0x20
 [<c0101f40>] default_idle+0x0/0x40
 [<c0101f6c>] default_idle+0x2c/0x40
 [<c0101ffb>] cpu_idle+0x3b/0x50
 [<c0119eb2>] printk+0x192/0x1c0
 
handlers:
[<f99efe80>] (usb_hcd_irq+0x0/0x70 [usbcore])
[<f99efe80>] (usb_hcd_irq+0x0/0x70 [usbcore])
Disabling IRQ #10

Here is cat /proc/interrupts :

           CPU0       CPU1
  0:   23928959   23883721    IO-APIC-edge  timer
  1:       2082       1731    IO-APIC-edge  i8042
  8:          3          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 10:      40387      59613   IO-APIC-level  uhci_hcd, uhci_hcd
 12:      44370      57657    IO-APIC-edge  i8042
 14:       1284       1029    IO-APIC-edge  ide0
 16:    4384837        220   IO-APIC-level  eth0, radeon@PCI:1:0:0
 18:     409701     397459   IO-APIC-level  sym53c8xx, sym53c8xx
 19:      31024      34528   IO-APIC-level  EMU10K1
NMI:          0          0
LOC:   47813934   47813970
ERR:          0
MIS:        543

The same kind of problem hapenned with 2.6.5 too.

My mouse is ps2. The only connected usb device right now is an ipaq
craddle. If I remove it and reboot with my digital camera (usb storage)
connected, I've got the same problem.


lspci output follows :

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
0000:00:09.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
0000:00:09.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
0000:00:0a.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 07)
0000:00:0a.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 07)
0000:00:0b.0 Ethernet controller: Winbond Electronics Corp W89C940 (rev 0b)
0000:00:0c.0 Network controller: Texas Instruments ACX 100 22Mbps Wireless Interface
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)


