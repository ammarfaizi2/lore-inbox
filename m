Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSA3ASX>; Tue, 29 Jan 2002 19:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287145AbSA3AQl>; Tue, 29 Jan 2002 19:16:41 -0500
Received: from h225-81.adirondack.albany.edu ([169.226.225.80]:9089 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id <S287115AbSA3APB>;
	Tue, 29 Jan 2002 19:15:01 -0500
Subject: Re: via-rhine timeouts
From: Justin A <justin@bouncybouncy.net>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201292112070.6137-200000@cola.teststation.com>
In-Reply-To: <Pine.LNX.4.33.0201292112070.6137-200000@cola.teststation.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 29 Jan 2002 19:15:16 -0500
Message-Id: <1012349716.1143.1.camel@bouncybouncy.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 16:06, Urban Widmark wrote:
> On 28 Jan 2002, Justin A wrote:
> 
> > Ok, it was working for a while, even after a reboot...
> > but now
> >  21:04:33 up 2 days, 20 min, 10 users,  load average: 0.12, 0.47, 0.38
> > 
> > Jan 28 01:39:10 bouncybouncy kernel: eth0: Transmitter underflow?,
> > status 2008.
> 
> This is not a transmit underflow (I was lazy when adding that message,
> this is what the ? is about). It is a transmit abort caused by excessive
> collisions.
> 2000 - transmit abort because of excessive collisions
> 0008 - transmit error
> 
> It is interesting that the linuxfet driver does not fail/recovers. I have
> added some more code from that driver and attached a new version of the
> patch. It re-initializes the ring pointer and tells the card to try to
> transmit the packet again.

I'll send an email to the resnet people seeing if they can login to the
hubs and get some kind of stats to fidn out if there is a general
problem with collisions...

> 
> > Jan 28 20:26:06 bouncybouncy kernel: eth0: reset finished after 10005
> > microseconds.
> 
> The "You have reset me too many times. Go away." error.
> 
> 
> > After reloading the driver it started working again:
> > 
> > linuxfet.c : v3.23 05/15/2001
> >   The PCI BIOS has not enabled the device at 0/144!  Updating PCI
> > command 0003->0007.
> > eth0: VIA PCI 10/100Mb Fast Ethernet Adapter                      
> > eth0: IO Address = 0xe800, MAC Address = 00:50:2c:01:64:a9, IRQ = 11.
> > eth0: MII PHY found at address 1, status 0x782d advertising 01e1 Link
> > 0021.
> > eth0: netdev_open() irq 11.
> > eth0: Done netdev_open(), status 881a MII status: 782d.
> 
> 0003->0007 is that it turns on bus mastering. I have copied the code from
> the linuxfet driver that sets that bit. But for me that is set later by
> the pci_set_master function, and I think the warning is incorrect.
> 
> After reloading the linuxfet driver, does the via-rhine driver work better
> if you switch back to it without rebooting?
> 

Well...I tried...
ifdown eth0;rmmod linuxfet;modprobe via-rhine;ifup eth0 and it worked
fine for a minute. 

Then I went to switch back to linuxfet. somehow both modules got loaded
at the same time, rmmod'd them both and when I did ifup eth0 again it
locked up.

So I'm back to a 0 uptime using linuxfet again...I'll have to repatch
and build via-rhine...

one thing that I have noticed is that it only ever gets the 
"The PCI BIOS has not enabled the device at 0/144!  Updating PCI command 
0003->0007."
after via-rhine stops working and I load linuxfet.

-Justin 
