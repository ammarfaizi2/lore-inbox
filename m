Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbSKNTQG>; Thu, 14 Nov 2002 14:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264842AbSKNTQG>; Thu, 14 Nov 2002 14:16:06 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2822 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263321AbSKNTQF>; Thu, 14 Nov 2002 14:16:05 -0500
Date: Thu, 14 Nov 2002 11:22:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Matthew Wilcox <willy@debian.org>
cc: Jeff Garzik <jgarzik@pobox.com>, <linux-kernel@vger.kernel.org>,
       <mochel@osdl.org>
Subject: Re: [PATCH] eliminate pci_dev name
In-Reply-To: <20021114184431.E30392@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0211141118290.4989-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Nov 2002, Matthew Wilcox wrote:
> 
> Sure, I can do that.  That leads me to think that maybe we should
> delete name from struct device and just use the one in struct kobject
> (which is already a mere 16 bytes).  But if we're going to go as far
> down as the kobject... that has a dentry.  And dentrys have names.
> So how about eliminating that too and just creating a dentry with the
> almost infinitely long name?

I like your thinking, but the "pci->name" is really just a descrition, and
what should maybe be in the kobject is the "address", which is
"pci->slotname". The two are quite fundamentally different (ie nobody 
should depend on "name" being unique or constant anything like that, while 
"slotname" is really a bus-level address (*)).

			Linus

(*) "slotname" is also not unique in general, it's only unique _within_ 
_that_ _bus_. With multiple PCI buses, for example, you can have two 
devices with the same slotname, if they are on separate segments.

