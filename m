Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268755AbUIGXBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268755AbUIGXBF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 19:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268753AbUIGW7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 18:59:39 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:7417 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268751AbUIGW64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 18:58:56 -0400
Message-ID: <9e47339104090715585fa4f8af@mail.gmail.com>
Date: Tue, 7 Sep 2004 18:58:53 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: multi-domain PCI and sysfs
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040906014058.GV642@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9e4733910409041300139dabe0@mail.gmail.com>
	 <200409041527.50136.jbarnes@engr.sgi.com>
	 <9e47339104090415451c1f454f@mail.gmail.com>
	 <200409041603.56324.jbarnes@engr.sgi.com>
	 <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk>
	 <9e473391040905165048798741@mail.gmail.com>
	 <20040906014058.GV642@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004 02:40:58 +0100, Matthew Wilcox <willy@debian.org> wrote:
> > When implementing the VGA control I'm running into the problem that
> > there is no root node in sysfs for the top of a domain. I need a
> > domain node to attach an attribute disabling all VGA devices in the
> > domain. In the zx1 diagram I could have vga devices on any of the
> > PCI-X or AGP buses.
> 
> Why would it be a problem if the attribute is per-bus, as it is right now?
> see bus->bridge_ctl (PCI_BRIDGE_CTL_VGA)
> 
> Actually, they're sparsely numbered to allow for people plugging in pci-pci
> bridges on cards, so:
> 
> $ ls -1 /sys/devices/
> pci0000:00
> pci0000:80
> pci0000:a0
> pci0000:c0
> platform
> system

How many active VGA devices can I have in this system 1 or 4? If the
answer is 4, how do I independently address each VGA card? If the
answer is one, you can see why I want a pci0000 node to hold the
attribute for turning it off and on.

How many simultaneous VGA devices does this system allow?

ppc32:
jbarnes@mill:~$ ls -l /sys/devices
total 0
drwxr-xr-x   5 root root 0 Sep  4 13:37 pci0000:00/
drwxr-xr-x  13 root root 0 Sep  4 13:37 pci0001:01/
drwxr-xr-x   7 root root 0 Sep  4 13:37 pci0002:06/
drwxr-xr-x   3 root root 0 Sep  4 13:37 platform/
drwxr-xr-x   4 root root 0 Sep  4 13:37 system/
drwxr-xr-x   5 root root 0 Sep  4 13:37 uni-n-i2c/

I would think it is three active devices.

Does a PCI domain imply separate PCI IO address spaces, or does it
just mean separate PCI Config spaces?

Can an x86 machine use separate PCI IO address spaces?

-- 
Jon Smirl
jonsmirl@gmail.com
