Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130348AbRAJK5l>; Wed, 10 Jan 2001 05:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131556AbRAJK5b>; Wed, 10 Jan 2001 05:57:31 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:10766 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130348AbRAJK5Z>; Wed, 10 Jan 2001 05:57:25 -0500
Date: Wed, 10 Jan 2001 11:56:32 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@innominate.de>
Cc: "Michael D. Crawford" <crawford@goingware.com>,
        Stephen Rothwell <sfr@linuxcare.com.au>, linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
Message-ID: <20010110115632.E30055@pcep-jamie.cern.ch>
In-Reply-To: <3A5A4958.CE11C79B@goingware.com> <3A5B0D0C.719E69F@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5B0D0C.719E69F@innominate.de>; from phillips@innominate.de on Tue, Jan 09, 2001 at 02:07:24PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> It was done last year, quietly and without fanfare, by Stephen Rothwell:
> 
>   http://www.linuxcare.com/about-us/os-dev/rothwell.epl
> 
> This may be the most significant new feature in 2.4.0, as it allows us
> to take a fundamentally different approach to many different problems. 
> Three that come to mind:
[...]
>    mail (get your mail instantly without polling);

You'll be notified if _any_ mailbox is changed in your mail directory.
On a multiuser system that's going to be more often than a typical
polling interval, so you'll have to revert to polling.

> make (don't rely on timestamps to know when rebuilding is needed, don't
> scan huge directory trees on each build)

You will need to rescan the timestamps of files, but yes you can skip
subdirectories in which no file has changed.  But only if you're running
a "make daemon" on the same box as make, and if there aren't too many
directories.

> locate (reindex only those directories that have changed, keep index
> database current).

Not a chance.  dnotify doesn't work recursively, so you can't monitor
just a few top level directories like "/usr/lib".  And have you ever
tried to keep all 3000 directories on your filesystem directories open
at the same time?  Would you want to consume that much non-swappable
memory, and also prevent the directories from being removed from the
filesystem?

Long ago I proposed something similar that works at the disk level, is
recursive, and the checks can be done without keeping directories open.
But I never wrote the code :(  That's interesting because it speeds up
make without needing a daemon, and really can speed up
locate/updatedb/find.

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
