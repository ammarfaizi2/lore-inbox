Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266868AbUGLOpC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266868AbUGLOpC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 10:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266869AbUGLOpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 10:45:01 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:5504 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S265138AbUGLOnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 10:43:18 -0400
Date: Mon, 12 Jul 2004 06:43:18 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
Message-ID: <20040712144318.GB2113@iarc.uaf.edu>
Mail-Followup-To: Len Brown <len.brown@intel.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <A6974D8E5F98D511BB910002A50A6647615FFACC@hdsmsx403.hd.intel.com> <1089514128.32038.62.camel@dhcppc2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1089514128.32038.62.camel@dhcppc2>
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len,

* Len Brown <len.brown@intel.com> [2004-Jul-10 18:48 AKDT]:
> It would be interesting if the IRQ failure was always on IRQ7.
> 
> When you moved slots, did the device move to a different
> IRQ and fail there too?

I can't remember for sure.  My system logs go back to June, and all of 
the errors back to then are on IRQ 7.  But I don't remember when I tried 
a different slot.

> Running ACPI, you may be able to move that device off of
> IRQ7 with "acpi_irq_balance" plus "acpi_isa_irq=7".

I'm giving this a go now that 2.6.5 didn't help.  With these parameters, 
/proc/interrupts looks like:


           CPU0       
  0:     509088          XT-PIC  timer
  1:       2408          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:      41821          XT-PIC  eth0, mga@PCI:1:0:0
 11:          0          XT-PIC  uhci_hcd, uhci_hcd, uhci_hcd, EMU10K1, eth1
 12:       2102          XT-PIC  i8042
 14:     236597          XT-PIC  ide0
 15:        328          XT-PIC  ide1
NMI:          0 
LOC:     509008 
ERR:       1693
MIS:          0

Seems like a lot of stuff on IRQ 11. . .

> Hardware routes spurious interrupts to IRQ7, so your
> device may be an innocent victim of those.  Also,
> there may be some motherboard device pulling on IRQ7
> that Linux doesn't know about -- so see if you can
> disable any extra motherboard devices in BIOS setup.

I already have everything I'm not using (serial, parallel ports) 
disabled.

> Finally, you might run a kernel with the IOAPIC enabled,
> such as the CONFIG_SMP kernel, to see if you have an
> IOAPIC on the board and if that mode works differently.

I'll maybe give that a try at some point, if the IRQ balancing doesn't 
help.

Thanks again,

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu (work)
Intl. Arctic Research Center            cswingle@gmail.com (personal)
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

