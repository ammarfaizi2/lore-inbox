Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTJ3UP1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 15:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbTJ3UP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 15:15:27 -0500
Received: from palrel10.hp.com ([156.153.255.245]:57749 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262795AbTJ3UPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 15:15:23 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16289.29015.81760.774530@napali.hpl.hp.com>
Date: Thu, 30 Oct 2003 12:15:19 -0800
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
In-Reply-To: <3FA12A2E.4090308@pacbell.net>
References: <200310272235.h9RMZ9x1000602@napali.hpl.hp.com>
	<20031028013013.GA3991@kroah.com>
	<200310280300.h9S30Hkw003073@napali.hpl.hp.com>
	<3FA12A2E.4090308@pacbell.net>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 30 Oct 2003 07:11:42 -0800, David Brownell <david-b@pacbell.net> said:

  David> David Mosberger wrote:

  >> On x86, there is no OOps, it just freezes.  On ia64, I get a nice MCA
  >> and from that we can infer that a USB host controller read from
  >> address 0xf0000000 caused the problem but since this is asynchronous
  >> to the kernel's code path, the instruction pointer etc. in the MCA
  >> state dump isn't terribly helpful.

  David> Does that 0xf0000000 (on ia64) match any obvious address mapping
  David> of the null pointer -- like a dma mapping?

Not really.  AFAIK, 0xf0000000 is part of the PCI MMIO address space,
but on the machines that I have access to, this particular address
isn't assigned to any device:

	$ lspci -v|fgrep 'Memory at'
        Memory at 0000000080000000 (32-bit, prefetchable) [size=128M]
        Memory at 0000000088000000 (32-bit, non-prefetchable) [size=512K]
        Memory at 00000000d0023000 (32-bit, non-prefetchable) [size=4K]
        Memory at 00000000d0022000 (32-bit, non-prefetchable) [size=4K]
        Memory at 00000000d0021000 (32-bit, non-prefetchable) [size=256]
        Memory at 00000000d0020000 (32-bit, non-prefetchable) [size=4K]
        Memory at 00000000d0000000 (32-bit, non-prefetchable) [size=128K]
        Memory at 00000000e0200000 (32-bit, non-prefetchable) [size=4K]
        Memory at 00000000e0100000 (32-bit, non-prefetchable) [size=1M]

  David> I'm not sure that if the HID driver were to pass a null
  David> buffer pointer, it would be caught anywhere.

OK, I'll try to find some time to trace the I/O MMU calls to see if
something isn't kosher at that level.  Is there a good way of getting
a relatively high-level of tracing in the USB subsystem that would
some me what's going on between the HID and the core USB level?

	--david
