Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267968AbRGZN6x>; Thu, 26 Jul 2001 09:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267973AbRGZN6n>; Thu, 26 Jul 2001 09:58:43 -0400
Received: from pD951F257.dip.t-dialin.net ([217.81.242.87]:13188 "EHLO
	emma1.emma.line.org") by vger.kernel.org with ESMTP
	id <S267968AbRGZN61>; Thu, 26 Jul 2001 09:58:27 -0400
Date: Thu, 26 Jul 2001 15:58:33 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: ext3-2.4-0.9.4
Message-ID: <20010726155833.P17244@emma1.emma.line.org>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
	"ext3-users@redhat.com" <ext3-users@redhat.com>
In-Reply-To: <20010726151749.M17244@emma1.emma.line.org> <Pine.LNX.4.33L.0107261020570.20326-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0107261020570.20326-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.19i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thu, 26 Jul 2001, Rik van Riel wrote:

> On Thu, 26 Jul 2001, Matthias Andree wrote:
> > On Thu, 26 Jul 2001, Rik van Riel wrote:
> >
> > > In fact, knowing how hard disks work mechanically, only
> > > journaling filesystems could have an extention to make
> > > this work.  Ie. this is NOT something you can rely on ;)
> >
> > This is not about failing hard disks. It is about premature
> > acknowledgment of something which has not happened at that time.
> 
> So you didn't read what I was writing.

Sorry.

> Let me explain it to you slowly:
> 
> Disks.  Write.  One.  Write.  At.  A.  Time.
> 
> A rename often needs as many as 4 or 5 writes,
> ergo, you CANNOT do a rename atomically without
> journaling and transactions.

You're missing the point, with this as the previous mail. The MTA is not
going to change from one unsupported/incompatible interface (that only
Linux suffers from) and if it did, it would still do the wrong thing.

MTAs often run multiple processes, and if these all open the same
directory and sync it while others have changes open that don't need a
sync at that time and will sync later, you're getting no further than
with chattr +S or mount -o sync.

It's not about atomicity itself, but about
first. write. all. required. blocks. for. a. certain. change.
physically. to. disc.   and. only. after. this. do. return. from.
rename, link, unlink. function. calls.

I'm aware of phase-tree concepts ("single block write switches from one
consistent state to another") and I'm aware that ext3fs and reiserfs do
feature atomic renames (after crash recovery).

That a drive might fall over or the power might fail before all writes
of a certain rename operation have completed is harmless UNLESS you lied
to someone that the operation was already complete (when it wasn't).

> > The competition is there and it has names: BSD + ufs + softupdates,
> > Solaris + logging ufs. Read MTA mailing lists before obstructing.
> 
> BSD + softupdates is physically incapable of doing what
> you suggest it does.  This can be proven from the lack
> of transactions and the way hard disks work physically.

You misunderstood me. I'm not talking about atomicity.

-- 
Matthias Andree
