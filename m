Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTA1RN4>; Tue, 28 Jan 2003 12:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbTA1RN4>; Tue, 28 Jan 2003 12:13:56 -0500
Received: from [217.167.51.129] ([217.167.51.129]:20451 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S267377AbTA1RNy>;
	Tue, 28 Jan 2003 12:13:54 -0500
Subject: Re: [patch 2.5] VGA IO on systems with multiple PCI IO domains
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Mares <mj@ucw.cz>,
       Richard Henderson <rth@twiddle.net>,
       "Wiedemeier, Jeff" <Jeff.Wiedemeier@hp.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <20030128201057.A690@jurassic.park.msu.ru>
References: <20030128132406.A9195@jurassic.park.msu.ru>
	 <Pine.GSO.4.21.0301281126390.9269-100000@vervain.sonytel.be>
	 <20030128201057.A690@jurassic.park.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043774595.536.4.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 28 Jan 2003 18:23:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-28 at 18:10, Ivan Kokshaysky wrote: 
> Here's the patch that converts vgacon.c to pci_request_legacy_resource().
> Tested on i386 and a single-bus alpha (alpha specific bits not included
> here).
> 
> Note that it breaks ppc, as VGA_MAP_MEM() is removed...

Ok, if I understand properly, all we have to do on PPC is to implement a
pci_request_legacy_resource() that will do the right thing for legacy
VGA memory as well ?

Then, please, check the return value of pci_request_legacy_resource()
for getting to the VGA memory. Some machines (typically PowerMacs)
simply don't give you a way to generate PCI cycles to those low memory
addresses (you can't do VGA on those).

Disabling VGA dynamically depending on the machine have been a real pain
until now. With that change, it will now just be a matter for our PPC
implementation of pci_request_legacy_resource() to fail on machines
where VGA memory can't be reached.

Ben.



