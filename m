Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264514AbUEJFHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264514AbUEJFHi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 01:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264515AbUEJFHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 01:07:37 -0400
Received: from duke.cs.duke.edu ([152.3.140.1]:43936 "EHLO duke.cs.duke.edu")
	by vger.kernel.org with ESMTP id S264514AbUEJFHe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 01:07:34 -0400
Date: Mon, 10 May 2004 01:07:31 -0400 (EDT)
From: Patrick Reynolds <reynolds@cs.duke.edu>
To: Len Brown <len.brown@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI and broken PCI IRQ sharing on Asus M5N laptop
In-Reply-To: <1084160004.12352.82.camel@dhcppc4>
Message-ID: <Pine.GSO.4.58.0405100054430.20030@shekel.cs.duke.edu>
References: <A6974D8E5F98D511BB910002A50A6647615FAF0D@hdsmsx403.hd.intel.com>
 <1084160004.12352.82.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 May 2004, Len Brown wrote:

> On Sun, 2004-05-09 at 20:44, Patrick Reynolds wrote:
> > Booting with default parameters puts the i8042 psmouse channel, the
> > Intel
> > 8x0 sound card, and the Cardbus controller all on IRQ 12.  The mouse
> try booting with "acpi_irq_isa=12"

That worked.  The interrupts got redistributed like so:
  6:        172          XT-PIC  Intel 82801DB-ICH4, yenta
  7:       3014          XT-PIC  uhci_hcd, yenta, ndiswrapper
  8:          4          XT-PIC  rtc
  9:        188          XT-PIC  acpi
 12:       1028          XT-PIC  i8042

> I'd be interested to see your dmesg and /proc/interrupts from 2.6.1

It piles the sound and cardbus onto IRQ 5, along with a USB that I'm
actually using.  For some reason it doesn't touch IRQ 6.  Here are dmesg
and /proc/interrupts from 2.6.1, 2.6.6 w/ acpi_irq_isa=12, and 2.6.6 w/
your patch:

http://www.cs.duke.edu/~reynolds/acpi-notes

On Sun, 9 May 2004, Len Brown wrote:

> On the assumption that cmdline works, please try this patch
> (without any cmdline param).
>
> It simply tweaks the heuristic and makes IRQ12 less attractive compared
> to the others.

That also worked and produced the same IRQ mapping as acpi_irq_isa=12.

Thanks!  If you want any more logs, etc, let me know.

--Patrick
