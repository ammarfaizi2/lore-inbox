Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265687AbSJXWQf>; Thu, 24 Oct 2002 18:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265688AbSJXWQf>; Thu, 24 Oct 2002 18:16:35 -0400
Received: from [63.204.6.12] ([63.204.6.12]:33690 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S265687AbSJXWQe>;
	Thu, 24 Oct 2002 18:16:34 -0400
Date: Thu, 24 Oct 2002 18:22:44 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       KOCHI Takayoshi <t-kouchi@mvf.biglobe.ne.jp>, <jung-ik.lee@intel.com>,
       <tony.luck@intel.com>,
       pcihpd-discuss <pcihpd-discuss@lists.sourceforge.net>,
       <linux-ia64@linuxia64.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
In-Reply-To: <20021024214952.GK25159@kroah.com>
Message-ID: <Pine.LNX.4.33.0210241803420.10937-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Greg KH wrote:

> On Thu, Oct 24, 2002 at 01:44:06PM -0400, Scott Murray wrote:
> >
> > I don't know if you looked at my cPCI driver patch in detail, but it uses
> > the setup-*.c code for all of its resource management.
>
> I'm sorry, but I only glanced at it and missed this point.

No problemo, I kind of vanished off the face of the earth after my last
mention of releasing a 2.5 patch, which was over a month and a half ago.
Now that we've got our new hardware platform up and running here at SOMA,
I'm back in a position to work on hotplug stuff again.

> > The only things that were really missing in 2.4.x were:
> >
> > - exports of a few things, most notably pci_scan_bridge
> > - code to update the resource windows of a newly added bridge (recursively)
> > - a pci_write_bridge_bases
> > - PCI resource reservation to allow hot insertion on dumb cPCI hardware
> > - on x86, the smarts to work back to the root PCI bus to figure out the
> >   IRQ pin to use when looking in the pirq table
>
> All of these seem like things that should belong in the setup-*.c files
> for others to use.

I think Ivan's new code in setup-bus.c (pbus_size_bridges and friends)
removes the need for a pci_write_bridge_bases and my code to update the
bridge resource windows.  I hope so, since I've changed my driver to use
it! ;)

> > Since I've been swamped with other stuff, I just started finally porting
> > my cPCI stuff to 2.5 yesterday. :(  I think I can get it up and running
> > relatively quickly, but figuring out Ivan's newer hotplug helper code
> > and how to take advantage of it might take me a couple of days.
>
> Nice, I was wondering what happened.  I'll go dig up your older patch
> and take a closer look at it.

I hopefully will have something working against 2.5.44 tomorrow.  I think
the only potentially contentious piece that I'd like to get reviewed and
maybe integrated before the feature freeze is the resource reservation
stuff.  There seemed to be no serious objections to the 2.4.x version I
posted a while back, so maybe this won't be a big deal.  Everything else
is either __devinit/export tweaks or driver code.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

