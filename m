Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRBHH7m>; Thu, 8 Feb 2001 02:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130678AbRBHH7f>; Thu, 8 Feb 2001 02:59:35 -0500
Received: from cs.columbia.edu ([128.59.16.20]:18601 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S129281AbRBHH7U>;
	Thu, 8 Feb 2001 02:59:20 -0500
Date: Wed, 7 Feb 2001 23:59:05 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@redhat.com>
cc: <vido@ldh.org>, <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        Andrey Savochkin <saw@saw.sw.com.sg>
Subject: Re: [PATCH] eepro100.c, kernel 2.4.1
In-Reply-To: <200102080742.f187gqK01498@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.30.0102072348550.29514-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Feb 2001, Alan Cox wrote:

> > It's the printk that gets it wrong, although that's harmless.
> > Intel's documentation states that the bug does NOT exist if the
> > bits 0 and 1 in eeprom[3] are 1. Thus, the workaround is correct,
> > the printk is wrong.
> 
> So why does it fix the problem for him. His report and your reply don't
> make sense viewed together

I don't think it fixes *this* bug. However, the bug workaround effectively
reinitializes the chip, so it might serve as a generic 'reset and try
again' kind of workaround. In that case, we might as well enable it
unconditionally... but I don't see it as a good solution. It's a stop-gap 
measure at best.

We need to find out what exactly happens. Until he tells us more about how 
his boxes "were failing before", there really isn't much we can diagnose.

I happen to also have an Intel ISP1100 box here, and I know what's inside 
-- i82559 C-step chips which definitely don't have this bug. The bug is an 
i82557-only bug; what makes things confusing is Intel idea of giving 
multiple chips the same PCI id. They can be identified via the PCI rev:

i82557 step A-C: rev 1-3
i82558 step A-B: rev 4-5
i82559 step A-C: rev 6-8

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
