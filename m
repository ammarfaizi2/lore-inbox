Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267787AbTAMKC4>; Mon, 13 Jan 2003 05:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267821AbTAMKC4>; Mon, 13 Jan 2003 05:02:56 -0500
Received: from [213.196.40.44] ([213.196.40.44]:10701 "EHLO blackstar.nl")
	by vger.kernel.org with ESMTP id <S267787AbTAMKCy>;
	Mon, 13 Jan 2003 05:02:54 -0500
Date: Mon, 13 Jan 2003 09:43:09 +0100 (CET)
From: Bas Vermeulen <bvermeul@blackstar.nl>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Mikael Pettersson <mikpe@csd.uu.se>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] cardbus/hotplugging still broken in 2.5.56
In-Reply-To: <Pine.LNX.4.44.0301111659230.2174-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.33.0301130938140.8026-100000@devel.blackstar.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2003, Zwane Mwaikambo wrote:

> yOn Sat, 11 Jan 2003, Mikael Pettersson wrote:
> 
> > Cardbus/hotplugging is still broken in 2.5.56. Inserting a
> > card fails due a bogus 'resource conflict', and ejecting it
> > oopses the kernel. It's been this way since 2.5.4x-something.
> > 
> > Dell Latitude, Texas PCI1131 cardbus bridge, 3c575_cb NIC.
> 
> I think its a matter of resource collisions only and the oops is 
> inadequate cleanup on failure. I've tested cardbus/hotplugging on a TI PCI1211 and 
> Tulip 21142 based NIC. Perhaps find the last working kernel?

I've got the same problem as the one above, with a Realtek rtl8139.
The problem I'm seeing is that 

dev->resource[0].start == 0x00000000 and dev->resource[0].end == 0xff

which will not jive with various checks in pcibios_enable_device()

It's still working in 2.4.21-pre3, and the last kernel I was able to boot 
succesfully was 2.5.48, although I know for a fact that 2.5.54 already had 
the problem. 

Hardware on my laptop (Inspiron 8000) is a TI PCI1445 cardbus bridge.

Bas Vermeulen

-- 
"God, root, what is difference?" 
	-- Pitr, User Friendly

"God is more forgiving." 
	-- Dave Aronson

