Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261768AbUKPDwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbUKPDwb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 22:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUKPDwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 22:52:31 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:36062 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261768AbUKPDu1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 22:50:27 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Old thread: Nobody cared, chapter 10^3rd
Date: Mon, 15 Nov 2004 22:50:24 -0500
User-Agent: KMail/1.7
Cc: Len Brown <len.brown@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>
References: <200411150052.22271.gene.heskett@verizon.net> <1100556963.5875.970.camel@d845pe>
In-Reply-To: <1100556963.5875.970.camel@d845pe>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200411152250.25036.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.52.50] at Mon, 15 Nov 2004 21:50:25 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 November 2004 17:16, Len Brown wrote:
>Any difference when you tested with "pci=routeirq"?
>
Dunno Len, but I'll add that to grub.conf and reboot for effects. BRB.

Well, it shut that particular message off, but it sure made ACPI noisy!

It also enabled another message in dmesg:
>From early in dmesg:
-------
Kernel command line: ro root=/dev/hda7 video=radeonfb pci=routeirq
-------
This video=radeonfb didn't do a thing for my partially blind boots.
It is on in the .config...

then later:
-------
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
-------
So, here is an lspci so possibly it can be fixed.
----
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4)
00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet Controller (rev a1)
00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 Audio Controler (MCP) (rev a1)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:07.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
01:07.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
01:08.0 Ethernet controller: D-Link System Inc RTL8139 Ethernet (rev 10)
02:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (rev 01)
02:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200 SE] (Secondary) (rev 01)

Or do you need a more verbose lspci?

>-Len
>
>On Mon, 2004-11-15 at 00:52, Gene Heskett wrote:
>> Greetings;
>>
>> Board is a Biostar N7-NCD-Pro, Athlon 2800XP mounted, gig of ram.
>>
>> Booting to 2.6.10-rc2 just now, I see that the dmesg log shows
>> this:
>>
>> PCI: Using ACPI for IRQ routing
>> ** PCI interrupts are no longer routed automatically.  If this
>> ** causes a device to stop working, it is probably because the
>> ** driver failed to call pci_enable_device().  As a temporary
>> ** workaround, the "pci=routeirq" argument restores the old
>> ** behavior.  If this argument makes the device work again,
>> ** please email the output of "lspci" to bjorn.helgaas@hp.com
>> ** so I can fix the driver.
>> spurious 8259A interrupt: IRQ7.
>> [...]
>>
>> ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 5 (level, low) -> IRQ 5
>> [drm] Initialized radeon 1.11.0 20020828 on minor 0: ATI
>> Technologies Inc RV280 [Radeon 9200 SE]
>> ipmi message handler version v33
>> ipmi device interface version v33
>> irq 12: nobody cared!
>>  [<c0130bea>] __report_bad_irq+0x2a/0x90
>>  [<c01305a0>] handle_IRQ_event+0x30/0x70
>>  [<c0130cdc>] note_interrupt+0x6c/0xd0
>>  [<c0130710>] __do_IRQ+0x130/0x160
>>  [<c01043fe>] do_IRQ+0x3e/0x60
>>  =======================
>>  [<c01028aa>] common_interrupt+0x1a/0x20
>>  [<c011a470>] __do_softirq+0x30/0x90
>>  [<c0104501>] do_softirq+0x41/0x50
>>  =======================
>>  [<c0130564>] irq_exit+0x34/0x40
>>  [<c0104405>] do_IRQ+0x45/0x60
>>  [<c01028aa>] common_interrupt+0x1a/0x20
>>  [<c0130999>] setup_irq+0x99/0x120
>>  [<c024d050>] i8042_interrupt+0x0/0x190
>>  [<c0130b91>] request_irq+0x81/0xb0
>>  [<c042e372>] i8042_check_aux+0x32/0x170
>>  [<c024d050>] i8042_interrupt+0x0/0x190
>>  [<c042e8f0>] i8042_init+0x130/0x1b0
>>  [<c041681b>] do_initcalls+0x2b/0xc0
>>  [<c0433c3d>] sock_init+0x3d/0x80
>>  [<c0100440>] init+0x0/0x110
>>  [<c010046f>] init+0x2f/0x110
>>  [<c010086c>] kernel_thread_helper+0x0/0x14
>>  [<c0100871>] kernel_thread_helper+0x5/0x14
>> handlers:
>> [<c024d050>] (i8042_interrupt+0x0/0x190)
>> Disabling IRQ #12
>> serio: i8042 AUX port at 0x60,0x64 irq 12
>> [...]
>> Nov 15 00:35:40 coyote alsasound: Starting sound driver:
>> snd-intel8x0 Nov 15 00:35:40 coyote kernel: ACPI: PCI Interrupt
>> Link [LACI] enabled at IRQ 12
>> Nov 15 00:35:40 coyote kernel: ACPI: PCI interrupt 0000:00:06.0[A]
>> -> GSI 12 (level, low) -> IRQ 12
>> Nov 15 00:35:40 coyote kernel: intel8x0_measure_ac97_clock:
>> measured 49922 usecs
>> Nov 15 00:35:40 coyote kernel: intel8x0: clocking to 47451
>> Nov 15 00:35:40 coyote alsasound: done
>> Nov 15 00:35:40 coyote rc: Starting alsasound:  succeeded
>>
>> So there seems to be some confusion re the use of IRQ 12
>>
>> Also during the early boot when its running on a vga 80x25 screen,
>> there are no fonts, just the occassional flicker of the curser
>> as it moves back and forth across the bottom of the screen, so
>> my early boot, after about 10 lines at the initiation, is
>> invisible.
>>
>> Later on it switches to an 80x30 screen, at which point I can
>> see the rest of the boot proceedure.  What causes this?

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
