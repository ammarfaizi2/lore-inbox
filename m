Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSH1KEz>; Wed, 28 Aug 2002 06:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318768AbSH1KEz>; Wed, 28 Aug 2002 06:04:55 -0400
Received: from [217.167.51.129] ([217.167.51.129]:56514 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S318767AbSH1KEy>;
	Wed, 28 Aug 2002 06:04:54 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Manfred Spraul <manfred@colorfullife.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@transmeta.com>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Date: Wed, 28 Aug 2002 12:03:51 +0200
Message-Id: <20020828100351.8648@192.168.4.1>
In-Reply-To: <20020828054001.B31036@jurassic.park.msu.ru>
References: <20020828054001.B31036@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Aug 26, 2002 at 10:12:24PM +0200, Benjamin Herrenschmidt wrote:
>> While we are at it, I still think the loop copying parent resource
>> pointers in the case of a transparent bridge should copy the 4
>> resource pointers of the parent and not only 3.
>
>I agree that hardcoding the resource numbers is bad.
>Instead, I suggest the following:
>s/bus->resource[0]/bus->io/
>s/bus->resource[1]/bus->mem/
>s/bus->resource[2]/bus->pref_mem/
>s/bus->resource[3]//
>
>There are only 3 _bus_ resources - the PCI works this way.
>
>Please don't propose your arch specific hacks to generic code.

I still don't agree, nothing in the _PCI_ force you to have
only 3 resources. a PCI 2 PCI bridge has 3 resources, here we
agree, but absolutely _nothing_ prevents a host bridge for
exposing more than one memory range, and that DOES happen
in a few real world cases like on pmac.

So we have this situation:

 - Most of the common PCI code can deal with an arbitrary
number & ordering of resources in the pci_bus structure
 - The pci_bus structure already holds 4 resource pointers
 - Copying the all 4 instead of just 3 will not have any
side effect on machines that expose only 2 or 3 host bridge
resources.

I really don't understand your point here. Nothing defines
that a host bridge has to comply with the resource layout of
a PCI<->PCI bridge, why limit ourselves arbitrarily here ?
Especially since we _already_ have 4, not 3 resource slots
in the pci_bus structure...

Ben.


