Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263425AbUKZWOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUKZWOg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 17:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262831AbUKZWNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 17:13:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:10458 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263425AbUKZWMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 17:12:46 -0500
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second
	take)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Brownell <david-b@pacbell.net>
Cc: Colin Leroy <colin.lkml@colino.net>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200411260957.52971.david-b@pacbell.net>
References: <20041126113021.135e79df@pirandello>
	 <200411260928.18135.david-b@pacbell.net>
	 <20041126183749.1a230af9@jack.colino.net>
	 <200411260957.52971.david-b@pacbell.net>
Content-Type: text/plain
Date: Sat, 27 Nov 2004 09:12:10 +1100
Message-Id: <1101507130.28047.29.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 09:57 -0800, David Brownell wrote:
> On Friday 26 November 2004 09:37, Colin Leroy wrote:
> > On 26 Nov 2004 at 09h11, David Brownell wrote:
> > > This isn't a good patch either... maybe your best
> > > bet would be to find out why the IRQs stopped getting
> > > delivered.
> > 
> > It's probably a linux-wlan-ng issue... 
> 
> I suspect PPC resume issues myself.

Colin, you didn't tell us which controller it was ? The NEC one is a
totally normal off-the-shelves controller coming out of D3. The Apple
ones are a bit special tho.
> 
> As expected, if IRQs aren't arriving.  Though you
> may not be using the latest kernel; it's supposed
> to give warnings about IRQ delivery problems after
> resume too, not just on initial startup.

It could be a problem in the code restarting the clocks to the USB cell
in KL (provided it's one of these controller and not the NEC), that
would need some more delay before restarting things...

> I'm not expert in PPC IRQ delivery, which is where the
> root cause of this problem seems to live.  We all have
> places where we need help!

There is nothing fancy with PPC IRQ delivery. IRQs work on wakeup for
everybody or nobody. It's a problem with the USB chip. (There is no
fancy firmware IRQ routing thing, etc... every device is physically
wired to one of the about 128 IRQ lines of the MPIC).

Ben.


