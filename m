Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129217AbQKHRV2>; Wed, 8 Nov 2000 12:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129429AbQKHRVT>; Wed, 8 Nov 2000 12:21:19 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:14599 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129217AbQKHRVF>; Wed, 8 Nov 2000 12:21:05 -0500
Date: Wed, 8 Nov 2000 09:20:46 -0800
From: Richard Henderson <rth@twiddle.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>, axp-list@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: PCI-PCI bridges mess in 2.4.x
Message-ID: <20001108092046.A27324@twiddle.net>
In-Reply-To: <20001101153420.A2823@jurassic.park.msu.ru> <20001101093319.A18144@twiddle.net> <20001103111647.A8079@jurassic.park.msu.ru> <20001103011640.A20494@twiddle.net> <20001106192930.A837@jurassic.park.msu.ru> <20001108013931.A26972@twiddle.net> <3A0977A7.53641C52@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A0977A7.53641C52@mandrakesoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 10:56:23AM -0500, Jeff Garzik wrote:
> Setting bit 1 in dev->resource[x].start, below, seems incorrect.  Should
> you be programming the PCI BAR directly, instead?

No, that's the reason this is a quirk.  The hardware is already
only responding to one and only one address.  The old code did
exactly the same thing, only not inside the quirk framework,
which made it kinda harder to figure out what was going on.

> I wonder about this code:
> 
> > +               /* ??? Reserve some resources for CardBus */
> > +               if (dev->class >> 8 == PCI_CLASS_BRIDGE_CARDBUS) {
> > +                       io_reserved += 8*1024;
> > +                       mem_reserved += 32*1024*1024;
> > +                       continue;
> > +               }

Got a better suggestion?  It does seem completely reasonable to
reserve some address space for a CardBus bridge if we find one.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
