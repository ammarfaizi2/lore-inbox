Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288976AbSANULc>; Mon, 14 Jan 2002 15:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289010AbSANUKK>; Mon, 14 Jan 2002 15:10:10 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:6587 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S288992AbSANUJb>;
	Mon, 14 Jan 2002 15:09:31 -0500
Date: Mon, 14 Jan 2002 15:09:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: David Lang <david.lang@digitalinsight.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, babydr@baby-dragons.com,
        linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
In-Reply-To: <Pine.LNX.4.40.0201141139370.22904-100000@dlang.diginsite.com>
Message-ID: <Pine.GSO.4.21.0201141452520.224-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jan 2002, David Lang wrote:

> doesn't matter, they are likly to be found on dedicated servers where
> the flexibility of modules is not needed and the slight performance
> advantage is desired.
> 
> making everything modular is fine for desktops/laptops but why should
> dedicated servers pay the price?

There should be no price.  And AFAICS that's doable.
 
> autoconfig is supposed to be an option, not the only way to compile a
> kernel (or are you saying that you don't want to be able to use your 1.2G
> athlon to build the kernel for your 486?)

autoconfig is completely separate story.  There are very good reasons to
avoid built-in/modular crap, regardless of the autoconf.  Every #ifdef MODULE
is a bug waiting to happen - simply because the stuff gets out of sync.
Every place that consists of
#ifdef CONFIG_FOO
	init_foo();
#endif
....
is a permanent source of PITA for out-of-tree drivers/patch merging/etc.
And that's aside of the fun with ordering, etc.

If we can get rid of performance hit on modular code - we should go
for that variant simply because it reduces the amount of bug sources.

Autoconfig and other details of ESR's Aunt Tillie fetish belong to
alt.sex.* - from time to time they may be amusing, but let's not
mix them with the technical arguments, OK?

