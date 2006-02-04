Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946297AbWBDDbD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946297AbWBDDbD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 22:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946298AbWBDDbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 22:31:01 -0500
Received: from mx1.rowland.org ([192.131.102.7]:5386 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1946297AbWBDDbB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 22:31:01 -0500
Date: Fri, 3 Feb 2006 22:30:56 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Martin Michlmayr <tbm@cyrius.com>
cc: jgarzik@pobox.com, <linux-kernel@vger.kernel.org>
Subject: Re: Bad interaction between uhci_hcd and de2104x
In-Reply-To: <20060204005014.GA13351@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.44L0.0602032227200.10200-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Feb 2006, Martin Michlmayr wrote:

> I have a machine on which the de2104x driver doesn't work when
> uhci_hcd is loaded.  It used to work fine with 2.4 and the tulip
> driver (and usb-uhci).  Basically, when I boot I get the following
> traceback and then eth0 doesn't work.  When I unload de2104x and
> uhci_hcd and load only de2104x again then Ethernet works.  Similarly,
> when I completely blacklist the uhci_hcd module the de2104x driver
> works without any problems.

And presumably, if you blacklist the de2104x driver then your USB 
controller works without any problems.

> eth0: enabling interface
> eth0: set link 10baseT auto
> eth0:    mode 0x7ffc0040, sia 0x10c4,0xffffef01,0xffffffff,0xffff0008
> eth0:    set mode 0x7ffc0040, set sia 0xef01,0xffff,0x8
> irq 10: nobody cared (try booting with the "irqpoll" option)
>  [<c012f89e>] __report_bad_irq+0x31/0x73
>  [<c012f96d>] note_interrupt+0x75/0x98
>  [<c012f46a>] __do_IRQ+0x67/0x91
>  [<c0104fc1>] do_IRQ+0x19/0x24
>  [<c0103afa>] common_interrupt+0x1a/0x20
>  [<c0119a1c>] __do_softirq+0x2c/0x7d
>  [<c0119a8f>] do_softirq+0x22/0x26
>  [<c0104fc6>] do_IRQ+0x1e/0x24
>  [<c0103afa>] common_interrupt+0x1a/0x20
>  [<c481da07>] de_set_rx_mode+0xf/0x12 [de2104x]
>  [<c481e2c1>] de_init_hw+0x6d/0x76 [de2104x]
>  [<c481e59e>] de_open+0x64/0xe4 [de2104x]
>  [<c0225a5f>] dev_open+0x30/0x66
>  [<c0226a9a>] dev_change_flags+0x4d/0xf0
>  [<c025d301>] devinet_ioctl+0x224/0x4bd
>  [<c0155541>] do_ioctl+0x21/0x50
>  [<c0155774>] vfs_ioctl+0x152/0x161
>  [<c01557cb>] sys_ioctl+0x48/0x65
>  [<c0102a99>] syscall_call+0x7/0xb
> handlers:
> [<c4890d97>] (usb_hcd_irq+0x0/0x56 [usbcore])
> Disabling IRQ #10

For some reason, the de2104x driver isn't listed as a handler for IRQ 10.  
That's probably the cause of the problem.  Did you have any full- or 
low-speed USB devices plugged in at the time this occurred?  If you didn't 
then the UHCI hardware would not have generated any interrupt requests.

Alan Stern

