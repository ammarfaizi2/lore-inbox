Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUHMLb7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUHMLb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 07:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUHMLb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 07:31:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4536 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262380AbUHMLbw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 07:31:52 -0400
Date: Fri, 13 Aug 2004 07:15:25 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Oliver Feiler <kiza@gmx.net>
Cc: Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: eth*: transmit timed out since .27 (was: linux-2.4.27 released)
Message-ID: <20040813101525.GD24479@logos.cnet>
References: <200408072328.i77NSRNi031514@hera.kernel.org> <200408101423.42402.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408101423.42402.kiza@gmx.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Oliver,

On Tue, Aug 10, 2004 at 02:23:34PM +0200, Oliver Feiler wrote:
> Hi,
> 
> I've upgraded a server from .26 to .27, but ran into problems with the network 
> cards.
> 
> The kernel throws a lot of errors into the syslog and the net devices don't 
> work:
> Aug 10 13:39:25 spot kernel: NETDEV WATCHDOG: eth0: transmit timed out
> Aug 10 13:39:26 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
> Aug 10 13:39:26 spot kernel: eth1: Transmit timeout, status 00000004 00000249 
> Aug 10 13:39:34 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
> Aug 10 13:39:34 spot kernel: eth1: Transmit timeout, status 00000004 00000241 
> Aug 10 13:39:42 spot kernel: NETDEV WATCHDOG: eth1: transmit timed out
> Aug 10 13:39:42 spot kernel: eth1: Transmit timeout, status 00000004 00000240 
> [...]
> 
> and:
> Aug 10 13:39:25 spot kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, 
> ISR=0x3, t=515.
> Aug 10 13:40:25 spot kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, 
> ISR=0x3, t=5015.
> Aug 10 13:40:40 spot kernel: eth0: Tx timed out, lost interrupt? TSR=0x3, 
> ISR=0x3, t=1014.
> [...]
> 
> The system has three network cards.
> eth0: SIS900 (sis900.c)
> eth1: RTL-8029 (ne2k-pci.c)
> eth2: onboard VIA VT6102 Rhine-II (via-rhine.c)
> 
> eth0 and eth1 share the same interrupt
> 
>            CPU0       
>   0:      91986          XT-PIC  timer
>   1:        935          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   8:          1          XT-PIC  rtc
>   9:          0          XT-PIC  acpi
>  10:      25109          XT-PIC  via82cxxx, usb-uhci, usb-uhci, eth0, eth1
>  11:         24          XT-PIC  usb-uhci, eth2
>  14:       7523          XT-PIC  ide0
>  15:       7021          XT-PIC  ide1
> NMI:          0 
> ERR:          0

Wow, you have four devices on the same interrupt line. /proc/interrupts
from 2.4.26/27 looks the same?

> That was not a problem in .26 however. Though it seems to be the cause of the 
> problem (lost interrupt)? The hardware this is all running on is an Asrock 
> K7VM4 mainboard. The system is booted with "pci=noacpi" (ACPI, no APM). 
> Otherwise IRQ255 is assigned to IDE and someone told me the noacpi parameter 
> would fix the board's braindead BIOS.
> 
> Either way .27 doesn't want to boot. I've attached dmesg from a running 2.4.26 
> kernel and the config used for 2.4.27.

You mean it boots but you get the Tx timeouts?

> Other postings I've found say that the transmit timeouts mean that the 
> lowlevel ethernet connection between the NICs broke. But this works fine in 
> earlier kernels and only eth0 and eth1 which share an interrupt are affected. 
> I'd be glad for any more suggestions on what might be causing this. :)

Well there are some changes to sis900 between .26 and .27 but I doubt
they could be causing it.

Can you try to boot with ACPI disabled? I think the problem might be 
related to ACPI configuration. 

Also, can you post the boot messages from 2.4.27?


