Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751153AbWBMCRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751153AbWBMCRu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 21:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751503AbWBMCRu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 21:17:50 -0500
Received: from [69.3.150.202] ([69.3.150.202]:43499 "EHLO
	alpha.penguintown.net") by vger.kernel.org with ESMTP
	id S1751153AbWBMCRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 21:17:49 -0500
Message-ID: <24624.209.213.198.25.1139797050.squirrel@mail.penguintown.net>
In-Reply-To: <20060208113838.A28024@jurassic.park.msu.ru>
References: <37389.10.0.0.8.1139352883.squirrel@mail>
    <20060208113838.A28024@jurassic.park.msu.ru>
Date: Sun, 12 Feb 2006 18:17:30 -0800 (PST)
Subject: Re: [PATCH 2.6.15.3] alpha/pci: set cache line size for cards 
     ignored by SRM
From: "Gabriele Gorla" <gorlik@penguintown.net>
To: "Ivan Kokshaysky" <ink@jurassic.park.msu.ru>
Cc: "Gabriele Gorla" <gorlik@penguintown.net>, rth@twiddle.net, gregkh@suse.de,
       linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Feb 07, 2006 at 02:54:43PM -0800, Gabriele Gorla wrote:
>> Set the cache line size in the PCI configuration space to a reasonable
>> value. SRM does not seem to set this register for the PCI cards that it
>> does not recognize. This makes drivers that expect cache line size to be
>> set by the card bios work on alpha.
>
> I don't see such drivers in the mainline.
that sata_sil driver uses the cache line register to tune some FIFO
registers.

> Anyhow, the PCI_CACHE_LINE_SIZE setting is critical only for devices
> that do memory-write-invalidate. In this case a driver must call
> pci_set_mwi() which takes care of PCI_CACHE_LINE_SIZE.
sata_sil is not capable of MWI so it does not call pci_set_mwi()

I looked at the config space on a PC and alpha before the sata_sil driver
is loaded and it is different.
I suspect on the PC the system bios or the card bios set up this register
during post.

The sata_sil driver may not be doing the correct thing, however it seems
reasonable to assume that the device is configured properly (by system
bios or kernel fixup) before the driver init code executes.
This seems the same behavior of ppc and sparc64 pci code as well.

thanks,
GG

