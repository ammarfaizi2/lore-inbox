Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWAVLLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWAVLLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 06:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbWAVLLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 06:11:15 -0500
Received: from fluido.speedxs.nl ([83.98.238.192]:63499 "EHLO fluido.as")
	by vger.kernel.org with ESMTP id S932190AbWAVLLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 06:11:15 -0500
Date: Sun, 22 Jan 2006 12:11:12 +0100
From: "Carlo E. Prelz" <fluido@fluido.as>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
Message-ID: <20060122111112.GA15320@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as> <20060121010932.5d731f90.akpm@osdl.org> <20060121125741.GA13470@epio.fluido.as> <20060121125822.570b0d99.akpm@osdl.org> <20060122074034.GA1315@epio.fluido.as> <20060121235546.68f50bd5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20060121235546.68f50bd5.akpm@osdl.org>
X-operating-system: Linux epio 2.6.14
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >= 2.6.15 rc1
	Date: sab 21 gen 06 11:55:46 -0800

Quoting Andrew Morton (akpm@osdl.org):

> Can you please gather some more details on this and prepare a new report? 
> The full demsg output, machine description, etc.  It might be best to do
> this via a new bugzilla.kernel.org record so we know where to find it.

I filed bug #5935.

The BIOS contains 4 fields related to USB. In the 'Integrated
peripherals' menu:

USB EHCI Controller
Onchip USB Controller
Onchip USB KBC Controller

In the 'PnP/PCI configurations' menu: 

Assign IRQ for USB

All four only allow a choice between enable/disable. As expected,
disabling the first one makes the 0000:00:13.2 pci device
disappear. This results in the completing of the boot process. I am
writing this from a working 2.6.15 kernel, and I can mount my USB hard
disk. It probably works in 1.1 mode. 

I noticed that the new motherboard's USB device is OHCI-based, while
the previous one was UHCI-based. The OHCI driver was previously not
compiled in. EHCI was functional even without a working OHCI module
(in 2.6.14). Compiling in the OHCI driver has had no effect in the
boot hang with EHCI enabled - the machine still hangs, and the output
is identical.

Disabling the second field (Onchip USB Controller) makes all USB
devices disappear - boot is OK, but there is no usb activity at all.

The third field has no evident effect. This is true of the fourth one
too (the one about IRQ assignment). I saw no change in boot logs. 

Complete dmesg output for the successful 2.6.15 boot with EHCI
disabled can be downloaded from http://www.fluido.as/files/dmesg.txt. 

Carlo

-- 
  *         Se la Strada e la sua Virtu' non fossero state messe da parte,
* K * Carlo E. Prelz - fluido@fluido.as             che bisogno ci sarebbe
  *               di parlare tanto di amore e di rettitudine? (Chuang-Tzu)
