Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbRAESkK>; Fri, 5 Jan 2001 13:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131017AbRAESkA>; Fri, 5 Jan 2001 13:40:00 -0500
Received: from sparrow.ists.dartmouth.edu ([129.170.249.49]:30848 "EHLO
	sparrow.websense.net") by vger.kernel.org with ESMTP
	id <S129773AbRAESjx>; Fri, 5 Jan 2001 13:39:53 -0500
Date: Fri, 5 Jan 2001 13:38:39 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
Reply-To: William Stearns <wstearns@pobox.com>
To: Jens Axboe <axboe@suse.de>, Joel Koerwer <joel@ideacode.com>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>,
        "Ts'o, Theodore -- Theodore Ts'o" <tytso@mit.edu>, <tytso@valinux.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Loopback filesystem still hangs on 2.4.0-test13-pre7
In-Reply-To: <20010104022119.B2408@suse.de>
Message-ID: <Pine.LNX.4.30.0101041838230.884-100000@sparrow.websense.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, all,

On Thu, 4 Jan 2001, Jens Axboe wrote:

> On Wed, Jan 03 2001, William Stearns wrote:
> > 	This is just meant as an informational message, not a complaint.
> > Ted, could you note that this still exists on 2.4.0-test13-pre7 in the
> > todo page?  Many thanks.
> >
> > [1.] One line summary of the problem:
> > 	Loopback filesystem writes still hang on 2.4.0-test13-pre7.
>
> Could you try with this patch:
>
> *.kernel.org/pub/linux/kernel/people/axboe/patches/2.4-prerelease/loop-remap-2
>
> it survives 10 runs of your script and dbench abuse etc. If there are still
> problems, I'd like to know... Should be faster too :-)

	I applied your Jan 4th version of this patch to 2.4.0-prerelease
proper (Linus' Jan 4th diff had changes to fs/buffer.c that conflicted).
I didn't apply either of the other patches in that directory.
	When I booted it, I got:

...
devfs: devfs_register(): device already registered: "252"
devfs: devfs_register(): device already registered: "253"
devfs: devfs_register(): device already registered: "254"
loop: loaded (max 255 devices)

	, but I suspect this is cosmetic.
	The verdict?  This patch is marvelous!  I _cannot_ crash it, even
under heavy load.  My test script went through 256 passes without even a
glitch - previous kernels would have left one or more tasks in the "D"
state by pass 16 or earlier without fail.  Lots of bash's filling up
memory and mostly filling swap, no problem (in fact, I had to kill off a
few when I ran out of file descriptors at 1500 processes).  Running X and
some X apps (including xmms, which always seemed to spell death to old
kernels) was also no problem.
	In short, _I_ _can't_ _get_ _it_ _to_ _fail_!  I'm tremendously
happy with the patch.
	I also agree with the speed assessment - 70M of linux source code
copies (granted, between caches) in only a few seconds once the cache is
loaded.

	I realize that my 24 hours of testing hardly counts as validation
of the patch - could others beat on it as well (Joel?)?  Jens, any chance
you could update it for 2.4.0-final?
	My solitary vote is for moving this to "Fix exists but isn't
merged" on Ted's list.
	Once again, my sincere thanks to both Jens and Jeff for their work
on the loop filesystem.  I'll keep beating on it.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Scattered showers my ass!"
	-- Noah
(Courtesy of "Michael B. Trausch" <mtrausch@wcnet.org>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, named2hosts,
and ipfwadm2ipchains are at:                http://www.pobox.com/~wstearns
LinuxMonth; articles for Linux Enthusiasts! http://www.linuxmonth.com
--------------------------------------------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
