Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289270AbSBNApK>; Wed, 13 Feb 2002 19:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSBNAo7>; Wed, 13 Feb 2002 19:44:59 -0500
Received: from dsl-213-023-039-092.arcor-ip.net ([213.23.39.92]:12174 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289270AbSBNAot>;
	Wed, 13 Feb 2002 19:44:49 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: [patch] sys_sync livelock fix
Date: Thu, 14 Feb 2002 01:49:03 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16b9jW-0002QL-00@starship.berlin> <3C6B06E5.F6A7AD9F@zip.com.au>
In-Reply-To: <3C6B06E5.F6A7AD9F@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16bA59-0002Qa-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 14, 2002 01:37 am, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > On February 13, 2002 11:24 pm, Bill Davidsen wrote:
> > > ...
> > > It doesn't matter, if you write the existing dirty buffers the filesystem
> > > type is irrelevant.
> > 
> > Incorrect.  The modern crop of filesystems has the concept of consistency
> > points, and data written after a consistency point is irrelevant except to the
> > next consistency point.  IOW, it's often ok to leave some buffers dirty on a
> > sync.  But for a dumb filesystem you just have to guess at what's needed for
> > a consistency point, and the best guess is 'whatever's dirty at the time of
> > sync'.
> > 
> > For metadata-only journalling the issues get more subtle and we need a ruling
> > from the ext3 guys.
> 
> The current implementation of fsync_dev is about as good as
> it'll get for journal=writeback mode - write the data,
> run a commit, write the data again then wait on it all.

What's the theory behind writing the data both before and after the commit?

> > 
> > Sorry, I don't see the connection to sync.
> 
> I don't understand the whole thread :)

Dangerous advocacy of the broken SuS semantics for sync, has to be stamped
out before it spreads ;-)

-- 
Daniel
