Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSFFAFq>; Wed, 5 Jun 2002 20:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSFFAFp>; Wed, 5 Jun 2002 20:05:45 -0400
Received: from air-2.osdl.org ([65.201.151.6]:25227 "EHLO geena.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S316576AbSFFAFo>;
	Wed, 5 Jun 2002 20:05:44 -0400
Date: Wed, 5 Jun 2002 17:01:30 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@geena.pdx.osdl.net>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: "David S. Miller" <davem@redhat.com>, <anton@samba.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
In-Reply-To: <20020605182316.B3437@jurassic.park.msu.ru>
Message-ID: <Pine.LNX.4.33.0206051653310.654-100000@geena.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Jun 2002, Ivan Kokshaysky wrote:

> On Tue, Jun 04, 2002 at 03:03:33PM -0700, Patrick Mochel wrote:
> > -subsys_initcall(pci_driver_init);
> > +postcore_initcall(pci_driver_init);
> 
> Fine, but my main objection was to pci_driver_init being an initcall
> in general, no matter in what level. With current code we may have
> pci_bus_type registered on a machine without PCI bus.
> Real life example: jensen running generic alpha kernel.

That's fine. That's exactly the same thing that happens with device
drivers you have compiled in but don't have hardware for and have hotplug
enabled. The fact that it's registered with the system simply advertises
its support.

The fact that it's unused and just sitting there taking up space is 
distasteful, but there are things that could be done about it. For one, we 
could compile PCI as a module and include it in an initramfs image (so it 
loaded early enough to not break too many things).

Or, after we probe for everything, we could make a sweep of all the 
drivers in the system and purge any that have a refcount of 1 (registered, 
but not used by anyone).

	-pat

