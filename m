Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289954AbSA3RrH>; Wed, 30 Jan 2002 12:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290054AbSA3Rpj>; Wed, 30 Jan 2002 12:45:39 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:13054 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S290219AbSA3RpN>;
	Wed, 30 Jan 2002 12:45:13 -0500
Date: Wed, 30 Jan 2002 10:41:58 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Josh MacDonald <jmacd@CS.Berkeley.EDU>
Cc: Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
        Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alexander Viro <viro@math.psu.edu>,
        Rob Landley <landley@trommello.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130104158.C763@lynx.adilger.int>
Mail-Followup-To: Josh MacDonald <jmacd@CS.Berkeley.EDU>,
	Rik van Riel <riel@conectiva.com.br>, Ingo Molnar <mingo@elte.hu>,
	Larry McVoy <lm@bitmover.com>, Tom Rini <trini@kernel.crashing.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Alexander Viro <viro@math.psu.edu>,
	Rob Landley <landley@trommello.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0201301933390.11022-100000@localhost.localdomain> <Pine.LNX.4.33L.0201301445430.11594-100000@imladris.surriel.com> <20020130085902.C11593@helen.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020130085902.C11593@helen.CS.Berkeley.EDU>; from jmacd@CS.Berkeley.EDU on Wed, Jan 30, 2002 at 08:59:03AM -0800
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 30, 2002  08:59 -0800, Josh MacDonald wrote:
> Quoting Rik van Riel (riel@conectiva.com.br):
> > On Wed, 30 Jan 2002, Ingo Molnar wrote:
> > > On Wed, 30 Jan 2002, Larry McVoy wrote:
> > >
> > > > How much of the out order stuff goes away if you could send changes
> > > > out of order as long as they did not overlap (touch the same files)?
> > >
> > > could this be made: 'as long as they do not touch the same lines of
> > > code, taking 3 lines of context into account'? (ie. unified diff
> > > definition of 'collisions' context.)
> > 
> > That would be _wonderful_ and fix the last bitkeeper
> > problem I'm having once in a while.
> 
> This would seem to require a completely new tool for you to specify which 
> hunks within a certain file belong to which changeset.  I can see why
> Larry objects.  What's your solution?

Please see my other email on this subject (out of order BK CSETs).
One relatively easy solution is "proxy CSETs", which describe on a
per-line basis (or xdelta checksum boundaries, even better) the changes
made in "false parent" CSETs, but do not actually contain the changes.
This allows the reciever to resolve the false dependencies, and also
allows the sender to validate (at proxy CSET creation time) that the
out-of-order CSET they are about to send, in fact, does not depend on
any of the "false parent" CSETs.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

