Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317169AbSHaKjD>; Sat, 31 Aug 2002 06:39:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317355AbSHaKjD>; Sat, 31 Aug 2002 06:39:03 -0400
Received: from [213.87.11.61] ([213.87.11.61]:8320 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id <S317169AbSHaKjC>;
	Sat, 31 Aug 2002 06:39:02 -0400
Date: Sat, 31 Aug 2002 14:42:23 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linus Torvalds <torvalds@transmeta.com>,
       Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Message-ID: <20020831144223.A772@localhost.park.msu.ru>
References: <20020831015716.B926@jurassic.park.msu.ru> <20020830201958.24112@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020830201958.24112@192.168.4.1>; from benh@kernel.crashing.org on Fri, Aug 30, 2002 at 10:19:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 30, 2002 at 10:19:58PM +0200, Benjamin Herrenschmidt wrote:
> First, a simple problem: You are showing a possible problem caused
> by a given PCI host & bridge setup. That's not my point. My point
> is that I _do_ have setups with N MMIO regions and want the kernel
> to be able to deal with that.

It's just an example. Give me real numbers and addresses and I'll show
you configuration with _real_ hardware which might work, but won't
with your approach.

> I'm not introducing any limitation to
> the code, I want the code to be generic enough to cope with a setup
> that exist (as the host is configured by my firmware).

You won't allow windows of the PCI bridge to overlap multiple ranges decoded
by the host bridge - it's a serious limitation, I think.

> Also, in your example, if I expose a single memory resource, then I
> lie since the host bridge in this example would not forward addresses
> "between" the 2 ranges, thus the kernel would potentially allocate
> space for unassigned devices in that non-decoded range.

Nope.  Arch specific pcibios_align_resource is called on every allocation
and should take care of this - read the code.

> I want my host pci_bus structure to expose what it is really forwarding.
> That's as simple as that. If your host is configured in a more "sane",
> way, then good.

Actually, no. Some old alphas have several (8, IIRC) PCI memory windows
with a 8Mb "hole" in each.

> Regarding your above example, it just don't happen in real life.
> First, we have AGP as a separate PCI host domain on pmac ;) Then,
> the firmware can configures host bridges with large enough regions
> to deal with what is needed by the card.

Pmac firmware is really cool then. ;-) Video cards with 256M memory
regions are quite common and 512M ones already exist.

Ivan.
