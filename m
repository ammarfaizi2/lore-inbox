Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUITBZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUITBZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 21:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265487AbUITBZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 21:25:35 -0400
Received: from web11908.mail.yahoo.com ([216.136.172.192]:21262 "HELO
	web11908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265234AbUITBZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 21:25:30 -0400
Message-ID: <20040920012530.83936.qmail@web11908.mail.yahoo.com>
Date: Sun, 19 Sep 2004 18:25:30 -0700 (PDT)
From: Mike Mestnik <cheako911@yahoo.com>
Subject: Re: Design for setting video modes, ownership of sysfs attributes
To: Felix =?ISO-8859-1?Q?=20=22K=FChling=22?= <fxkuehl@gmx.de>,
       Jon Smirl <jonsmirl@gmail.com>
Cc: benh@kernel.crashing.org, keithp@keithp.com,
       dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040919224424.72457afe.felix@trabant>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Felix Kühling <fxkuehl@gmx.de> wrote:

> On Sun, 19 Sep 2004 12:46:13 -0400
> Jon Smirl <jonsmirl@gmail.com> wrote:
> 
> > On Sun, 19 Sep 2004 14:45:37 +1000, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > > One issue here... When we discussed all of this with Keith, we
> wanted
> > > a mecanism where the user can set the mode without "owning" the
> device.
> > 
> > The owning part is for multiuser systems. If I have four users logged
> > into the same system I have to assign them ownership of their video
> > devices so that they can't mess with each other.  I want to avoid
> > needing root priv to change the monitor mode.
> > 
> > > Typically, with X: We don't want X itself to have to be the one
> setting
> > > the mode, but rather set the mode and have X be notified properly
> before
> > > and after it happens so it can "catch up".
> > 
> > This is going to require some more thought. Mode setting needs two
> > things, a description of the mode timings and a location of the scan
> > out buffer.  With multiple heads you can't just assume that the buffer
> > starts at zero.  There also the problem of the buffer increasing in
> > size and needing to be moved since it won't fit where it is.
> > 
> > Keith, how should this work for X? We have to make sure all DRI users
> > of the buffer are halted, get a new location for the buffer, set the
> > mode, free the old buffer, notify all of the DRI clients that their
> > target has been wiped and has a new size.
> 
> Sounds a lot like moving and resizing GL windows in X. A similar (if not
I'd like to point out that this is not smooth on my system, exept for when
using fglrx.  When I move, or resize, a DRI window I get vary
noticable(more then 10th second) stoped system, mouse updates aren't even
recorded.

> the same mechanism) could be used here. Whenever a client takes the lock
> and detects that someone else had the lock in the mean time it checks
> for a new window position and size. Checking for a changed mode or frame
> buffer layout would fit in nicely. AFAIK these kind of changes are
> communicated through the sarea which is shared by all DRI clients, the
> Xserver and the kernel driver, so the checks are pretty low cost (no
> system calls or context switches required).
> 
> You only have to take the lock before changing the mode. DRI clients and
> X will detect the change when they take the lock the next time and
> adjust to the new conditions.
> 
> > 
> > I was wanting to switch mode setting into an atomic operation where
> > you passed in both the mode timings and buffer location.
> > 
> > -- 
> > Jon Smirl
> > jonsmirl@gmail.com
> 
> | Felix Kühling <fxkuehl@gmx.de>                     http://fxk.de.vu |
> | PGP Fingerprint: 6A3C 9566 5B30 DDED 73C3  B152 151C 5CC1 D888 E595 |
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
> Project Admins to receive an Apple iPod Mini FREE for your judgement on
> who ports your project to Linux PPC the best. Sponsored by IBM.
> Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
> 



	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 


		
__________________________________
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
http://promotions.yahoo.com/new_mail 
