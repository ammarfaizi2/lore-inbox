Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVEXPu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVEXPu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 11:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbVEXPtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 11:49:55 -0400
Received: from fmr22.intel.com ([143.183.121.14]:56204 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262121AbVEXPqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 11:46:11 -0400
Date: Tue, 24 May 2005 08:45:36 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Andi Kleen <ak@suse.de>, Rajesh Shah <rajesh.shah@intel.com>,
       len.brown@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, acpi-devel@lists.sourceforge.net,
       gregkh@suse.de
Subject: Re: [patch 2/2] x86_64: Collect host bridge resources
Message-ID: <20050524084533.A20567@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050521004239.581618000@csdlinux-1> <20050521004506.842235000@csdlinux-1> <20050523161507.GN16164@wotan.suse.de> <20050523175706.A12032@unix-os.sc.intel.com> <20050524120527.GB15326@wotan.suse.de> <20050524185856.A7639@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050524185856.A7639@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Tue, May 24, 2005 at 06:58:56PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 06:58:56PM +0400, Ivan Kokshaysky wrote:
> On Tue, May 24, 2005 at 02:05:27PM +0200, Andi Kleen wrote:
> > How about you allocate an extended structure with kmalloc in this case?
> 
> This would lead to quite a few changes in the PCI subsystem.
> Looks good as a long-term solution though.
> 
Yes, I did look at that and this would be a big change that would
affect almost all architectures. I was thinking something like
this would be more appropriate as part of the PCI rewrite that
Adam Belay had proposed.

> > Or if it is only 6 ranges max (it is not, is it?) you could extend
> > the array.
> > 
No, 6 is not guaranteed but would cover a larger percentage of
systems. 8 would probably cover all but a few special cases.

> > I doubt this information will need *that* much memory, so it should
> > be reasonable to just teach the PCI subsystem about it.
> 
> Agreed. As a bonus, extending the PCI_BUS_NUM_RESOURCES to 6 would
> cleanly resolve problems with "transparent" PCI bridges - the bus
> might have 3 "native" + 3 parent bus ranges in that case.
> 
The concern here isn't just increasing the size of pci_bus. The
resource pointers in pci_bus point to resource structures in the
corresponding pci_dev structure for p2p bridges. If we want to
maintain this scheme, we'd have to increase the number of resources
in the pci_dev structure too, which increases it for every single
pci device in the system. Probably ok for big server machines, but
would others (e.g. embedded folks) complain?

I just realized that I did not explicitly CC Greg in my original
post. Doing that now, to see what he thinks.

Rajesh
