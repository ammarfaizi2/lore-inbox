Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319262AbSHWULC>; Fri, 23 Aug 2002 16:11:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319263AbSHWULC>; Fri, 23 Aug 2002 16:11:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38673 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319262AbSHWULB>; Fri, 23 Aug 2002 16:11:01 -0400
Date: Fri, 23 Aug 2002 13:16:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Pavel Machek <pavel@suse.cz>
cc: Oliver Xymoron <oxymoron@waste.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] (0/4) Entropy accounting fixes
In-Reply-To: <20011102103427.Z35@toy.ucw.cz>
Message-ID: <Pine.LNX.4.33.0208231311150.4148-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 2 Nov 2001, Pavel Machek wrote:
> 
> Actually, no. If something is not predictable it does not mean >= 1 bit.

I agree. It might be less than one bit. However, I suspect that you can 
basically almost never predict the _exact_ TSC value, which implies that 
there is one or more bits of true randomness there.

If you can predict it (exactly) a noticeable fraction of the time, there
is clearly less than one bit of randomness.

To some degree it _should_ be fairly easy to test this even without a GHz
scope - just put two totally idle machines, connect them directly with a
cross-over cable, and make one of them send packets as quickly as it can
using something like "ping -f" with no route back to the sender (ie make
the ethernet card on the sending machine be your "exact clock" for sending
purposes).

Then record the stream of TSC on the receiving machine, and if you can
generate a function to predict a noticeable percentage of them exactly,
you've shown that it's much less than 1 bit of information.

Maybe somebody would find this an interesting exercise.

		Linus

