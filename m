Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUDFA6A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbUDFA57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:57:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:6565 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263577AbUDFA56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:57:58 -0400
Date: Tue, 6 Apr 2004 02:57:55 +0200 (MEST)
Message-Id: <200404060057.i360vtNV012133@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, mbuesch@freenet.de
Subject: Re: APIC error on CPU0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Apr 2004 23:35:59 +0200, Michael Buesch wrote:
>What does this kernel message mean?
>
>Apr  5 23:16:20 lfs kernel: APIC error on CPU0: 60(60)
>Apr  5 23:16:31 lfs kernel: APIC error on CPU0: 60(60)
>
>kernel is 2.6.5 with reiser4 patch.

Send Illegal Vector and Receive Illegal Vector at the same time.
This is more interesting than the usual 40(40) errors
(just Receive Illegal Vector), since 60 implies that the
CPU itself is the source of the bogus vector, whereas 40
usually implies a crap mainboard.

My guess is that either your hardware (whatever it is,
you didn't leave any clues) has problems with a noisy
APIC bus, broken chipset, or something like that, or
you enabled ACPI and the ACPI tables are crap.

In any event, Linux is probably not the source of the
problem. You may need to run without I/O APIC ("noapic"
kernel param), no ACPI-based PCI routing ("pci=noapci"),
or completely without ACPI ("acpi=off").
