Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVAXC5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVAXC5z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 21:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVAXC5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 21:57:54 -0500
Received: from ernie.virtualdave.com ([198.216.116.246]:53517 "EHLO
	ernie.virtualdave.com") by vger.kernel.org with ESMTP
	id S261357AbVAXC53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 21:57:29 -0500
Date: Sun, 23 Jan 2005 20:57:26 -0600 (CST)
From: David Sims <dpsims@virtualdave.com>
To: linux-kernel@vger.kernel.org
Subject: irq 3: nobody cared! with Intel 31244 SATA.... Advice??
Message-ID: <Pine.LNX.4.21.0501232056510.26468-100000@ernie.virtualdave.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have a Dell Powervault 745N appliance that I am trying to install
Slackware Linux on....  I have temporarily installed a dual port IDE
card in the expansion slot so I can have the benefit of a CD-ROM and
IDE PATA HD.... Slackware 9.1 installs straightforwardly to the IDE
PATA HD and it boots up fine....

I first tried to get the SATA disk talking with the 2.4.29 kernel...
This kernel boots but hangs when it tries to load module sata_vsc
either from rc.modules or manually after startup using "modprobe
sata_vsc"....

I then downloaded and built kernel 2.6.10 which boots up fine without the
sata_vsc module.... If you then load the sata_vsc module manually using
"modprobe sata_vsc" it will cause the following error once for each
attached disk drive:

Jan 23 09:08:21 linux kernel: Disabling IRQ #3
Jan 23 09:08:23 linux kernel: irq 3: nobody cared!
Jan 23 09:08:23 linux kernel:  [<c0127a62>] __report_bad_irq+0x22/0x90
Jan 23 09:08:23 linux kernel:  [<c0127b58>] note_interrupt+0x58/0x90
Jan 23 09:08:23 linux kernel:  [<c01276e8>] __do_IRQ+0xd8/0xe0
Jan 23 09:08:23 linux kernel:  [<c0103a6a>] do_IRQ+0x1a/0x30
Jan 23 09:08:23 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
Jan 23 09:08:23 linux kernel:  [<c0114880>] __do_softirq+0x30/0x90
Jan 23 09:08:23 linux kernel:  [<c0114915>] do_softirq+0x35/0x40
Jan 23 09:08:23 linux kernel:  [<c0103a6f>] do_IRQ+0x1f/0x30
Jan 23 09:08:23 linux kernel:  [<c010254a>] common_interrupt+0x1a/0x20
Jan 23 09:08:23 linux kernel:  [<c0100590>] default_idle+0x0/0x40
Jan 23 09:08:23 linux kernel:  [<c01005b4>] default_idle+0x24/0x40
Jan 23 09:08:23 linux kernel:  [<c010063e>] cpu_idle+0x2e/0x40
Jan 23 09:08:23 linux kernel:  [<c03d077b>] start_kernel+0x15b/0x190
Jan 23 09:08:23 linux kernel: handlers:
Jan 23 09:08:23 linux kernel: [<c0245a30>] (ide_intr+0x0/0x120)
Jan 23 09:08:23 linux kernel: [<c0245a30>] (ide_intr+0x0/0x120)
Jan 23 09:08:23 linux kernel: [<e08ef250>] (vsc_sata_interrupt+0x0/0xa0
[sata_vsc])

but it will then load and work ok and allow me to fdisk, format and mount
the disk normally..... 

  If I run 'modprobe sata_vsc' from rc.modules, then it hangs while trying
to talk to the first disk just like kernel 2.4.29 did.... I have
repetitively seen this behavior both with a module and with the module
builtin to the kernel.... I have also built the kernel with and without
ACPI as some of the traffic in the newsgroups indicated that could be a
problem... This caused no change in behavior....

  Since my ambition is to get this machine to boot from the SATA disk I am
stuck at this point.... If anyone can provide a little advice or direction
I would be indebted... I have fiddled with the PCI BIOS IRQ settings
without joy... You can change which IRQ is used by the sata controller but
then the error message just changes to that IRQ (i.e., irq 7: nobody
cared!).... It may be of interest to note that the SATA controller (Intel
31244) and the dual port IDE card in the expansion slot seem to be forced
in the BIOS to share the IRQ that is assigned to either one...

  Again, any advice would be very welcome at this point....

TIA,

Dave Sims
Houston, Texas
USA



