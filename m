Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTKMU0X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 15:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTKMU0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 15:26:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:23427 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264394AbTKMU0U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 15:26:20 -0500
Date: Thu, 13 Nov 2003 15:29:09 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Michael Born <michael.born@stud.uni-hannover.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI: device 00:09.0 has unknown header type 04, ignoring.  What's
 that?
In-Reply-To: <200311132040.23582.michael.born@stud.uni-hannover.de>
Message-ID: <Pine.LNX.4.53.0311131506130.2038@chaos>
References: <200311132040.23582.michael.born@stud.uni-hannover.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Nov 2003, Michael Born wrote:

> Hi kernel hackers,
>
> I have a problem with a GPIB PCI card from Quancom
> ( http://quancom.de/qprod01/eng/pb/pci_gpib.htm ).
>

You probably need to talk to them.

> I wrote a programm to read data <100kByte/sec from the GPIB bus to the RAM.
> When the PCI card shares it's IRQ it works for some time and then hardlocks
> my computer - the "PCI access LED" of the GPIB card is always ON then.

The PCI specification requires that all devices be able to share
an interrupt. If the provided driver won't allow this, then it is
broken. You need to contact the vendor.

Also, since the GPIB specification requires that a machine be addressed
to talk before it can talk, etc., you can see that hangs are possible
unless the driver is carefully designed to time-out if the talker doesn't
talk or the listener doesn't listen. Even if you have good hardware,
real-world use may require you to write your own driver. For instance,
a data-transfer is happening between a device and your PC. Somebody
turns off the device. You don't want to have to re-boot. Many
hardware vendors don't have a clue about real-world applications when
they make a so-called "driver". You use they code as an example
of how to talk to their board. You make the real driver yourself.

> Now I found a PCI slot where the card doesn't have to share the IRQ - but
> linux ignores the card :-(
> While booting the kernel says:
> ---
> <6>PCI: Probing PCI hardware
> <4>PCI: ACPI tables contain no PCI IRQ routing entries
> <4>PCI: Probing PCI hardware (bus 00)
> <3>PCI: device 00:09.0 has unknown header type 04, ignoring.
> <6>PCI: Using IRQ router VIA [1106/3074] at 00:11.0
>

We don't know if 00:09.0 is your board, but a header type 04
is currently not defined. There are three header types, 0->2.
Type one is for PCI-PCI bridges.
Type two is for PCI-Cardbus bridges.
All others are type zero. The specification says ALL others
are type zero, not "some of the others".

 ---
>
> The BIOS bootscreen reported an "unknown device - IRQ5". But "lspci" doesn't
> show up the card!!!
>

lspci will only show a configured controller. Normally the BIOS will
configure it. Eventually the kernel may re-configure it. However,
with an incorrect header, this won't happen. The board vendor
may have "worked-around" this problem with his driver by forcing
bits into configuration registers to make it "function". This
has a fatal flaw in that a module (driver) doesn't have enough
information available to successfully allocate I/O space on its
own.

> What is "unknown header type 04" ?
> Why does "lspci" show the card when IRQ is shared?
> How can I know what's wrong with this card?
>

See above. Return board. Look on Web-sites for others, Hint; National
Instruments. They work.

> Somebody please enlighten me.
> Please CC me your mail - I'm not subscribed to the list.
>
> Greetings
> Michael

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


