Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTIOK6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 06:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbTIOK6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 06:58:39 -0400
Received: from deadlock.et.tudelft.nl ([130.161.36.93]:27520 "EHLO
	deadlock.et.tudelft.nl") by vger.kernel.org with ESMTP
	id S261240AbTIOK6d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 06:58:33 -0400
Date: Mon, 15 Sep 2003 12:58:26 +0200 (CEST)
From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
To: "David S. Miller" <davem@redhat.com>
cc: mroos@linux.ee, <linux-kernel@vger.kernel.org>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
In-Reply-To: <20030915011159.250f3346.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0309151225300.24675-100000@deadlock.et.tudelft.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 15 Sep 2003, David S. Miller wrote:

> > Ok. The sparc code has not been modified; something weird is going on. (By
> > the way, the Sparc code could use some design improvement, as a special
> > exception, the Sparc does backcalculation and it is hacky implemented).

> Any time someone messes with the clock timing code, they always
> break Sparc.

Ok, sorry. It is necessary. The modern kinds of Mach64 (all Rage chips)
need asynchrone clocks. For example the Rage Mobility needs 83 MHz memory
and 125 MHz core. With the old code the memory was overclocked 50%. The
chip can never function correctly at those speeds and it can even be
considered dangerous.

> We have to make assumptions about several things, one of which
> is the clock crystal used because the Sun firmware provides
> no way to just guess this so we just have to know what it is.

> Second, as you mention we reverse calculate the clocks to turn the
> video mode the firmware brought the card up in into the parameters the
> driver wants.

I see.

The proper way do this would be to have a few methods of determining
parameters. I.e. the x86 and Alpha can read them from the Bios, the
PowerPC from the open firmware. Some platforms can use tables and others
might need backcalculation. If this is programmed a bit modular other
platforms can use the backcalculation too, i.e. Atyfb does not run on some
68000 Macintosh laptops because they need backcalculation too.

> Please, can we revert your changes if we can't fix Sparc quickly?

Well, the problem is, there are really a *lot* of chips sold which I
fixed. Without doubt a number of Sparcs have been soldd, but there have
been millions of laptops sold with the Rage LT PRO and Rage Mobility.
The Rage XL is, after 5 years still in production, used in a lot of
servers and still available in shops. They all need this code.

So, preferably, let's fix this as soon as possible, so we don't need to
make a trade off between the laptops and the Sparcs.

> This
> is a pretty serious regression you've added and I have this feeling it's
> going to stay broke for some time as you go back and forth with us
> trying to resolve this.

Well, the only way to fix this is to work with you of course. Without LCD
support compiled in the behaviour should be much the same as before, there cannot
be a lot of problems. Should it stay broken for a long time, then we can
of course discuss what to do.

Daniël


