Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265689AbSLFThx>; Fri, 6 Dec 2002 14:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbSLFThx>; Fri, 6 Dec 2002 14:37:53 -0500
Received: from packet.digeo.com ([12.110.80.53]:44991 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265689AbSLFThu>;
	Fri, 6 Dec 2002 14:37:50 -0500
Message-ID: <3DF0FE4F.5F473D5E@digeo.com>
Date: Fri, 06 Dec 2002 11:45:19 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: [patch] fix the ext3 data=journal unmount bug
References: <3DF0F69E.FF0E513A@digeo.com> <1039203287.9244.97.camel@tiny>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 19:45:20.0264 (UTC) FILETIME=[0268D080:01C29D60]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Fri, 2002-12-06 at 14:12, Andrew Morton wrote:
> >
> > It won't.  There isn't really a sane way of doing this properly unless
> > we do something like:
> >
> > 1) Add a new flag to the superblock
> > 2) Set that flag against all r/w superblocks before starting the sync
> > 3) Use that flag inside the superblock walk.
> >
> > That would provide a reasonable solution, but I don't believe we
> > need to go to those lengths in 2.4, do you?
> 
> Grin, I'm partial to changing sync_supers to allow the FS to leave
> s_dirt set in its write_super call.

That doesn't sound like a simplification ;)

> I see what ext3 gains from your current patch in the unmount case, but
> the sync case is really unchanged because of interaction with kupdate.

True.  And I'd like /bin/sync to _really_ be synchronous because
I use `reboot -f' all the time.  Even though SuS-or-POSIX say that
sync() only needs to _start_ the IO.  That's rather silly.
 
> Other filesystems trying to use the sync_fs() call might think adding
> one is enough to always get called on sync, and I think that will lead
> to unreliable sync implementations.

OK.  How about we do it that way in in 2.5 and then look at a backport?
With the steps I propose above, filesystems which don't implement
sync_fs would see no changes, so it should be safe.
