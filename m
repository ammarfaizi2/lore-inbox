Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264797AbSLFRe7>; Fri, 6 Dec 2002 12:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264908AbSLFRe7>; Fri, 6 Dec 2002 12:34:59 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:20452 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264797AbSLFRe6>; Fri, 6 Dec 2002 12:34:58 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 6 Dec 2002 09:39:24 -0800
Message-Id: <200212061739.JAA22230@baldur.yggdrasil.com>
To: willy@debian.org
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Dec 2002, Matthew Wilcox wrote:
>Machines built with PCXS and PCXT processors are guaranteed not to have
>PCI.  So this only becomes a problem when supporting non-PCI devices.
>The devices you mentioned -- 53c700 & 82596 -- are core IO and really do
>need to be supported.  There's also a large userbase for these machines,
>dropping support for them is not an option.

Back on 7 Nov 2002, James Bottomley wrote:
| The ncr8xxx driver is another one used for the Zalon controller in parisc, so
| it will eventually have the same issues.

	How many other drivers beyond these three do we expect to
need similar sync points if the T class remains unsupported?

>T class machines don't have PCI slots per se, but they do have GSC
>slots into which a card can be plugged that contains a Dino GSC to PCI
>bridge and one or more PCI devices.  Examples of cards that are like
>this include acenic, single and dual tulip.

	Regarding the "T class", I would be intersted in knowing how
old it is, if it is discontinued at this point, how much of a user
base there is, and how many of these PCI-on-GSC cards there are.

	I was previously under the impression that there were some
parisc machines that could take some kind of commodity PCI cards and
lacked consistent memory.  If the reality is that only about six
drivers would ever have to be ported to use these sync points, then I
could see keeping dma_{alloc,free}_consistent, and moving the
capability of dealing with inconsistent memory to some wrappers in a
separate .h file (dma_alloc_maybe_consistent, dma_alloc_maybe_free).

	I suppose another consideration would be how likely it is that
a machine that we might care about without consistent memory will ship
in the future.  In general, the memory hierarchy is getting taller
(levels of caching, non-uniform memory access), but perhaps the
industry will continue to treat consistent memory capability as a
requirement.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
