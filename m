Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291359AbSBMEyt>; Tue, 12 Feb 2002 23:54:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291372AbSBMEyj>; Tue, 12 Feb 2002 23:54:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:32775 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291359AbSBMEy1>; Tue, 12 Feb 2002 23:54:27 -0500
Date: Tue, 12 Feb 2002 23:53:23 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69E506.5DBE50A@mandrakesoft.com>
Message-ID: <Pine.LNX.3.96.1020212234356.8017I-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Jeff Garzik wrote:

> Bill Davidsen wrote:
> > 
> > Alan and/or Linus:
> > 
> >   Am I misreading this or is the Linux implementation of sync() based on
> > making the shutdown scripts pause until disk i/o is done? Because I don't
> > think commercial unices work that way, I think they work as SuS
> > specifies. More reason to rethink this in 2.4 as well as 2.5 and get the
> > possible live lock out of the kernel.
> 
> I don't think SuSv2 can be any more clear than:
> 
> > The writing, although scheduled, is not necessarily complete
> > upon return from sync().
> 
> Quoting from http://www.opengroup.org/onlinepubs/007908799/xsh/sync.html

  I don't see anything which says we can't implement sync(2) as your
checkpoint, as long as we don't keep the current implementation which
could hang forever in theory, and for hours in practice. I don't think
that violates the standard, and it should be safe.

  I said before that we could make sync(2) fast and just put up a barrier
to keep additional io from being queued, and I still like that. Pass on
the need for checkpoint, or the portability thereof. I would expect all
current programs to work if cync(2) worked like your checkpoint(2).

  Glad you read the SuSv2 the same way!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

