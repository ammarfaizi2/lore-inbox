Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270197AbRHGWsh>; Tue, 7 Aug 2001 18:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270066AbRHGWsQ>; Tue, 7 Aug 2001 18:48:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:43927 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269994AbRHGWsF>;
	Tue, 7 Aug 2001 18:48:05 -0400
Date: Tue, 7 Aug 2001 18:48:15 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC][PATCH] parser for mount options
In-Reply-To: <20010807235434.B2032@bug.ucw.cz>
Message-ID: <Pine.GSO.4.21.0108071843000.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Pavel Machek wrote:

> fat and isofs have pretty ugly set of options:

Yes.

> nodots and dotsOK=no are same thing (oops, you've bug there). It would
> be nice to have just one name for each function. No need to do
> second-guessing in kernel.

That's nice, but that will be a user-visible change. And I doubt that
people will be happy if mount(8) will barf on their old /etc/fstab
'cause they've been using a variant we decided to drop.

With about anything else I'd say "screw it, fixing config won't kill them",
but people tend to have very strong feelings about filesystems that suddenly
refuse to mount.

IMO the only way to sanitize such stuff is to make the options scheduled
for removal give a warning _and_ suggest the replacement.  And leave them
in such state for at least one stable branch.

> > +	{Opt_nodots, "nodots"},
> > +	{Opt_dots, "dotsOK=no"},
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> here's bug, btw.

Bug it is - thanks for spotting. Fixed.

