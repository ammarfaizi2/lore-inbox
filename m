Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWBSVaS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWBSVaS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWBSVaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:30:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:44256 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750830AbWBSVaQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:30:16 -0500
Date: Sun, 19 Feb 2006 22:29:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Matthias Hensler <matthias@wspse.de>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060219212952.GI15311@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <200602200709.17955.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602200709.17955.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > swsusp is also available today, and works better than you think. It is
> > slightly slower, but has all the other
> > features you listed in 2.6.16-rc3.
> 
> It is a lot slower because it does all it's I/O synchronously, doesn't 
> compress the image and throws away memory until at least half is
> free.

uswsusp does compress image (20% speedup, in recent CVS) and do
asynchronous I/O.

> > > The only con I see is the complexity of the code, but then again, Nigel
> >
> > ..but thats a big con.
> 
> It's fud. Hopefully as I post more suspend2 patches to LKML, people will see 
> that Suspend2 is simpler than what you are planning.

For what I'm planning, all the neccessary patches are already in -mm
tree. And they are *really* simple. If you can get suspend2 to 1000
lines of code (like Rafael did with uswsusp), we can have something to
talk about.

> > > From a user, and contributor, point of view, I really do not understand
> > > why not even trying to push a working implementation into mainline (I
> > > know that you cannot just apply the Suspend 2 patches and shipping it,
> >
> > It is less work to port suspend2's features into userspace than to make
> > suspend2 acceptable to mainline. Both will mean big changes, and may
> > cause some short-term problems, but it will be less pain than
> > maintaining suspend2 forever. Please help with the former...
> 
> That's not true. I've taken time to look at what would be involved in making 
> suspend2 match the changes you're doing, and I've decided it's just not worth 
> the effort.
> 
> Let's be clear. uswsusp is not really moving suspend-to-disk to userspace. 
> What it is doing is leaving everything but some code for writing the image in 
> kernel space, and implementing ioctls to give a userspace program the ability 
> to request that other processes be frozen, the snapshot prepared and so on. 
> Pages in the snapshot are copied to userspace, possibly compressed or 
> encrypted there in future, then fed back to kernel space so it can use the 
> swap routines to do the writing. Very little of substance is being done in 
> userspace. In short, all it's doing is adding the complexity of

Maybe very little of substance is being done in userspace, but all the
uglyness can stay there. I no longer need LZF in kernel, special
netlink API for progress bar (progress bar naturally lives in
userland), no plugin infrastructure needed, etc.

If you can do suspend2 without putting stuff listed above into kernel,
and in acceptable ammount of code... we can see. But you should really
put suspend2 code into userspace, and be done with that. Feel free to
spam l-k a bit more, but using existing infrastructure in -mm is right
way to go, and it is easier, too.
									Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
