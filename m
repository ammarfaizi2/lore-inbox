Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261916AbVGLST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbVGLST6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 14:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVGLSSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 14:18:09 -0400
Received: from totor.bouissou.net ([82.67.27.165]:25578 "EHLO
	totor.bouissou.net") by vger.kernel.org with ESMTP id S261916AbVGLSQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 14:16:31 -0400
From: Michel Bouissou <michel@bouissou.net>
Organization: Me, Myself and I
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Kernel 2.6.12 + IO-APIC + uhci_hcd = Trouble
Date: Tue, 12 Jul 2005 20:16:25 +0200
User-Agent: KMail/1.7.2
Cc: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0507121004080.4996-100000@iolanthe.rowland.org> <200507121903.49792@totor.bouissou.net>
In-Reply-To: <200507121903.49792@totor.bouissou.net>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5jA1Ctbv4QP6Z34"
Message-Id: <200507122016.25877@totor.bouissou.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_5jA1Ctbv4QP6Z34
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Le Mardi 12 Juillet 2005 19:03, Michel Bouissou a écrit :
>
> Okay, the patch applied easily and the kernel is now compiling. When
> installed, I'll try and boot it (and will use a PS/2 mouse instead of my
> current USB mouse, or should I rather try to plug my USB mouse to the
> ehci_hcd controller ?).
>
> How would you like me to boot ? With or without the "usb-handoff" option ?
> With or without the BIOS "USB mouse support" option ?

I've booted with the patched kernel in the following way:

- BIOS option for mouse support still off ;

- Kernel commandline:
kernel /vmlinuz-2.6.12-6mib7test root=/dev/evms/lv_racine ro 3 usb-handoff 
devfs=nomount noquiet vga=791

- USB mouse plugged to what I believe to be the USB 2.0 controller (according 
to the motherboard manual)

First thing I notice at boot is that "mouse doesn't work".

cat /proc/interrupts shows :
           CPU0       
  0:     208937    IO-APIC-edge  timer
  1:        334    IO-APIC-edge  i8042
  2:          0          XT-PIC  cascade
  4:        464    IO-APIC-edge  serial
  7:          3    IO-APIC-edge  parport0
 14:       1321    IO-APIC-edge  ide4
 15:       1330    IO-APIC-edge  ide5
 18:        822   IO-APIC-level  eth0, eth1
 19:      14157   IO-APIC-level  ide0, ide1, ide2, ide3, ehci_hcd:usb4
 21:      33962   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3
 22:          0   IO-APIC-level  VIA8233
NMI:          0 
LOC:     208855 
ERR:          0
MIS:          0


Looking at dmesg or /var/log/mesages shows a huge number of :
Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.2: IRQ, status = 0
Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.0: IRQ, status = 0
Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.1: IRQ, status = 0
Jul 12 19:36:58 totor kernel: uhci_hcd 0000:00:10.2: IRQ, status = 0

(3043 similar lines...)

...immediately at startup, then it stops complaining

The interesting thing is that I unplugged my USB mouse at 19:45 -- nothing 
happened, and plugged it back at 19:45:40, while looking at a "tail 
-f /var/log/messages"

And see what happened in the attached copy of my /var/log/messages for this 
session...

Doesn't mean anything to me ;-) but I hope it will be of some help for you...

Cheers.

-- 
Michel Bouissou <michel@bouissou.net> OpenPGP ID 0xDDE8AC6E

--Boundary-00=_5jA1Ctbv4QP6Z34
Content-Type: application/x-bzip2;
  name="linux-2.6.12-6mib7test-msgs.txt.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="linux-2.6.12-6mib7test-msgs.txt.bz2"

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
hJZtuWjYT//F3JFOFCQF4/svAA==

--Boundary-00=_5jA1Ctbv4QP6Z34--
