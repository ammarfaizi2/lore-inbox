Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261435AbVCKTNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261435AbVCKTNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbVCKTMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:12:16 -0500
Received: from waste.org ([216.27.176.166]:34973 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261344AbVCKTI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:08:59 -0500
Date: Fri, 11 Mar 2005 11:08:25 -0800
From: Matt Mackall <mpm@selenic.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       torvalds@osdl.org, akpm@osdl.org
Subject: Re: Linux 2.6.11.2
Message-ID: <20050311190825.GW3120@waste.org>
References: <20050309235716.GZ3163@waste.org> <4231E75A.4090203@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4231E75A.4090203@tmr.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 01:45:46PM -0500, Bill Davidsen wrote:
> Matt Mackall wrote:
> >On Wed, Mar 09, 2005 at 12:11:02PM +0100, Pavel Machek wrote:
> >
> >>On St 09-03-05 09:52:46, Marcos D. Marado Torres wrote:
> >>
> >>>-----BEGIN PGP SIGNED MESSAGE-----
> >>>Hash: SHA1
> >>>
> >>>On Wed, 9 Mar 2005, Greg KH wrote:
> >>>
> >>>
> >>>>which is a patch against the 2.6.11.1 release.  If consensus arrives
> >>>>that this patch should be against the 2.6.11 tree, it will be done that
> >>>>way in the future.
> >>>
> >>>IMHO it sould be against 2.6.11 and not 2.6.11.1, like -rc's that are'nt 
> >>>againt
> >>>the last -rc but against 2.6.x.
> >>
> >>You expect people to go through all 2.6.11.1, 2.6.11.2, ... . That
> >>means .11.2 should be relative to .11.1, because otherwise people will
> >>have to revert (ugly). And you want people to track -stable kernels as
> >>fast as possible.
> >
> >
> >There are three ways we can do this:
> >
> >a) all 2.6.x.y are diffs against 2.6.x
> >b) interdiffs for .1, .2, etc. with 2.6.x+1 diffed against 2.6.x
> >c) interdiffs and 2.6.12 is a diff against 2.6.11.last
> >
> >Imagine we want to go from 2.6.11.3 to 2.6.12
> >
> >case a)
> >revert patch 2.6.11.3
> >get and apply 2.6.12
> 
> Would anyone actually do that? About the time of the first patch usually 
> do something like:
>   cd linux-2.6.11
>   cp -rl . ../linux-2.6.11.1
>   cd $_
>   bzcat ../Patches/patch-2.6.11.1.bz2 | patch -p1
>   make oldconfig

In your world, do you want to do:

cp -rl linux-2.6.11 linux-2.6.11.5
cd linux-2.6.11.5
bzcat ../Patches/patch-2.6.11.1.bz2 | patch -p1
bzcat ../Patches/patch-2.6.11.2.bz2 | patch -p1
bzcat ../Patches/patch-2.6.11.3.bz2 | patch -p1
bzcat ../Patches/patch-2.6.11.4.bz2 | patch -p1
bzcat ../Patches/patch-2.6.11.5.bz2 | patch -p1

I suspect you might find that tedious, especially if only the last one
addressed a bug that affected you.

Or do you want to do it the same way you do for every other branch? I
don't want to special-case it in my code and I don't think users want
to special-case it in their brains. Have separate interdiffs on the
side, please, and then people can choose, but do it the standard way.

Dear ${SUCKER}s, can we have a decision on this? My ketchup tool is
broken for 2.6.11.2 and I don't want to cut a new release until a firm
decision is made. Obviously I have a strong preference for all 2.6.x.y
diffs being against 2.6.x, it means that .y can be treated the same as
-rc, -bk, -mm, ... (and I already coded it that way when 2.6.8.1 came
out).

-- 
Mathematics is the supreme nostalgia of our time.
