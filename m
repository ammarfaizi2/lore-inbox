Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSBNA31>; Wed, 13 Feb 2002 19:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289234AbSBNA3S>; Wed, 13 Feb 2002 19:29:18 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:2702 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289228AbSBNA3D>;
	Wed, 13 Feb 2002 19:29:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [patch] sys_sync livelock fix
Date: Thu, 14 Feb 2002 01:33:19 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213173811.12448H-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1020213173811.12448H-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16b9pv-0002QQ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 13, 2002 11:53 pm, Bill Davidsen wrote:
> On Wed, 13 Feb 2002, Daniel Phillips wrote:
> > >   Because people count on something broken we should keep the bug? You do
> > > realize that the sync may NEVER finish?
> > 
> > You do realize that if you lose your data you may NEVER get it back? ;-)
> 
> The sync doesn't protect my data, after my data has been written why
> should I care to wait while all the data in every active program in the
> system gets written. This makes checkpoints stop points on a busy system.

Sync should not wait for data written after the sync.  If it does, it's
broken and needs to be fixed.

> > > Your example is a good example of bad practive, since even with
> > > ext3 a program creating files quickly would lose data, even though the
> > > directory structure is returned to a known state, without stopping the
> > > writing processes the results are unknown.
> > 
> > Huh?  You know about journal commit, right?
> 
> Read or reread my other notes on that, journal prevents directory
> corruption, it doesn't prevent data loss like a database transaction.
> Returning to a known good state does not include "without losing any data
> written to unclosed files."

It's true, we get into great areas with ordered-data journalling, but it's
black and white with full data journalling.

> I leave it to Mr Reiser to clarify that or correct me if data is protected
> without using unbuffered writes.

-- 
Daniel
