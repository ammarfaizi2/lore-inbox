Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHaWgh>; Sat, 31 Aug 2002 18:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318045AbSHaWgh>; Sat, 31 Aug 2002 18:36:37 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:57348 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S318040AbSHaWgg>; Sat, 31 Aug 2002 18:36:36 -0400
Date: Sun, 1 Sep 2002 02:40:19 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020901024019.A2888@jurassic.park.msu.ru>
References: <1030806402.3490.9.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44.0208310940510.2129-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0208310940510.2129-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 31, 2002 at 09:49:14AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 09:49:14AM -0700, Linus Torvalds wrote:
> 
> On 31 Aug 2002, Alan Cox wrote:
> >
> > Related question while we are on the subject of bridges. I'm trying to
> > work out a clean way to initialize a new subtree of devices given a
> > bridge that suddenely has devices behind it.
> > 
> > This occurs in three cases I know about now 
> > - Easidock cardbus->PCI extender
> > - IBM Thinkpad hot docking bridge
> > - Magma PCI extended split bridge
> 
> pci_do_scan_bus() should do almost everything for you. Pat Mochel had some
> code that made the cardbus driver basically do just this on cardbus
> insertion, you might ask him.

I guess Pat's code has something to do with a resource allocation
(haven't seen it though).
I would play with following if I have the hardware:
{
	pci_do_scan_bus(bus);
	pbus_size_bridges(bus);
	pbus_assign_resources(bus);
}
Obviously, __init qualifiers should be changed to __devinit for pbus_*
and other stuff in setup-bus.c and setup-res.c.

Ivan.
