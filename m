Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129648AbQKYTBc>; Sat, 25 Nov 2000 14:01:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129770AbQKYTBW>; Sat, 25 Nov 2000 14:01:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11788 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S129648AbQKYTBO>;
        Sat, 25 Nov 2000 14:01:14 -0500
Date: Sat, 25 Nov 2000 18:30:36 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Roger Larsson <roger.larsson@norran.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nigel Gamble <nigel@nrg.org>
Subject: Re: *_trylock return on success?
Message-ID: <20001125183036.Q2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <00112516072500.01122@dox> <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.21.0011251547210.8818-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Sat, Nov 25, 2000 at 03:49:25PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2000 at 03:49:25PM -0200, Rik van Riel wrote:
> On Sat, 25 Nov 2000, Roger Larsson wrote:
> 
> > Questions:
> >   What are _trylocks supposed to return?
> 
> It depends on the type of _trylock  ;(
> 
> >   Does spin_trylock and down_trylock behave differently?
> >   Why isn't the expected return value documented?
> 
> The whole trylock stuff is, IMHO, a big mess. When you
> change from one type of trylock to another, you may be
> forced to invert the logic of your code since the return
> code from the different locks is different.
> 
> For bitflags, for example, the trylock returns the state
> the bit had before the lock (ie. 1 if the thing was already
> locked).

I assume you're talking about test_and_{set,clear}_bit here.  Their return
value isn't consistent with the other _trylock functions since they're not
_trylock functions.

I think the real problem is that people use test_and_set_bit for locks,
which is almost never[1] a good idea.  The overhead for a semaphore shouldn't
be too much in most cases, and that way it is obvious what you want to do -
and, hopefully, even more obvious if you end up with a semaphore that can
be turned into a spinlock without further changes.

> For spinlocks, it'll probably return something else ;/

_trylock functions return 0 for success.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
