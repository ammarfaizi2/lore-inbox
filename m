Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbVHXUVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbVHXUVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 16:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVHXUVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 16:21:04 -0400
Received: from mail1.kontent.de ([81.88.34.36]:64901 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932121AbVHXUVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 16:21:03 -0400
From: Oliver Neukum <oliver@neukum.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: question on memory barrier
Date: Wed, 24 Aug 2005 22:21:00 +0200
User-Agent: KMail/1.8
Cc: "Andy Isaacson" <adi@hexapodia.org>,
       "moreau francis" <francis_moreau2000@yahoo.fr>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0508240854550.28064@chaos.analogic.com> <20050824194836.GA26526@hexapodia.org> <Pine.LNX.4.61.0508241559450.31759@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0508241559450.31759@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508242221.00834.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The sequence point argument is obviously wrong, BTW - if it were the
> > case that a mere sequence point required the compiler to have completed
> > all externally-visible side effects, then almost every optimization that
> > gcc does with -O2 would be impossible.  CSE, loop splitting, etc.
> >
> > -andy
> 
> 
> Wrong. Reference:
> 
> http://www.phy.duke.edu/~rgb/General/c_book/c_book/chapter8/sequence_points.html

This refers to externally visible in the view of _one_ cpu , not other
CPUs or other hardware on a bus.
Externally visible means by references to other routines.
In practice function calls.

m = a * b;
c += m;
x(c);
d -= m;
y(d);

is better than

c += (a * b);
x(c);
d -= (a * b);
y(d);

But this doesn't tell much more. The compiler is free to generate code that
acts like all values hit main memory at a ;. Only where it can't tell, it really
needs to write it out. Writes to memory may or may not be of that category,
it depends on how far aliasing can be computed.
In any case nothing of that applies to the order data goes onto the bus.

	Regards
		Oliver
