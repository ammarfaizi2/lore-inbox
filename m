Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTJNGtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 02:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbTJNGtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 02:49:36 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:5651 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262197AbTJNGt1
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Tue, 14 Oct 2003 02:49:27 -0400
Date: Mon, 13 Oct 2003 23:49:24 -0700
From: jw schultz <jw@pegasys.ws>
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-ID: <20031014064924.GP15809@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
References: <JIEIIHMANOCFHDAAHBHOMEMEDAAA.alex_a@caltech.edu> <3F8B9324.8020005@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8B9324.8020005@namesys.com>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Vulnerable email reader detected!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 14, 2003 at 10:09:40AM +0400, Hans Reiser wrote:
> Let's see what Andrew says after he reads J.W.'s reasoning.  I agree 
> that reiserfs should do the same thing as the other filesystems in 
> Linux, but J.W. seems to be right that they are doing the wrong thing.

Whoa there.  I am not saying that the other filesystems
are wrong.  All i am saying as i can see no reason why, as
defined, the ctime of a file should be updated when nothing
else in the inode structure as been updated.

Of course if i had designed it in the first place with the
filesystem semantics that we have now there might be no
rename system call.  Renames would be done by link(oldpath,
newpath); unlink(oldpath);  A sequence that would cause
ctime to change as a result of nlink changes.  A sequence
that might be appropriate in some cases even inside the
filesystem code.

If you read my first posting on this thread you will see
that i do see some, albeit questionable, value to the ctime
update as a means of spotting the fact something relating to
the inode has changed.  While not technically required it is
not necessarily wrong to update ctime.  SUSv3 even allows
for it and for some filesystems it would positively be the
right thing to do.

PS.  The name is J.W. or JW and has never been John.

> 
> Hans
> 
> Alex Adriaanse wrote:
> 
> >Hans,
> >
> >Yes, I agree with J.W.  However, I also think that Andrew has a good point
> >in that the behavior across Linux filesystems (ReiserFS, ext2, ext3, minix,
> >etc.) should be consistent.  Either they should all update ctime during
> >renames, or none of them should.
> >
> >Anyway, I'll try to work with the GNU tar maintainer to get this problem in
> >tar fixed.  It'll probably be a lot harder to fix in tar than to have
> >ReiserFS update ctimes since it'll require major changes in
> >the --listed-incremental snapshot files.  However, if you don't think it's 
> >a
> >good idea to make these changes to ReiserFS then we'll just work on fixing
> >up tar.
> >
> >Thanks,
> >
> >Alex
> >
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org
> >[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Hans Reiser
> >Sent: Monday, October 13, 2003 3:46 AM
> >To: Alex Adriaanse
> >Cc: jw schultz; Linux Kernel Mailing List; vs@namesys.com
> >Subject: Re: ReiserFS patch for updating ctimes of renamed files
> >
> >
> >Alex, are you convinced by jw?  (I think I am.)  Would you be willing to
> >submit a patch for tar instead?
> >
> >Hans
> >
> >jw schultz wrote:
> >
> > 
> >
> >>On Mon, Oct 13, 2003 at 09:49:20AM +0400, Hans Reiser wrote:
> >>
> >>
> >>In theory it is cleaner and purer to do it the way we did. In practice,
> >>
> >>   
> >>
> >>>Alex's problem seems like a real one, and I don't know how hard it is to
> >>>change tar to do the right thing.  We'll discuss it in a small seminar
> >>>today.
> >>>
> >>>
> >>>     
> >>>
> >>Updating ctime does seem messy and a bit irrelevant for the
> >>atomic rename.  You are modifying the directories not the
> >>fricken file. This isn't DOS!  But it would seem he does
> >>indeed have an issue although i'm not sure what.  I've never
> >>used the listed-incremental option of tar and since the
> >>manpage is incomplete <rant deleted> i don't know what it
> >>actually does.  However, i have found the use of ctime to be
> >>terribly unreliable for file management and given what the
> >>standards have to say on the issue it sounds like tar is
> >>being abused or has a bug.
> >>
> >>
> >>
> >>
> >>   
> >>
> >
> >
> >--
> >Hans
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> > 
> >
> 
> 
> -- 
> Hans
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
