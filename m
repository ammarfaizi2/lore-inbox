Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSJXRh7>; Thu, 24 Oct 2002 13:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265569AbSJXRh7>; Thu, 24 Oct 2002 13:37:59 -0400
Received: from [63.204.6.12] ([63.204.6.12]:404 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S265568AbSJXRh5>;
	Thu, 24 Oct 2002 13:37:57 -0400
Date: Thu, 24 Oct 2002 13:44:06 -0400 (EDT)
From: "Scott Murray" <scottm@somanetworks.com>
X-X-Sender: <scottm@rancor.yyz.somanetworks.com>
To: Greg KH <greg@kroah.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       "KOCHI Takayoshi" <t-kouchi@mvf.biglobe.ne.jp>, <jung-ik.lee@intel.com>,
       <tony.luck@intel.com>, <pcihpd-discuss@lists.sourceforge.net>,
       <linux-ia64@linuxia64.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Pcihpd-discuss] Re: PCI Hotplug Drivers for 2.5
In-Reply-To: <20021024165411.GG22654@kroah.com>
Message-ID: <Pine.LNX.4.33.0210241300220.10937-100000@rancor.yyz.somanetworks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, Greg KH wrote:

> On Thu, Oct 24, 2002 at 10:52:09AM -0400, Jeff Garzik wrote:
> > Greg KH wrote:
> > >I think we now all agree that resource management should move into a
> > >place where it can be shared by all pci hotplug drivers, right?
> > >
> > >If so, anyone want to propose some common code?
> >
> >
> > drivers/pci/setup* is not enough?
> >
> > I am surprised that anything needed to be added here...
>
> There was some reason that code would not work out when I looked at it
> over a year ago.  But I don't remember why, so I'll go look at it again,
> thanks for pointing it out.

I don't know if you looked at my cPCI driver patch in detail, but it uses
the setup-*.c code for all of its resource management.  The only things
that were really missing in 2.4.x were:

- exports of a few things, most notably pci_scan_bridge
- code to update the resource windows of a newly added bridge (recursively)
- a pci_write_bridge_bases
- PCI resource reservation to allow hot insertion on dumb cPCI hardware
- on x86, the smarts to work back to the root PCI bus to figure out the
  IRQ pin to use when looking in the pirq table

Since I've been swamped with other stuff, I just started finally porting
my cPCI stuff to 2.5 yesterday. :(  I think I can get it up and running
relatively quickly, but figuring out Ivan's newer hotplug helper code
and how to take advantage of it might take me a couple of days.

Scott


-- 
Scott Murray
SOMA Networks, Inc.
Toronto, Ontario
e-mail: scottm@somanetworks.com

