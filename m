Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261472AbSIWX5z>; Mon, 23 Sep 2002 19:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSIWX5z>; Mon, 23 Sep 2002 19:57:55 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:22634 "HELO
	pirx.hexapodia.org") by vger.kernel.org with SMTP
	id <S261472AbSIWX5y>; Mon, 23 Sep 2002 19:57:54 -0400
Date: Mon, 23 Sep 2002 19:03:06 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Bill Davidsen <davidsen@tmr.com>, Larry McVoy <lm@bitmover.com>,
       Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020923190306.D13340@hexapodia.org>
References: <Pine.LNX.3.96.1020923152135.13351C-100000@gatekeeper.tmr.com> <Pine.LNX.4.44.0209232218320.2118-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0209232218320.2118-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Sep 23, 2002 at 10:32:00PM +0200
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 10:32:00PM +0200, Ingo Molnar wrote:
> On Mon, 23 Sep 2002, Bill Davidsen wrote:
> > The programs which benefit from N:M are exactly those which don't behave
> > the way you describe. [...]
> 
> 90% of the programs that matter behave exactly like Larry has described.
> IO is the main source of blocking. Go and profile a busy webserver or
> mailserver or database server yourself if you dont believe it.

There are heavily-threaded programs out there that do not behave this
way, and for which a N:M thread model is completely appropriate.  For
example, simulation codes in operations research are most naturally
implemented as one thread per object being simulated, with virtually no
IO outside the simulation.  The vast majority of the computation time in
such a simulation is spent doing small amounts of work local to the
thread, then sending small messages to another thread via a FIFO, then
going to sleep waiting for more work.

Of course this can be (and frequently is) implemented such that there is
not one Pthreads thread per object; given simulation environments with 1
million objects, and the current crappy state of Pthreads
implementations, the researchers have no choice.

-andy
