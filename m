Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbULDXJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbULDXJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 18:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbULDXJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 18:09:37 -0500
Received: from nv-systems.net ([62.75.252.178]:43648 "EHLO mail.nv-systems.net")
	by vger.kernel.org with ESMTP id S261190AbULDXJ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 18:09:28 -0500
Message-ID: <41B243A5.2010506@nv-systems.net>
Date: Sun, 05 Dec 2004 00:09:25 +0100
From: Gerald Hopf <gerald.hopf@nv-systems.net>
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: sata_sil problems (lockup at boottime)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

i'm having some really strange problems with the sata_sil driver.

My hardware:
Asus A7N8X Deluxe Rev 1.x with onboard Sil3112 Controller
- Samsung SP1614C SATA Harddrive
- for further testing : PATA to SATA Adapter that came with an ABIT 
Mainboard

What i'm trying to accomplish: i'm trying to use this Samsung SATA 
harddrive in my Linux Fileserver:

When the Silicon Image Controller is enabled (it can be disabled by a 
jumper) and no harddrive is connected, everything boots fine.
If i connect a harddrive, i get the following message (exact messages 
change slightly) while booting:

- - - - -  START  - - - - -
======================
[<c0102716>] common_interrupt+0x1a/0x20
[<c0117d70>] __do_softirq+0x30/0x90
[<c0104261>] do_softirq+0x41/0x50
======================
[<c012d0a4>] irq_exit+0x34/0x40
[<c0104165>] do_IRQ+9x45/0x60
[<c0102716>] common_interrupt+0x1a/0x20
[<c010c674>] delay_tsc+0x14/0x20
[<c025efd2>] __delay+0x12/0x20
[<c02d7290>] ata_pio_complet+0xe0/0x1f0
[<c02d7a95>] ata_pio_test+0x95/0xb0
[<c01229bc>] worker_thread+0x1cc/0x290
[<c02d7a00>] ata_pio_task+0x0/0xb0
[<c0110160>] default_wake_function+0x0/0x20
[<c0110160>] default_wake_function+0x0/0x20
[<c01227f0>] worker_thread+0x0/0x290
[<c0126ca5>] kthread+0xa5/0xb0
[<c0126c00>] kthread+0x0/0xb0
[<c01006f1>] kernel_thread_helper+0x5/0x14
handlers:
[<c02d82b0>] (ata_interrupt+0x0/0x1c0)
Disabling IRQ #11
ata: dev 0 ATA, max UDMA/100, 361882080 sectors: lba 48
_
- - - - -  END - - - - -

This happens with both the Samsung SP1614C "native" SATA drive, as well 
as with an IBM 180GB PATA drive, using a PATA-to-SATA Adapter.
So i'm not sure whether this is harddrive dependent, but at least it 
doesn't look like it...

This problem has been there in all of the latest 2.6.X kernel revisions. 
I'm currently using 2.6.10-rc3 (which came out today), but i've allready 
had this problem in 2.6.9 and 2.6.8 and probably even 2.6.7 if i 
remember correctly.

I tried quite a lot to get rid of those problems, including:
- Flashing a new/different Bios (even with different versions of the 
Silicon Image SATA Bios part: 4.2.47 and 4.2.50)
- Disabling APIC in the Bios, compiling Kernel with or without APIC
- Changing the IRQ of the Controller by reserving IRQ#11 in the Bios
- Disabling allmost every other onboard device i could, including 
serial/parallel/usb/firewire/3com lan (and there are no PCI/Addon cards 
besides an nvidia geforce2mx agp card installed in this pc anyway!)
- Connecting drives to both ports

I found the following discussions which might be related to what i'm 
experiencing, but noone seems to have a solution. Some seem to suggest 
it worked fine till 2.6.5:
(The first two seem to be most related, i'm not so sure of the third one)
http://www.fedoraforum.org/forum/archive/index.php/t-26543.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=128180
http://www.fedoraforum.org/forum/archive/index.php/t-23028.html

Screenshots of the error messages can be found here:
http://www.nv-systems.net/pics/lkml/sata_sil1.jpg <-- the one from above
http://www.nv-systems.net/pics/lkml/sata_sil2.jpg <-- with samsung 
instead of ibm
http://www.nv-systems.net/pics/lkml/sata_sil3.jpg <-- the screen just 
before the problem

Is there ANYTHING i can do (except buying a promise controller) ?

Yours sincerely,
                     Gerald
