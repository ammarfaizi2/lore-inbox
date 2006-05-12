Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWELCe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWELCe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 22:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750868AbWELCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 22:34:59 -0400
Received: from mxsf30.cluster1.charter.net ([209.225.28.230]:55694 "EHLO
	mxsf30.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750866AbWELCe7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 22:34:59 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Message-ID: <17507.62542.780940.914596@smtp.charter.net>
Date: Thu, 11 May 2006 22:34:54 -0400
From: "John Stoffel" <john@stoffel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Kevin Radloff <radsaq@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Updated libata PATA patch
In-Reply-To: <1147270145.17886.42.camel@localhost.localdomain>
References: <1147196676.3172.133.camel@localhost.localdomain>
	<3b0ffc1f0605091848med1f37ua83c283a922ea682@mail.gmail.com>
	<1147270145.17886.42.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

I just tried to use the IDE2 patches to 2.6.17-rc3 tonight.  I've got
an old Dell Precision 610, Dual 550Mhz Xeon, 768mb of RAM.  My root
disk is SCSI, with hda a Samsung DVD/ROM, CDRW drive.  I've got an
HPT302 controller with a pair of 120gb IDE disks.  I've also got an
addon PCI USB/Firewire Card, an old Cyclom-Y ISA serial port card,
Matrox G450 AGP card, builtin Adaptec SCSI cards, DLT 7000 tape
drive.  Probably other stuff as well.

Here's the lspci output:

> lspci
0000:00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
0000:00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge
0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01)
0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 01)
0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
0000:00:0d.0 RAID bus controller: Triones Technologies, Inc. HPT302 (rev 01)
0000:00:0e.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
0000:00:11.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
0000:00:13.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. G400/G450 (rev 82)
0000:02:06.0 PCI bridge: Hint Corp HB6 Universal PCI-PCI bridge (non-transparent mode) (rev 13)
0000:02:0a.0 SCSI storage controller: Adaptec AHA-2940U2/U2W / 7890/7891
0000:02:0e.0 SCSI storage controller: Adaptec AIC-7880U (rev 01)
0000:03:08.0 USB Controller: NEC Corporation USB (rev 41)
0000:03:08.1 USB Controller: NEC Corporation USB (rev 41)
0000:03:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02)
0000:03:0b.0 FireWire (IEEE 1394): Texas Instruments TSB12LV26 IEEE-1394 Controller (Link)



n> cat /proc/interrupts 
           CPU0       CPU1       
  0:     237231     227203    IO-APIC-edge  timer
  1:       1213       2640    IO-APIC-edge  i8042
  8:          3          1    IO-APIC-edge  rtc
  9:          0          0   IO-APIC-level  acpi
 11:       2265       2258    IO-APIC-edge  Cyclom-Y
 12:      10217       2344    IO-APIC-edge  i8042
 14:       7934       7911    IO-APIC-edge  ide0
 16:     395587     368729   IO-APIC-level  ide2, ide3, ehci_hcd:usb1, mga@pci:0000:01:00.0
 17:       3559          1   IO-APIC-level  Ensoniq AudioPCI, ohci1394, eth0
 18:       7146       4967   IO-APIC-level  aic7xxx, aic7xxx, ohci_hcd:usb2
 19:     174376     184174   IO-APIC-level  uhci_hcd:usb3, ohci_hcd:usb4
NMI:          0          0 
LOC:     464327     464326 
ERR:          0
MIS:          0


Booting up it was *slow*... slower than normal.  I got the following
oops, copied down from a photo I took, since it didn't end up getting
written to disk.  

.
.
.
irq 16: nobody cared (try booting with the "irqpoll" option)
 <c013d034> __report_bad_irq_0x24/0x90  <c013d13f> note_interrupt+0x9f/0x260
 <c031ab78> usb_hcd_irq+0x28/0x60 <c013c993> handle_IRQ_event+0x33/0x70
 <c013ca64> __do_IRQ+0xf4/0x100  <c0105909> do_IRQ+0x19/0x30
 <c0103962> common_interrupt+0x1a/0x20  <c0101b80> default_idle+0x0/0x60
 <c010bac> default_idle+0x2c/0x60  <c0101c48> cpu_idle+0x68/0x90
 <c0542729> start_kernel+0x289/0x400 <c0542230> unknown_bootoption+0x0/0x270
handlers:
[<c0302d20>] (ata_interrupt+0x0/0x150)
[c031ab50>] (usb_hcd_irq+0x0/0x60)
Disabling IRQ #16


Please let me know if there's any more information I can provide.
I'll try to get a serial cable on there so I can capture the boot log
better to another host, but no sure when I'll be able to do this.

John

