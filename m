Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315337AbSIBIiu>; Mon, 2 Sep 2002 04:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317521AbSIBIiu>; Mon, 2 Sep 2002 04:38:50 -0400
Received: from t10-145.gprs.mtsnet.ru ([213.87.10.145]:5504 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S315337AbSIBIit>; Mon, 2 Sep 2002 04:38:49 -0400
Date: Sat, 31 Aug 2002 17:12:27 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020831171227.B772@localhost.park.msu.ru>
References: <20020831022341.C926@jurassic.park.msu.ru> <20020831080942.518@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020831080942.518@192.168.4.1>; from benh@kernel.crashing.org on Sat, Aug 31, 2002 at 10:09:42AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 10:09:42AM +0200, Benjamin Herrenschmidt wrote:
> >Seriously, I see some implementation issues with "arbitrary number of
> >resources" approach. By now I don't know how to deal with them.
> 
> Ok, well, you should have said that first ;)

:-)
Well, probably I shouldn't care about it at all. The setup-bus.c could
be considered as PCI-to-PCI bridge driver which deals _only_ with
certain type of devices with fixed resource layout. If you can
make your host bridge look like this, fine. You'll be able to use some
nice tricks like reallocating host bridge resources.
If not, it's your problem. But you're still able to use routines from
setup-bus.c for any bus behind the PCI-PCI bridges.

> 
> Because what I'm asking (the change to pci_read_bridge_bases()) for
> copying all transparent bridge resources will just not affect setup-bus,
> so you shouldn't have a problem with it. Currently, setup-bus cannot deal
> with my hosts already, copying all 4 resources won't make this worse ;)

Ok, ok, I give up. :-)

> If your arch can use setup-bus today, it won't be harmed as it won't
> have anything in that 4th resource anyway.

True. Probably it's ok for 2.4, but it would be better to have something
sane for 2.5. We have already agreed that 4 is not much better than 3.
A single resource pointer and resource count fields would fork fine for
PCI and CardBus bridges, but will break most platforms where root bus
resources are randomly allocated structures.
I tend to agree about #define.

Ivan.
