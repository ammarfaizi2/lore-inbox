Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289236AbSBNAjK>; Wed, 13 Feb 2002 19:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSBNAi6>; Wed, 13 Feb 2002 19:38:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9491 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289236AbSBNAiz>;
	Wed, 13 Feb 2002 19:38:55 -0500
Message-ID: <3C6B06E5.F6A7AD9F@zip.com.au>
Date: Wed, 13 Feb 2002 16:37:57 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Bill Davidsen <davidsen@tmr.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com>,
		<Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16b9jW-0002QL-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On February 13, 2002 11:24 pm, Bill Davidsen wrote:
> > ...
> > It doesn't matter, if you write the existing dirty buffers the filesystem
> > type is irrelevant.
> 
> Incorrect.  The modern crop of filesystems has the concept of consistency
> points, and data written after a consistency point is irrelevant except to the
> next consistency point.  IOW, it's often ok to leave some buffers dirty on a
> sync.  But for a dumb filesystem you just have to guess at what's needed for
> a consistency point, and the best guess is 'whatever's dirty at the time of
> sync'.
> 
> For metadata-only journalling the issues get more subtle and we need a ruling
> from the ext3 guys.

The current implementation of fsync_dev is about as good as
it'll get for journal=writeback mode - write the data,
run a commit, write the data again then wait on it all.

> 
> Sorry, I don't see the connection to sync.

I don't understand the whole thread :)

The patch I sent yesterday, which is at
http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/sync_livelock.patch
provides sensible and safe sync semantics, and avoids livelock.

It'd be good if someone else could, like, apply and test it, rather
than sending out all this email and stuff.

-
