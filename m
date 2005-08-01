Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVHAUgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVHAUgv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 16:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVHAUfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 16:35:02 -0400
Received: from gold.veritas.com ([143.127.12.110]:36200 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S261222AbVHAUdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 16:33:02 -0400
Date: Mon, 1 Aug 2005 21:34:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: revert yenta free_irq on suspend
In-Reply-To: <200507312215.04494.rjw@sisk.pl>
Message-ID: <Pine.LNX.4.61.0508012117431.6027@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0507301952350.3319@goblin.wat.veritas.com>
 <Pine.LNX.4.61.0507302318090.5286@goblin.wat.veritas.com> <200507310109.16876.rjw@sisk.pl>
 <200507312215.04494.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 01 Aug 2005 20:33:00.0031 (UTC) FILETIME=[353E60F0:01C596D8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2005, Rafael J. Wysocki wrote:
> On Sunday, 31 of July 2005 01:09, Rafael J. Wysocki wrote:
> > 
> > Linus has apparently dropped that patch for yenta, but in case it is
> > reintroduced in the future you will probably need a patch to make the network
> > driver cooperate.  I'll try to prepare one tomorrow, if I can, but I have no hardware
> > to test it.
> 
> The patch follows.  It compiles and should work, though I haven't tested it.

Thanks for making the effort, Rafael,
but I'm afraid your patch does not solve it.

Prior to -rc4, or in current -git which has the yenta patch reverted,
my laptop manages APM resume from RAM with the following 8 messages
(I won't complain that it could list even more permutations!)

PCI: Found IRQ 11 for device 0000:00:1f.1
PCI: Sharing IRQ 11 with 0000:02:00.0
PCI: Found IRQ 11 for device 0000:02:00.0
PCI: Sharing IRQ 11 with 0000:00:1f.1
PCI: Found IRQ 11 for device 0000:02:01.0
PCI: Sharing IRQ 11 with 0000:02:01.1
PCI: Found IRQ 11 for device 0000:02:01.1
PCI: Sharing IRQ 11 with 0000:02:01.0

Unpatched -rc4 locks up on resume, showing none of those messages.
-rc4 with your drivers/net/3c59x.c patch locks up on resume,
after showing just the first four of those messages.

Whatever, I very much share the position Linus has expressed so
forcefully: it's foolish suddenly to demand changes in an indeterminate
number of drivers (surely yenta and 3c59x aren't the end of it?),
especially in the final days leading up to a release.

I surely would not have asked him to revert the yenta patch, nor would
he have done so (thank you, Linus), if my machine were the only problem.
It's very easy for me to carry my own patches to get working, but we
fear the trouble seen here gives a foretaste of others' trouble if
the changes were to remain in the release.

As to whether the changes should be retained in -mm, I simply don't
have an appreciation of the scope of the problems either way,
to have a worthwhile opinion.

Hugh
