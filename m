Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbSJHVV7>; Tue, 8 Oct 2002 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJHVV7>; Tue, 8 Oct 2002 17:21:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7441 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261362AbSJHVV6>; Tue, 8 Oct 2002 17:21:58 -0400
Date: Tue, 8 Oct 2002 14:29:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Patrick Mochel <mochel@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <andre@linux-ide.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] embedded struct device Re: [patch] IDE driver model update
In-Reply-To: <Pine.GSO.4.21.0210081616120.5897-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0210081425430.1457-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Oct 2002, Alexander Viro wrote:
> 
> Its reference counts mean squat if they are not seen by the code that
> allocates/frees the object struct device is embedded into.

But Al, that's the whole _point_ of having the callback.

Allow the refcounts to be in an embedded entity, and then anybody who gets 
the entity (_or_ the embedded thing) will increment the same count.

When the count goes to zero, the embedded thing needs to call the 
_embedders_ release function - because the embedded thing doesn't even 
know how it got allocated. 

Al, this time you're wrong, and the code you're unhappy about going about 
it the right way. The reference count _has_ to be held by the lowest-level 
thing (because that's the only generic part), yet the actual allocation 
and de-allocation is done by the higher levels. Which is why the lower 
levels need to know which freeing function to call.

		Linus

