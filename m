Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264424AbTKMU7m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTKMU7m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:59:42 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:57771 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id S264424AbTKMU7j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:59:39 -0500
Date: Thu, 13 Nov 2003 15:57:26 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Michael Born <michael.born@stud.uni-hannover.de>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI: device 00:09.0 has unknown header type 04, ignoring.  What's
 that?
In-Reply-To: <Pine.LNX.4.53.0311131506130.2038@chaos>
Message-ID: <Pine.GSO.4.33.0311131543430.26356-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Richard B. Johnson wrote:
>> While booting the kernel says:
>> ---
>> <6>PCI: Probing PCI hardware
>> <4>PCI: ACPI tables contain no PCI IRQ routing entries
>> <4>PCI: Probing PCI hardware (bus 00)
>> <3>PCI: device 00:09.0 has unknown header type 04, ignoring.
>> <6>PCI: Using IRQ router VIA [1106/3074] at 00:11.0
>
>We don't know if 00:09.0 is your board, but a header type 04
>is currently not defined. There are three header types, 0->2.
...
>> The BIOS bootscreen reported an "unknown device - IRQ5". But "lspci" doesn't
>> show up the card!!!
>
>lspci will only show a configured controller. Normally the BIOS will
>configure it. Eventually the kernel may re-configure it. However,
>with an incorrect header, this won't happen. The board vendor
>may have "worked-around" this problem with his driver by forcing
>bits into configuration registers to make it "function". This
>has a fatal flaw in that a module (driver) doesn't have enough
>information available to successfully allocate I/O space on its
>own.

There could be a few other things going on here... like a broken BIOS.  And
it could simply be problems reading the PCI configuration space for that
board.  Check the BIOS settings for the PCI bus.  Try the card in different
machine(s) -- made by different manufacturers with different BIOSes.
(FWIW, I have a machine that doesn't like certain PCI cards, and certainly
 doesn't like multiple ones -- it assigns them all the *same* memory
 sections.)

I've been seeing the same messages on sparc hardware (UltraAXi, Netra T1,
U5, etc.) for, oh, a year:

PROMLIB: Sun IEEE Boot Prom 4.0.3 2001/01/03 15:05
Linux version 2.6.0-test8+BK@1.1348 (root@spacemeat) (gcc version 3.2.3) #14 BK(
03/10/22-13:42:11-04:00) Wed Oct 22 14:33:57 EDT 2003
ARCH: SUN4U
...
PCI: Probing for controllers.
PCI: Found SABRE, main regs at 000001fe00000000, wsync at 000001fe00001c20
SABRE: Shared PCI config space at 000001fe01000000
SABRE: DVMA at c0000000 [20000000]
PCI: device 0000:00:01.3 has unknown header type 10, ignoring.
PCI: device 0000:00:01.4 has unknown header type 10, ignoring.
PCI: device 0000:00:01.5 has unknown header type 10, ignoring.
PCI: device 0000:00:01.6 has unknown header type 10, ignoring.
PCI: device 0000:00:01.7 has unknown header type 10, ignoring.
PCI: device 0000:00:02.0 has unknown header type 10, ignoring.
...
PCI: device 0000:00:1e.0 has unknown header type 10, ignoring.
PCI: device 0000:00:1f.0 has unknown header type 10, ignoring.

(it's not always 10, btw.)

I'm guessing it's because the configuration space isn't being zero'd or
something like that.  In this case, it's only complaining about things
that aren't actually there.

--Ricky


