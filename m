Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752040AbWCBTNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbWCBTNP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 14:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752041AbWCBTNP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 14:13:15 -0500
Received: from colo.lackof.org ([198.49.126.79]:54198 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S1752040AbWCBTNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 14:13:14 -0500
Date: Thu, 2 Mar 2006 12:23:39 -0700
From: Grant Grundler <grundler@parisc-linux.org>
To: Grant Grundler <grundler@parisc-linux.org>,
       Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 0/4] PCI legacy I/O port free driver (take4)
Message-ID: <20060302192339.GD22711@colo.lackof.org>
References: <44070B62.3070608@jp.fujitsu.com> <20060302155056.GB28895@flint.arm.linux.org.uk> <20060302172436.GC22711@colo.lackof.org> <20060302180025.GC28895@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302180025.GC28895@flint.arm.linux.org.uk>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 06:00:25PM +0000, Russell King wrote:
> It's not really "I/O port resource allocation" though - the resources
> have already been allocated and potentially programmed into the BARs
> well before the driver gets anywhere near the device.

Agreed.

> Are you implying that somehow resources are allocated at pci_enable_device
> time?

No. The driver just wants to ignore those BARs regardless of whether
they have been programmed or not.

>   If so, shouldn't we be thinking of moving completely to that model
> rather than having yet-another-pci-setup-model.
> 
> Let's see - we have the i386 method, the drivers/pci/setup-* method, and
> it sounds like some pci_enable_device() method now.

It does give the OS the opportunity to "recycle" the I/O Port resources
at pci_enable_device() time. But this patch doesn't try to do that.

> The problem is that the "no_ioport" method is completely useless for the
> drivers/pci/setup-* method since that information from the drivers comes
> well after the PCI setup code has been run.

Agreed.

> 
> > Several people have already agreed the driver needs to indicate which
> > resource it wants to work with. I don't see how the arch PCI support
> > can provide that "knowledge".
> 
> What I'm saying is that we need to unify this stuff, rather than keep
> bluring and overloading the interfaces.  Otherwise we'll end up with
> drivers developed on one platform which have one expectation from the
> PCI API, which could potentially be different from drivers developed
> on some other platform.

*nod*. Have pci resource allocation take place at any time *after*
the PCI bus walks has it's own set of challenges. In particular,
changing bridge windows or reassigning value to devices which
have already been enabled. Dealing with PCI quirks is another
can of worms.

> Let's have some uniformity - and a solution which can fit everyone -
> that's all I'm asking.

Since the changes are primarily to generic PCI code,
how is this not uniform across arches?
Or am I thinking about this the wrong way?

thanks,
grant
