Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSDURjZ>; Sun, 21 Apr 2002 13:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313653AbSDURjY>; Sun, 21 Apr 2002 13:39:24 -0400
Received: from bitmover.com ([192.132.92.2]:14235 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313638AbSDURjY>;
	Sun, 21 Apr 2002 13:39:24 -0400
Date: Sun, 21 Apr 2002 10:39:23 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
        Wayne Scott <wscott@bitmover.com>
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020421103923.I10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>,
	Alexander Viro <viro@math.psu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org,
	Wayne Scott <wscott@work.bitmover.com>
In-Reply-To: <20020421044616.5beae559.spyro@armlinux.org> <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu> <20020421131354.C4479@havoc.gtf.org> <20020421102339.E10525@work.bitmover.com> <20020421133225.F4479@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 01:32:25PM -0400, Jeff Garzik wrote:
> On Sun, Apr 21, 2002 at 10:23:39AM -0700, Larry McVoy wrote:
> > > IOW, I propose to create a "linuspush" script that replaces his current
> > > "bk push" command.  Linus pushes batches of csets out at a time,
> > > make these cset batches the pre-patches...
> > 
> > This is easily doable as a trigger.  I'm pretty sure that all you want
> > is
> 
> Not quite -- pre-patches are a one-big-patch, diffed against the most
> recently released kernel.  

That's easier yet.

	bk diffs -Cv2.5.8

> One quality of all traditional Linus pre-patches and patches is that
> if you have N csets modifying a single file, you see N gnu-style diff
> modifications, instead of the single one you would get when generating
> the patch via GNU diff.

Did you get that backwards?  Do you want to see N diffs on a single
file or do you want one?  We can do either, diffs -C does one.

Also, we're planning on making a "push stack", which remembers the set of
csets pushed each time, so you can do

	bk undo	# remove the last push effects
	bk undo	# remove the last push effects
	..
	bk undo	# remove the clone effects and destroy the repository

You could use that to generate these patches you want.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
