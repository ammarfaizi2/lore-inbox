Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318957AbSHMHWy>; Tue, 13 Aug 2002 03:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318958AbSHMHWx>; Tue, 13 Aug 2002 03:22:53 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28946 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318957AbSHMHWw>; Tue, 13 Aug 2002 03:22:52 -0400
Message-ID: <3D58B518.99C23D85@aitel.hist.no>
Date: Tue, 13 Aug 2002 09:28:24 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
References: <Pine.LNX.3.96.1020812230127.7583D-100000@gatekeeper.tmr.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> On Mon, 12 Aug 2002, Helge Hafting wrote:

> > My office desktop machine (256M RAM) rarely swaps more than 10M
> > during work with 2.5.30.  It used to go some 70M into swap
> > after a few days of writing, browsing, and those updatedb runs.
> 
> Now tell us how someone who isn't a VM developer can tell if that's bad or
> good. Is it good because it didn't swap more than it needed to, or bad
> because there were more things it could have swapped to make more buffer
> room?

It feels more responsive too - which is no surprise.  Like most users,
I don't _expect_ to wait for swapin when pressing a key or something.
Waiting for file io seems to be less of a problem, that stuff
_is_ on disk after all.  I guess many people who knows a little about
computers feel this way.  People that don't know what a "disk" is
may be different and more interested in total waiting.

On the serious side: vmstat provides more than swap info.  It also
lists block io, where one might see if the block io goes up or down.
I suggest to find some repeatable workload with lots of file & swap
io, and see how much we get of each.  My guess is that rmap
results in less io to to the same job.  Not only swap io, but
swap+file io too.  The design is more capable of selecting
the _right_ page to evict. (Assuming that page usage may
tell us something useful.)  So the only questions left is
if the current implementation is good, and if the
improved efficiency makes up for the memory overhead.

> 
> Serious question, tuning the -aa VM sometimes makes the swap use higher,
> even as the response to starting small jobs while doing kernel compiles or
> mkisofs gets better. I don't normally tune -ac kernels much, so I can't
> comment there.

Swap is good if there's lots of file io and
lots of unused apps sitting around.  And bad if there's a large working
set and little _repeating_ file io.  Such as the user switching between
a bunch of big apps working on few files.  And perhaps some
non-repeating
io like updatedb or mail processing...

Helge Hafting

Helge Hafting
