Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291378AbSBMFXo>; Wed, 13 Feb 2002 00:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291381AbSBMFXZ>; Wed, 13 Feb 2002 00:23:25 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:34055 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S291378AbSBMFXP>; Wed, 13 Feb 2002 00:23:15 -0500
Date: Wed, 13 Feb 2002 00:21:45 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <3C69EBB7.24EA9C05@zip.com.au>
Message-ID: <Pine.LNX.3.96.1020213000859.8487A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2002, Andrew Morton wrote:

> IMO, the SuS definition sucks.  We really do want to do our best to
> ensure that pending writes are committed to disk before sys_sync()
> returns.  As long as that doesn't involve waiting until mid-August.

  The current behaviour allows the system to hang forever waiting for
sync(2). In practice it does actually wait minutes on a busy system (df
has --no-sync for that reason) when there is no reason for that to happen.
I think that not only sucks worse, it's non-standard as well.
 
> For example, ext3 users get to enjoy rebooting with `sync ; reboot -f'
> to get around all those silly shutdown scripts.  This very much relies
> upon the sync waiting upon the I/O.

  Because people count on something broken we should keep the bug? You do
realize that the sync may NEVER finish? That's not in theory, I have news
servers which may wait overnight without finishing a "df" iwthout the
option.
 
> I mean, according to SUS, our sys_sync() implementation could be
> 
> asmlinkage void sys_sync(void)
> {
> 	return;
> }
> 
> Because all I/O is already scheduled, thanks to kupdate.

  I think the wording is queued, and I would read that as "on the
elevator." Your example is a good example of bad practive, since even with
ext3 a program creating files quickly would lose data, even though the
directory structure is returned to a known state, without stopping the
writing processes the results are unknown.

> But we want sync to be useful.

  No one has proposed otherwise. Unless you think that a possible hang is
useful, the questions becomes adding all dirty buffers to the elevator,
then (a) waiting or (b) returning. Either satisfies SuSv2.
 
> 
> > 
> >   If this were only a performance issue I wouldn't push for prompt
> > implementation, but anything which can hang the system, particularly in
> > shutdown, is bad.
> > 
> 
> If shutdown hangs, it's probably due to something else.

  If you discount the evidence you can prove anything... or disbelieve
anything.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

