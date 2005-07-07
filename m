Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVGGTA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVGGTA5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVGGS6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:58:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36749 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261806AbVGGS5r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:57:47 -0400
Date: Thu, 7 Jul 2005 11:57:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Christoph Lameter <christoph@lameter.com>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
cc: Andi Kleen <ak@suse.de>, linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <Pine.LNX.4.62.0507071022480.7105@graphe.net>
Message-ID: <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jul 2005, Christoph Lameter wrote:
>
> On Thu, 7 Jul 2005, Linus Torvalds wrote:
> 
> > If you make it use a trivial inline function for the thing, I think that 
> > would be ok, though.
> 
> Like this?

Yes. Except that if hwif is NULL, we'll have other oopses since we access 
that in other places.

Why _is_ hwif NULL anyway? That's another, unrelated thing, and should 
probably have a separate check and an early return.

So there's two unrelated issues: hwif being NULL is a serious error
regardless of any node issues, and pci_dev being NULL just means we aren't
a PCI device.

Bartlomiej?

		Linus
