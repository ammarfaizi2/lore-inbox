Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318272AbSGRQbv>; Thu, 18 Jul 2002 12:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318274AbSGRQbv>; Thu, 18 Jul 2002 12:31:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:25864 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318272AbSGRQbt>; Thu, 18 Jul 2002 12:31:49 -0400
Date: Thu, 18 Jul 2002 12:29:25 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: stoffel@lucent.com
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Backups done right (was [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <15670.58295.8003.858959@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.3.96.1020718121613.8220A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002 stoffel@lucent.com wrote:

> I really prefer 3b, since it's more efficient, faster, and more
> robust.  To snapshot a filesystem, all you need to do is:
> 
>  - create backing store for the snapshot, usually around 10-15% of the
>    size of the original volume.  Depends on volatility of data.
>  - lock the app(s).
>  - lock the filesystem and flush pending transactions.
>  - copy the metadata describing the filesystem
>  - insert a COW handler into the FS block write path
>  - mount the snapshot elsewhere
>  - unlock the FS
>  - unlock the app
> 
> Whenever the app writes a block into the FS, copy the original block
> to the backing store, then write the new block to storage.  

Okay, other than the overhead and having enough filespace for Tbkup sec
(min, hr, day) of operation this is practical. In general most times you
would be doing an incremental, and the time would not be much.

> Bill> In general mauch of this can be addressed by only backing up
> Bill> small f/s and using an application backup utility to backup the
> Bill> big stuff. Fortunately the most common problem apps are
> Bill> databases and and they include this capability.
> 
> Define what a small file system is these days, since it could be 100gb
> for some people.  *grin*.  It's a matter of making the tools scale
> well so that the data can be secured properly.  

Obviously a small f/s is one you can backup without operator intervantion
to change media and in a reasonable time, which might be 10min..few hours
depending on your taste. That's kind of my rule of thumb, you're welcome
to suggest others, but if someone has to change media I can't call it
small any more.

> To do a proper backup requires that all layers talk to each other, and
> have some means of doing a RW lock and flush of pending transactions.
> If you have that, you can do it.  If you don't, you need to either
> goto single user mode, re-mount RO, or pray.

With some people, pray or ignore the problem are popular.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

