Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267997AbRHaQ2A>; Fri, 31 Aug 2001 12:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268071AbRHaQ1u>; Fri, 31 Aug 2001 12:27:50 -0400
Received: from [195.89.159.99] ([195.89.159.99]:41724 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S267997AbRHaQ1f>; Fri, 31 Aug 2001 12:27:35 -0400
Date: Fri, 31 Aug 2001 17:27:54 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Ion Badulescu <ionut@cs.columbia.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
Message-ID: <20010831172754.A25490@thefinal.cern.ch>
In-Reply-To: <Pine.LNX.4.33.0108300902570.7973-100000@penguin.transmeta.com> <Pine.LNX.4.33.0108301217280.9230-100000@age.cs.columbia.edu> <20010831135034.B25128@thefinal.cern.ch> <3B8F9507.859D584F@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B8F9507.859D584F@linux-m68k.org>; from zippel@linux-m68k.org on Fri, Aug 31, 2001 at 03:45:43PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> >    3. Warning added to GCC for signed vs. unsigned comparisons
> >       _regardless_ of type size.  This would also catch erroneous
> >       unsigned char vs. EOF checks in misuses of stdio.
> 
> Do you know of such bug in the context of min()?

I don't know of an actual example.  This one is made up:

       min (int, len, big_size)

Now if big_size has unsigned type, and does not fit in the range of int,
this expression will return the value of big_size cast to int, i.e. a
negative value.  The suggested warning would catch this potential bug.

I don't know if it would warn for too many other things.  Certainly, a
sizeof() exception (don't warn about signed comparison with sizeof()
result) is essential; perhaps too many other exceptions are required
too.

-- Jamie
