Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318219AbSHZTBm>; Mon, 26 Aug 2002 15:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSHZTBm>; Mon, 26 Aug 2002 15:01:42 -0400
Received: from AMarseille-201-1-2-149.abo.wanadoo.fr ([193.253.217.149]:5744
	"EHLO zion.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S318219AbSHZTBj>; Mon, 26 Aug 2002 15:01:39 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Manfred Spraul <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [patch 2.5.31] transparent PCI-to-PCI bridges
Date: Mon, 26 Aug 2002 22:12:24 +0200
Message-Id: <20020826201224.528@192.168.4.1>
In-Reply-To: <20020826175747.A27952@jurassic.park.msu.ru>
References: <20020826175747.A27952@jurassic.park.msu.ru>
X-Mailer: CTM PowerMail 3.1.2 carbon <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Why not
>> 	if ((dev->class & 0xff) == 0x01)
>> 
>> Is the lowest bit an indicator of subtractive decoding, or is 
>> Progif==0x01 the indicator of subtractive decoding?
>
>The latter.
>
>> The code and the comment should match.
>
>Ok. Updated patch appended.

While we are at it, I still think the loop copying parent resource
pointers in the case of a transparent bridge should copy the 4
resource pointers of the parent and not only 3.
The structure pci_bus has 4 slots, let's copy them all, we really
don't need to care about the fact that the parent is a PCI<->PCI bridge
(using 3 slots), a Cardbus bridge, or a host bridge or whatever wants to
define a slighly different layout for those resources at this point, we
just want _all_ of the parent resources to be copied.

There are archs where host bridges may define 4 resources, I don't
see how it would break anything to take care of copying them all
and not only the first 3 ones ;) I know some code in setup-bus.c
won't cope well with such a layout, but it typically happens on arch
like PPC that don't use setup-bus.

Ben.

