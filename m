Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVCUNxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVCUNxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 08:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVCUNxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 08:53:17 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:35534 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261481AbVCUNxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 08:53:12 -0500
Date: Mon, 21 Mar 2005 16:53:10 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] alpha build fixes
Message-ID: <20050321165310.A10078@jurassic.park.msu.ru>
References: <423BABBF.6030103@pobox.com> <20050319231116.GA4114@twiddle.net> <20050319231641.GA28070@havoc.gtf.org> <58cb370e0503210005358cf200@mail.gmail.com> <20050321121616.A24129@jurassic.park.msu.ru> <58cb370e0503210145375f5092@mail.gmail.com> <1111408059.25180.277.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1111408059.25180.277.camel@gaston>; from benh@kernel.crashing.org on Mon, Mar 21, 2005 at 11:27:39PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 11:27:39PM +1100, Benjamin Herrenschmidt wrote:
> IRQs on IDE in legacy mode is sort of an out-of-spec piece of junk that
> was invented to make PCI based peecees "look like" good old rotten
> hardware, unfortunately, some modern and non-x86 HW vendors still don't
> haev a clue and configure (wire in some case) their on board IDE in
> legacy mode, but with IRQs that, on those archs, aren't 14 and 15. That
> hook fixes the problem on some ppc64 machines but should be extended to
> cover various other cases where similar shit happens.

Indeed, such setup is quite typical for southbridge chips with
integrated IDE controller - they still simulate sort of ISA IRQ
routing...

> It's in PCI because I figured it was as bad there than anywhere else. In
> this case, it's the IDE layer asking the PCI layer "hey, that guy
> doesn't respect the normal PCI IRQ mapping, can you tell me how it's
> routed ?" :) Back then, I didn't know of a header shared between ide and
> libata so I put it there.

Ok, but asm-generic/pci.h is not a good place for default IRQ 14/15 case -
this header cannot be included on non-x86 without additional #ifdef's.
Perhaps we can move it to linux/pci.h or linux/ata.h (as Bart noted)?

Ivan.
