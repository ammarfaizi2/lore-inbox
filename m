Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268531AbUHLMy3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268531AbUHLMy3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 08:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268542AbUHLMy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 08:54:29 -0400
Received: from the-village.bc.nu ([81.2.110.252]:60628 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268531AbUHLMyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 08:54:24 -0400
Subject: Re: [PATCH] add PCI ROMs to sysfs
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Greg KH <greg@kroah.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Martin Mares <mj@ucw.cz>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
In-Reply-To: <20040811233148.13248.qmail@web14925.mail.yahoo.com>
References: <20040811233148.13248.qmail@web14925.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092311491.21995.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 12:51:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 00:31, Jon Smirl wrote:
> How are we supposed to implement this without a copy? Once the device
> driver is loaded there is never a safe way access the ROM again because
> an interrupt or another CPU might use the PCI decoders to access the
> other hardware and disrupt the ROM read. You have to copy the ROM when
> the driver says it is safe.

It's never safe essentially. The only way you can make it safe for this
case is to put the knowledge in the device driver for that specific card
rather than sysfs.

> Still another scheme would be to make the drivers for this class of
> card implement a lock around PCI address decoder use. That would get
> complex with interrupt routines.

That would be impossible in fact because of DMA and SMM activity.

> How much trouble do we want to go to handling a case that only applies
> to very few cards? I believe old QLogic disk controllers have this
> problem, are there others? I'm not aware of any video cards with this
> problem. 99%+ of PCI ROMs don't need the copy.

It would be better to just to blacklist those corner cases

