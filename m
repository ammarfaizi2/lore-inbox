Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264138AbUFFUwo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbUFFUwo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUFFUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 16:52:44 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:51587 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264134AbUFFUwf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 16:52:35 -0400
Subject: Re: Killing POSIX deadlock detection
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Matthew Wilcox <willy@debian.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
       Andrew Morton <akpm@osdl.org>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m165a4phy9.fsf@ebiederm.dsl.xmission.com>
References: <200406050725.i557P3hQ004052@supreme.pcug.org.au>
	 <20040606130422.0c8946b3.sfr@canb.auug.org.au>
	 <20040606132751.GZ5850@parcelfarce.linux.theplanet.co.uk>
	 <1086551360.5472.48.camel@lade.trondhjem.org>
	 <m165a4phy9.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086555145.7635.22.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 06 Jun 2004 16:52:27 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 06/06/2004 klokka 16:09, skreiv Eric W. Biederman:
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> > På su , 06/06/2004 klokka 09:27, skreiv Matthew Wilcox:
> > \
> > > > T1 locks file F1 -> lock (P1, F1)
> > > > P2 locks file F2 -> lock (P2, F2)
> > > > P2 locks file F1 -> blocks against (P1, F1)
> > > > T1 locks file F2 -> blocks against (P2, F2)
> > > 
> > > Less contrived example -- T2 locks file F2.  We report deadlock here too,
> > > even though T1 is about to unlock file F1.
> 
> There is a fairly sane linux specific definition here.  We should
> track these things not by pid or tid, but by struct files_struct.

RTFC... Look carefully in fs/locks.c at stuff like posix_same_owner().
We currently use both the tgid and the struct files_struct (although
there are a few notable bugs where we only check the one or the
other)...

That is, however, a definition which breaks the SUS standards, and it
therefore ends up introducing pathologies such as the steal_locks crap.
struct files_struct is NOT a sane basis for tracking locks.

> > Yes: As Chuck points out, that is a fairly nasty change of the userland
> > API.
> 
> ???? Failing to detect a deadlock is not a change in the API.
> It is simply a change in behavior.

It is a change in functionality from one where potential deadlocks are
detected and reported as errors to one where deadlocks are suddenly
possible. Are you saying that functionality is not a part of the API?


> Perhaps what we should do is simply not attempt to detect deadlocks
> involving threaded processes.

So how do you define (and detect) a threaded process?

Trond
