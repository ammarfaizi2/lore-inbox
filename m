Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271149AbTHCLHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 07:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271150AbTHCLHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 07:07:51 -0400
Received: from p4-7036.uk2net.com ([213.232.95.37]:5784 "EHLO
	uptime.churchillrandoms.co.uk") by vger.kernel.org with ESMTP
	id S271149AbTHCLHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 07:07:48 -0400
Subject: Re: [2.6.0-test1] yenta_socket.c:yenta_get_status returns bad
	value compared to 2.4
From: Stefan Jones <cretin@gentoo.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Dominik Brodowski <linux@brodo.de>
In-Reply-To: <20030802180837.B1895@flint.arm.linux.org.uk>
References: <1059244318.3400.17.camel@localhost>
	 <20030802180837.B1895@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Gentoo Linux
Message-Id: <1059908861.3424.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 03 Aug 2003 12:07:41 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-02 at 18:08, Russell King wrote:
> On Sat, Jul 26, 2003 at 07:31:59PM +0100, Stefan Jones wrote:
> > It seems the the change from 2.4 to 2.6 made the state read from 
> > yenta_get_status change it's return value. It reads it from hardware.
> 
> The get_status function is called multiple times during card
> initialisation.  I doubt that it is valid to compare the get_status
> values from 2.4 and 2.6 kernels, without examining what's going on
> in the cs.c code.
> 
> It would be helpful if you could apply the patch to cs.c which I've
> recently posted to lkml, and report back the full kernel messages,
> including the messages you get from your printk in yenta_get_status().
> 
> The message id was: <20030802173352.A1895@flint.arm.linux.org.uk>

Ok, here is the result. I had to use "probe_mem=0" to stop my machine
hanging ( as I said before).

I started pcmcia
"/etc/init.d/pcmcia start"
I then inserted card for the first time and nothing happened ..
removed it and reinserted it was configured fine.

Thanks for your time,

Stefan

Log:

[ Snip .... ]
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Yenta IRQ list 0038, PCI irq11
Socket status: 30000417
parse_events: socket d080002c thread ce4db3c0 events 00000080
yenta_get_status: status=30000417
socket d080002c status 00000041
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x2c8-0x2cf 0x378-0x37f 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
yenta_get_status: status=30000417

**** INSERT card first time nothing gets printed

**** REINSERT card and I get this;


parse_events: socket d080002c thread ce4db3c0 events 00000080
yenta_get_status: status=30000417
socket d080002c status 00000041
parse_events: socket d080002c thread ce4db3c0 events 00000080
yenta_get_status: status=30000411
socket d080002c status 000000c1
socket_insert: skt d080002c
yenta_get_status: status=30000411
socket_setup: skt d080002c status 000000c1
yenta_get_status: status=30000411
socket_reset: skt d080002c
yenta_get_status: status=30000419
yenta_get_status: status=30000419
orinoco.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.13e (David Gibson <hermes@gibson.dropbear.id.au> and others)
eth1: Station identity 001f:0006:0001:0003
eth1: Looks like an Intersil firmware version 1.3.6
eth1: Ad-hoc demo mode supported
eth1: IEEE standard IBSS ad-hoc mode supported
eth1: WEP supported, 104-bit key
eth1: MAC address 00:09:5B:4A:B1:B6
eth1: Station name "Prism  I"
eth1: ready
eth1: index 0x01: Vcc 5.0, irq 3, io 0x0100-0x013f


