Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbRFCCsR>; Sat, 2 Jun 2001 22:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbRFCCsH>; Sat, 2 Jun 2001 22:48:07 -0400
Received: from jcwren-1.dsl.speakeasy.net ([216.254.53.52]:45552 "EHLO
	jcwren.com") by vger.kernel.org with ESMTP id <S262746AbRFCCr6>;
	Sat, 2 Jun 2001 22:47:58 -0400
Reply-To: <jcwren@jcwren.com>
From: "John Chris Wren" <jcwren@jcwren.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: select() - Linux vs. BSD
Date: Sat, 2 Jun 2001 22:47:49 -0400
Message-ID: <NDBBKBJHGFJMEMHPOPEGIEBCCIAA.jcwren@jcwren.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> lost@l-w.net wrote:
> > Of course, not looking at the sets upon a zero return is a
> fairly obvious
> > optimization as there is little point in doing so.
>
> No; a fairly obvious optimisation is to avoid calling FD_ZERO if you
> can clear the bits individually when you test them.
>
> When you examine the sets, you can clear each bit that you examine and
> then you know you have a zero set.  Then you can set only the relevant
> bits for the next call to select().
>
> If you can't rely on the sets being cleared on a timeout, then you
> will have to call FD_ZERO in that case, or you will have to go through
> the list of descriptors and clear them individually.  (This can be
> avoided but it means keeping track of state between successive calls
> to select()).  This is contrary to the non-timeout case, where you
> stop checking bits when you have counted N of them set.
>
> So you see, there is a handy optimisation if you can assume the sets
> are zeroed on timeout.
>

I would have said just the opposite.  That if it you have a large number of
handles you're waiting on, and you have to go back through and set the bits
everytime you timeout that you would incur a larger overhead.  From the
perspective of my application, it would have been more efficient to not zero
them (I was waiting on a number of serial channels, and the timeout was used
to periodically pump more data to the serial channel.  When I received data,
I buffered it, and another thread took care of processing it).

It all really depends on the coding style of your program, and what you need
to do on a timeout.  Certain types of applications would benefit from
non-zero'ing, others from zeroing.

All what is *most* important is that the behavior is clearly understood and
well documented.  A google search made it pretty clear that it was a source
of confusion.

--John

