Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUIFBl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUIFBl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 21:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267393AbUIFBl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 21:41:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51690 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267387AbUIFBk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 21:40:59 -0400
Date: Mon, 6 Sep 2004 02:40:58 +0100
From: Matthew Wilcox <willy@debian.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Matthew Wilcox <willy@debian.org>, Jesse Barnes <jbarnes@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: multi-domain PCI and sysfs
Message-ID: <20040906014058.GV642@parcelfarce.linux.theplanet.co.uk>
References: <9e4733910409041300139dabe0@mail.gmail.com> <200409041527.50136.jbarnes@engr.sgi.com> <9e47339104090415451c1f454f@mail.gmail.com> <200409041603.56324.jbarnes@engr.sgi.com> <20040905230425.GU642@parcelfarce.linux.theplanet.co.uk> <9e473391040905165048798741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e473391040905165048798741@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 05, 2004 at 07:50:04PM -0400, Jon Smirl wrote:
> So how do multiple root buses work? Since they are all in the same
> domain it seems like a single IO operation would go to all of the root
> bridges simultaneously. Then each root bridge matches to the address
> and decides to send the IO operation on if there is a match.

Not exactly -- each rope (the line that connects the memory & I/O
controller to the I/O adapter) has a limited bandwidth, so the memory
& I/O controller makes the decision which rope each transaction is
destined for.

> When implementing the VGA control I'm running into the problem that
> there is no root node in sysfs for the top of a domain. I need a
> domain node to attach an attribute disabling all VGA devices in the
> domain. In the zx1 diagram I could have vga devices on any of the
> PCI-X or AGP buses.

Why would it be a problem if the attribute is per-bus, as it is right now?
see bus->bridge_ctl (PCI_BRIDGE_CTL_VGA)

> With the xz1 sysfs would look like this:
> /sys/devices/pci0000:00
> /sys/devices/pci0000:01
> /sys/devices/pci0000:02
> /sys/devices/pci0000:03
> /sys/devices/pci0000:04
> /sys/devices/pci0000:05

Actually, they're sparsely numbered to allow for people plugging in pci-pci
bridges on cards, so:

$ ls -1 /sys/devices/
pci0000:00
pci0000:80
pci0000:a0
pci0000:c0
platform
system

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
