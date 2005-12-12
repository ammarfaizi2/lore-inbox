Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750990AbVLLU3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750990AbVLLU3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 15:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbVLLU3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 15:29:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:32922 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750989AbVLLU3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 15:29:49 -0500
Date: Mon, 12 Dec 2005 12:29:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.15-rc5-mm2: ehci_hcd crashes on load sometimes
Message-Id: <20051212122914.1bd36f32.akpm@osdl.org>
In-Reply-To: <200512122053.39970.rjw@sisk.pl>
References: <20051211041308.7bb19454.akpm@osdl.org>
	<200512111706.42867.rjw@sisk.pl>
	<20051211123808.2609f5e7.akpm@osdl.org>
	<200512122053.39970.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Sunday, 11 December 2005 21:38, Andrew Morton wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > The ehci_hcd driver causes problems like this:
> > > 
> > > ehci_hcd 0000:00:02.2: EHCI Host Controller
> > > ehci_hcd 0000:00:02.2: debug port 1
> > > ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 3
> > > ehci_hcd 0000:00:02.2: irq 5, io mem 0xfebfdc00
> > > usb 2-2: Product: USB Receiver
> > > usb 2-2: Manufacturer: Logitech
> > > usb 2-2: configuration #1 chosen from 1 choice
> > > ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
> > > Unable to handle kernel NULL pointer dereference at 00000000000002a4 RIP:
> > > <ffffffff880ad9d0>{:ehci_hcd:ehci_irq+224}
> > 
> > Can you poke around in gdb, see which line it's dying at?
> 
> It looks like at the line 620.  At least here's what gdb told me:
> 
> Line 620 of "ehci-hcd.c" starts at address 0x69c3 <ehci_irq+211>
>    and ends at 0x69e2 <ehci_irq+242>.

On my tree that's

	if ((status & STS_PCD) && device_may_wakeup(&hcd->self.root_hub->dev)) {

It's best to actually send a copy of line 620 - kernels vary a lot, and
many developers won't have that particualr -mm tree handy.

The way I normally do this is to do `gdb vmlinux' and then `l
*0xffffffff880ad9d0'.  If that lands you in some inline function then poke
around, displacing the EIP by +/- amounts until it lands outside the
inlined function so you can see the callsite.

Anyway.  Greg's tree seems rather buggy lately..
