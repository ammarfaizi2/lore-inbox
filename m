Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbREUN5q>; Mon, 21 May 2001 09:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbREUN5g>; Mon, 21 May 2001 09:57:36 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:60617 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261497AbREUN5c>; Mon, 21 May 2001 09:57:32 -0400
Date: Mon, 21 May 2001 15:57:24 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
        Richard Gooch <rgooch@ras.ucalgary.ca>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
Message-ID: <20010521155724.S754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <17695.990377825@redhat.com> <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0105201150110.7553-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, May 20, 2001 at 12:02:35PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 20, 2001 at 12:02:35PM -0700, Linus Torvalds wrote:
> The problem with ioctl's is, let me repeat, not technology.
> 
> It's people.
> 
> ioctl's are a way to do ugly things. That's what they have ALWAYS been.
> And because of that, people don't care about following the rules - if
> ioctl's followed the rules, they wouldn't _be_ ioctls in the first place,
> but instead have a good interface (say, read()/write()).
> 
> Basically, ioctl's will _never_ be done right, because of the way people
> think about them. They are a back door. They are by design typeless and
> without rules. They are, in fact, the Microsoft of UNIX.
 
Yes, they are. Why? Because we cannot fit all behavior of a
devices _cleanly_ into read/write/mmap/lseek.

If we do, we would need different device views (which implies
aliasing of devices, which HPA does not like) and it would
still be not that clean, because reading from readonly gives a
stream and writing gives a stream too, not particular order
required until now.

[good points]

> Would fs/ioctl.c be an ugly mess of some special cases? Yes. But would
> that make the ugliness explicit and possibly easier to try to manage and
> fix? Very probably. And it would mean that driver writers could not just
> say "fuck design, I'm going to do this my own really ugly way". 

Ok, then I give you an real world example where I idly fight with
design since nearly 2 years.

A free programmable DSP (or set of DSPs) with several kinds of
memory and additional optional devices (like DAC/ADC, ISDN frames
and sth. like that) on it. This DSP is attached via some glue
logic on Parallel port, PCI, ISA or (soon to come) USB.

This thingie can (once programmed) act as a data sink, data
source or data processing pipe.

OTOH it should be randomly accessable via debuggers and program
loaders. It is also resettable/rebootable, has discontinous
memory of certain kinds (possibly harvard architecture) and many
more funny stuff. And it needs to upload software.

I try to unify all these stuff into a "Generic Processing Device
Layer" for Linux.

Now I like to be shown how I should fit this into clean design
that:

   - uses NO ioctls (Linus)
   - has only one device per DSP (H.P.A)
   - Does not emulate ioctls via read/write transactions (which I
     consider bogus)

Theory is nice, but until someone can show me a clean design for
this (admittedly heavy ;-)) example, I just don't buy your
arguments. 

A *better* ioctl would be nice, but we still need an "catch all
exceptional accesses" interface, IMNSHO.


Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
