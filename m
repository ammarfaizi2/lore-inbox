Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316538AbSHXRLU>; Sat, 24 Aug 2002 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSHXRLU>; Sat, 24 Aug 2002 13:11:20 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:38529 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S316538AbSHXRLT>;
	Sat, 24 Aug 2002 13:11:19 -0400
Message-ID: <3D67BFE2.6010403@colorfullife.com>
Date: Sat, 24 Aug 2002 19:18:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com, dhinds@sonic.net
Subject: Re: [PATCH] reduce size of bridge regions for yenta.c
References: <3D67A042.5030706@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dhinds pointed me to a recent thread with another possible workaround:

The ICH-3M bridge is actually a transparent bridge that forwards all 
memory IO:

<<<< ich-3M datasheet (29071601.pdf)

MEMBASE Memory Base Register (HUB-PCI D30:F0)
Offset Address: 20 21h Attribute: R/W
Default Value: FFF0h Size: 16 bits
This register defines the base of the hub interface to PCI 
non-prefetchable memory range. Since the ICH3 will forward all hub 
interface memory accesses to PCI, the ICH3 will only use this 
information for determining when not to accept cycles as a target. This 
register must be initialized by the configuration software. For the 
purpose of address decode, address bits A[19:0] are assumed to be 0. 
Thus, the bottom of the defined memory address range will be aligned to 
a 1-MB boundary.
<<<<

Perhaps a pci-quirk should set

	bus->resource[1] = bus->parent->resource[1];

for the ICH-3M.

No patch, I don't understand the pci layer good enough to write such a 
quirk.

But IMHO the changes to yenta.c should be applied anyway: allocating 8 
MB, without any fallback, without reasonable error output is gross.

--
	Manfred

