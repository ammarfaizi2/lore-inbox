Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282875AbRK0IdZ>; Tue, 27 Nov 2001 03:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282873AbRK0IdF>; Tue, 27 Nov 2001 03:33:05 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:42505 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282868AbRK0Ic7>; Tue, 27 Nov 2001 03:32:59 -0500
Message-ID: <3C034F7E.96880768@zip.com.au>
Date: Tue, 27 Nov 2001 00:31:58 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Nathan G. Grennan" <ngrennan@okcforum.org>, linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org> <3C02C06A.E1389092@zip.com.au>,
		<3C02C06A.E1389092@zip.com.au> <20011127084234.V5129@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> I agree that the current i/o scheduler has really bad interactive
> performance -- at first sight your changes looks mostly like add-on
> hacks though.

Good hacks, or bad ones?

It keeps things localised.  It works.  It's tunable.  It's the best
IO scheduler presently available.

> Arjan's priority based scheme is more promising.

If the IO priority becomes an attribute of the calling process
then an approach like that has value.  For writes, the priority
should be driven by VM pressure and it's probably simpler just
to stick the priority into struct buffer_head -> struct request.
For reads, the priority could just be scooped out of *current.

If we're not going to push the IO priority all the way down from
userspace then you may as well keep the logic inside the elevator
and just say reads-go-here and writes-go-there.

But this has potential to turn into a great designfest.  Are
we going to leave 2.4 as-is?  Please say no.  

-
