Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264471AbUEJCrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUEJCrh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 22:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbUEJCrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 22:47:36 -0400
Received: from fmr10.intel.com ([192.55.52.30]:6087 "EHLO
	fmsfmr003.fm.intel.com") by vger.kernel.org with ESMTP
	id S264471AbUEJCre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 22:47:34 -0400
Subject: Re: ACPI and broken PCI IRQ sharing on Asus M5N laptop
From: Len Brown <len.brown@intel.com>
To: Patrick Reynolds <reynolds@cs.duke.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FAF02@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FAF02@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084157245.12359.51.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 09 May 2004 22:47:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-09 at 20:44, Patrick Reynolds wrote:
> I posted yesterday about how the built-in psmouse in my Asus M5N
> (M5200N)
> laptop is broken under recent 2.6 kernels.  I believe I have tracked
> the
> problem down to broken IRQ sharing.  It's broken under 2.6.2 through
> 2.6.6-rc3-bk11, but it works fine under 2.6.1.
> 
> Booting with default parameters puts the i8042 psmouse channel, the
> Intel
> 8x0 sound card, and the Cardbus controller all on IRQ 12.  The mouse
> is
> almost unusable, sampling 3-4 times per second.  The sound works
> fine.  In
> /proc/interrupts I get
>    12:      310     XT-PIC  i8042, Intel 82801DB-ICH4, yenta
> The interrupt count goes up when I play MP3s, but not when I move the
> mouse.

try booting with "acpi_irq_isa=12"

ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 12) *0, disabled.

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12

There are 3 BIOS bugs here:
1. LNKB is marked disabled, yet referenced
Linux handes this

2. Current Setting for LNKB is not in possible setting list
Linux handles -- though apparently this fixes some systems
and breaks others.

3. IRQ12 marked as a viable IRQ for sharing sound and mouse
Linux falls for this hook, line, and sinker.

I'd be interested to see your dmesg and /proc/interrupts from 2.6.1

thanks,
-Len


