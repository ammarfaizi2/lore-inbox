Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135971AbRD0NFf>; Fri, 27 Apr 2001 09:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135993AbRD0NFY>; Fri, 27 Apr 2001 09:05:24 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:63874 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S135971AbRD0NFJ>;
	Fri, 27 Apr 2001 09:05:09 -0400
Date: Fri, 27 Apr 2001 09:58:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427095840.A701@suse.cz>
In-Reply-To: <Pine.GSO.4.21.0104261554050.15385-100000@weyl.math.psu.edu> <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104261303030.1118-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 26, 2001 at 01:08:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 01:08:25PM -0700, Linus Torvalds wrote:

> On Thu, 26 Apr 2001, Alexander Viro wrote:
> > On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> > >
> > > how can the read in progress see a branch that we didn't spliced yet? We
> >
> > fd = open("/dev/hda1", O_RDONLY);
> > read(fd, buf, sizeof(buf));
> 
> Note that I think all these arguments are fairly bogus.  Doing things like
> "dump" on a live filesystem is stupid and dangerous (in my opinion it is
> stupid and dangerous to use "dump" at _all_, but that's a whole 'nother
> discussion in itself), and there really are no valid uses for opening a
> block device that is already mounted. More importantly, I don't think
> anybody actually does.

Actually this is done quite often, even on mounted fs's:

hdparm -t /dev/hda

> The fact that you _can_ do so makes the patch valid, and I do agree with
> Al on the "least surprise" issue. I've already applied the patch, in fact.
> But the fact is that nobody should ever do the thing that could cause
> problems.

-- 
Vojtech Pavlik
SuSE Labs
