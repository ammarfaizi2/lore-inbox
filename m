Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263591AbTLOMsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 07:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTLOMsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 07:48:33 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:61631 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263591AbTLOMsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 07:48:31 -0500
Date: Mon, 15 Dec 2003 13:47:52 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Rob Landley <rob@landley.net>
Cc: Hua Zhong <hzhong@cisco.com>, "'Andy Isaacson'" <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Is there a "make hole" (truncate in middle) syscall?
Message-ID: <20031215124752.GA27005@wohnheim.fh-wedel.de>
References: <20031211125806.B2422@hexapodia.org> <20031212135609.GE6112@wohnheim.fh-wedel.de> <20031212142459.GG6112@wohnheim.fh-wedel.de> <200312121537.42303.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200312121537.42303.rob@landley.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 December 2003 15:37:42 -0600, Rob Landley wrote:
> On Friday 12 December 2003 08:24, Jörn Engel wrote:
> 
> > > ...and it sucks.  Same problem as with updatedb - 99% of all work is
> > > bogus, but you don't know which 99%, because the one knowing about it,
> > > the kernel, doesn't tell you a thing.
> >
> > Actually, updatedb sucks even worse.  The database is notoriously
> > outdated and each run of updatedb has the effect of flushing the
> > cache.  Because of the cache-flushing effect, you cannot even run it
> > with maximum niceness.  Running it still hurts you *afterwards*.
> >
> > Same goes for you userland daemon without kernel support.
> 
> 1) The date optimization, only looking at files newer than the last run, means
> you can avoid looking at 90% of the filesystem.

And how do you figure out the date?  ;)

> 2) If drop-behind ever gets working, life is good for this sort of thing.  If 
> not, there's always O_DIRECT or its replacement (whatever Linus and the 
> oracle guy were arguing about last month)...

Not sure what drop-behind is.  Sounds interesting.

Anyway, what updatedb, userspace defragmenters etc. need is a
notification, what has changed.  Without this notification, they have
to look at everything and figure it out themselves.  Ask the network
people why select doesn't scale too well - updatedb is even worse
because it doesn't even notice that *anything* has changed, much less
what change happened.

O_DIRECT, O_STREAMING or O_WHATEVER is also a different beast.  With
streaming media, there is no way to avoid touching the data in the
first place.  If there was, we could do even better, but there isn't.

For updatedb there is.

Jörn

-- 
When in doubt, punt.  When somebody actually complains, go back and fix it...
The 90% solution is a good thing.
-- Rob Landley
