Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVLDAMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVLDAMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 19:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVLDAMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 19:12:36 -0500
Received: from hobbit.corpit.ru ([81.13.94.6]:42332 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932178AbVLDAMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 19:12:36 -0500
Message-ID: <43923479.3020305@tls.msk.ru>
Date: Sun, 04 Dec 2005 03:12:41 +0300
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Could not suspend device [VIA UHCI USB controller]: error -22
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to "standby" (echo standby > /sys/power/state)
a 2.6.14 system running on a VIA C3-based system with VIA
chipset (suspend to disk never worked on this system --
as stated on swsusp website it's due to the lack of some
CPU instruction on this CPU [but winXP suspends to disk
on this system just fine]), it immediately comes back, with
the above error message:

Stopping tasks: =====================================================================|
ACPI: PCI interrupt for device 0000:00:07.5 disabled
Could not suspend device 0000:00:07.3: error -22
ACPI: PCI Interrupt 0000:00:07.5[C] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC] -> GSI 12 (level, low) -> IRQ 12
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Some devices failed to suspend
Restarting tasks... done

Here's the PCI devices:

00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
00:07.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 1a)
00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 50)
00:0a.0 Multimedia controller: Philips Semiconductors SAA7134 (rev 01)
00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
01:00.0 VGA compatible controller: Trident Microsystems CyberBlade/i1 (rev 6a)

(note it's the second USB interface which fails).
And here's the USB device list:

Bus 002 Device 002: ID 07cc:0301 Carry Computer Eng., Co., Ltd 6-in-1 Card Reader
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 003: ID 0458:0036 KYE Systems Corp. (Mouse Systems)
Bus 001 Device 001: ID 0000:0000

This machine was never able to go to standby mode completely - before
2.6.14, it performed resume after several secounds of sleeping.  Now
it does not even try to sleep anymore.

Also, "suspend to mem" does just nothing, -- the same as "suspend to disk"
(but for disk, it never worked at all as stated above).

Any hints on where to look at?

Thanks.

/mjt
