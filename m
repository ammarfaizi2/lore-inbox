Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbTJOHXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 03:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbTJOHXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 03:23:48 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:26381 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S262004AbTJOHXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 03:23:46 -0400
Date: Wed, 15 Oct 2003 15:22:31 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: <raven@wombat.indigo.net.au>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Joseph V Moss <jmoss@ichips.intel.com>,
       "Ogden, Aaron A." <aogden@unocal.com>,
       autofs mailing list <autofs@linux.kernel.org>,
       <nfs@lists.sourceforge.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] RE: [autofs] multiple servers per automount
In-Reply-To: <3F8C1BB6.9010202@sun.com>
Message-ID: <Pine.LNX.4.33.0310151515220.21320-100000@wombat.indigo.net.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Oct 2003, Mike Waychison wrote:

> Ian Kent wrote:
>
> >On Tue, 14 Oct 2003, Joseph V Moss wrote:
> >
> >
> >
> >>The limit is 800 as others have stated.  Although, it can be less than that
> >>if something else is already using up some of the reserved UDP ports.
> >>
> >>I wrote a patch long ago against a 2.2.x kernel to enable it to use
> >>multiple majors for NFS mounts (like the patches now common in several
> >>distros).  I then ran into the 800 limit in the RPC layer.  After changing
> >>the RPC layer to count up from 0, instead of down from 800, with no real
> >>upper limit, I was able to mount more than 2000 NFS filesystems simultaneously.
> >>I'm sure I could have done many thousand if I had had that many filesystems
> >>around to mount.  Obviously, after 1024, it wasn't using reserved ports
> >>anymore, but it didn't seem to matter.
> >>
> >>Unfortunately, while the changes to NFS were easy to port to the 2.4 kernel,
> >>the RPC layer is different enough between 2.2 and 2.4 that it didn't work
> >>right off.  Bumping it up to somewhere around 1024 should work, but using
> >>non-reserved ports didn't seem to work when I made a simple attempt.
> >>
> >>Of course, the real fix for the NFS layer is the expansion of the minor
> >>numbers that's already occurred in 2.6 and the RPC layer problems should
> >>be fixed by multiplexing multiple mounts on the same port.
> >>
> >>
> >>
> >>
> >
> >I don't see that expansion in 2.6 (test6). It looks to me like the
> >allocation is done in set_anon_super (in fs/super.c) and that looks like
> >it is restricted to 256. Please correct this for me. I can't see how there
> >is any change to the number of unnmaed devices.
> >
> >
> >
>
> Here is the quick fix for this in RH 2.1AS kernels:
>
> http://www.kernelnewbies.org/kernels/rh21as/SOURCES/linux-2.4.9-moreunnamed.patch
>
> It makes unnamed block devices use majors 12, 14, 38, 39, as well as 0.
>
> I don't know if anyone is working out a better scheme for
> get_unnamed_dev in 2.6 yet.  It does need to be done though.  A simple
> patch for 2.6 would maybe see the unnamed_dev_in_use bitmap grow to
> PAGE_SIZE, automatically allowing for 32768 unnamed devices.
>

OK. Sounds like a good job for me to do (simple - maybe).
I'll spend a while looking for possible side effects.

Do you think that the possible NFS port allocation problems should hold up
this work or should it drive updates to NFS?

Comments from anyone about where to check and what to watch out for are
welcome.

-- 

   ,-._|\    Ian Kent
  /      \   Perth, Western Australia
  *_.--._/   E-mail: raven@themaw.net
        v    Web: http://themaw.net/

