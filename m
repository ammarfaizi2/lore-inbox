Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275805AbTHOIxw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 04:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275808AbTHOIxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 04:53:52 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:49668 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S275805AbTHOIxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 04:53:18 -0400
Subject: Re: Trying to run 2.6.0-test3
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60>
Content-Type: text/plain
Message-Id: <1060937593.604.14.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 15 Aug 2003 10:53:13 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 10:11, Norman Diamond wrote:

> 1.  Although both yenta and i82365 are compiled in, my 16-bit NE2000 clone
> isn't recognized.  If I boot kernel 2.4.19 I can use the network, if I
> boot kernel 2.6.0 I can't find any way to use the network.  Partial output
> of various commands and files are shown below.

What brand/model? What chipset does the card use? Are your sure it's
PCMCIA (16-bit) and not CardBus (32-bit)?

> 3.  For 2.6.0-test1, a few people kindly explained and provided a patch
> to make the keyboard work with a plain text console, to get a pipe symbol
> when not running under X.  How come 2.6.0-test3 still doesn't incorporate
> that patch?

Uh? A patch to make the pipe (|) symbol work?

> 5.  Modules seem to work except for module symbols.  This seems to be a
> result of compiling the new modules packages manually at a time when I
> could not persuade the rpm --rebuild command to target the correct cpu.
> Later I persuaded rpm --rebuild to work.  modprobe and lsmod and rmmod
> work, only kernel symbols think that modules are disabled.

Have you upgraded to latest modutils package? Modules are implemented
quite differently in 2.6.

> #
> # PCI Hotplug Support
> #
> CONFIG_HOTPLUG_PCI=m
> CONFIG_HOTPLUG_PCI_FAKE=m

You don't need that.

> 
> 
> (/var/log/messages)
> 
> Aug 14 22:21:37 diamondpana kernel: cs: warning: no high memory space available!
> Aug 14 22:21:37 diamondpana kernel: cs: unable to map card memory!
> Aug 14 22:21:37 diamondpana last message repeated 3 times
> Aug 14 22:22:49 diamondpana last message repeated 7 times
> Aug 14 22:23:35 diamondpana last message repeated 3 times
> Aug 14 22:24:40 diamondpana last message repeated 3 times
> Aug 14 22:29:07 diamondpana kernel: cs: unable to map card memory!

It seems the kernel is having problems assigning resources to your card.
Plase, edit "/etc/pcmcia/config.opts" and uncomment the following line:

#include port 0x1000-0x17ff

> 
> 
> (dmesg)
> 
> Kernel command line: acpi=off apm=on root=/dev/hda8

I suggest you to recompile your kernel with ACPI support to see if it
works correctly. Else, recompile it disabling ACPI support and enabling
APM support.

> No local APIC present or hardware disabled

You can remove APIC support from your config. It's not supported by your
hardware.

> PCI: IRQ 0 for device 0000:00:01.2 doesn't match PIRQ mask - try pci=usepirqmask
> PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
> PCI: IRQ 0 for device 0000:00:0a.1 doesn't match PIRQ mask - try pci=usepirqmask

Please, add "pci=usepirqmask" to your kernel command line in GRUB/Lilo.

