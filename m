Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWDMUwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWDMUwO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 16:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWDMUwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 16:52:14 -0400
Received: from gate.crashing.org ([63.228.1.57]:27551 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932463AbWDMUwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 16:52:14 -0400
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to
	1GB, V2
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, paulus@samba.org,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060413160712.GG24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	 <20060413022809.GD24769@pb15.lixom.net>
	 <20060413025233.GE24769@pb15.lixom.net>
	 <20060413064027.GH10412@granada.merseine.nu>
	 <1144925149.4935.14.camel@localhost.localdomain>
	 <20060413160712.GG24769@pb15.lixom.net>
Content-Type: text/plain
Date: Fri, 14 Apr 2006 06:51:55 +1000
Message-Id: <1144961515.4935.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-13 at 11:07 -0500, Olof Johansson wrote:
> On Thu, Apr 13, 2006 at 08:45:49PM +1000, Benjamin Herrenschmidt wrote:
> > On Thu, 2006-04-13 at 09:40 +0300, Muli Ben-Yehuda wrote:
> > > On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> > > 
> > > > iommu=off can still be used for those who don't want to deal with the
> > > > overhead (and don't need it for any devices).
> > > 
> > > I've been pondering walking the PCI bus before deciding to enable an
> > > IOMMU and checking each device's DMA mask. Is this something that you
> > > considered and rejected, or just something no one got around to doing?
> > 
> > It would do the trick for airport cards in G5s.. a little bit of OF
> > walking to find the card.
> 
> Walking the DT means we need to hardcode it on PCI IDs, since the Apple
> OF doesn't give the Airport device a logical name. It's probably easier
> to implement than walking PCI, but we'd need to maintain a table. My
> vote is for PCI walking, I'll give that a shot over the weekend.

PCI walking it soo late to decide wether to enable the DART no ? In any
case, we need a table, so I wouldn't bother with PCI walking here.
Anyway... we should be able to have almost no perf. degradation or even
an improvement with the DART thanks to virtual merging. Currently, we
pay a cost due to our stupid invalidate mecanism that we should really
fix by shooting the TLB directly. Also have you made sure all your
additions for handling crappy hardware are nicely wrapped in unlikely()
statements ? :)

> > It won't help with cardbus broadcom's but then, there is currently no G5
> > with a cardbus adaptor that I know of :) It's possible I suppose to get
> > a pci<->cardbus adapter but I suppose in that case, we can ignore it ...
> 
> Yep, that should be rare enough.


