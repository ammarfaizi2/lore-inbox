Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135588AbREIFW3>; Wed, 9 May 2001 01:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135589AbREIFWU>; Wed, 9 May 2001 01:22:20 -0400
Received: from bitmover.com ([207.181.251.162]:41232 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S135588AbREIFWL>;
	Wed, 9 May 2001 01:22:11 -0400
Date: Tue, 8 May 2001 22:22:10 -0700
From: Larry McVoy <lm@bitmover.com>
To: Marty Leisner <leisner@rochester.rr.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Wow! Is memory ever cheap!
Message-ID: <20010508222210.B14758@work.bitmover.com>
Mail-Followup-To: Marty Leisner <leisner@rochester.rr.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <lm@bitmover.com> <200105090424.AAA05768@soyata.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <200105090424.AAA05768@soyata.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 12:24:25AM -0400, Marty Leisner wrote:
> I'm confused by the "lets not use ECC and use bk" talk.

I'll take a pass at unconfusing you, I can see how you might be.  I wish
I had never mentioned BK, that was never the point.  End to end was the
point, BK was just an example and now I'm getting accused of bringing
up the whole thread as a BK advertisement.  Which completely misses
the point.  Please go read

http://www.google.com/search?q=cache:web.mit.edu/Saltzer/www/publications/endtoend/endtoend.pdf+clark+end+to+end&hl=en

which is a text version of the paper I mentioned before.  The basic
message of the paper is that it really doesn't help much to have things
like ECC unless you can be sure that 100% of the rest of your system
has similar checks.

The point was made again, but apparently missed here, when I pointed
out that Linux's disk subsystem passes up bad data when it knows there
may be a problem.  ECC will not help you in this case, the data was bad
before it hit memory.  So now you have carefully error corrected BAD DATA.
See the point?  ECC doesn't help unless every other component is equally
careful; those components include software and hardware.  You can fix
that chunk of software and then I'll go find a rogue disk controller
that breaks the datapath, there are plenty to choose from.

Just to make sure you understand:  I think ECC is a fine thing.  If I'm
running systems with no other integrity checks, I'll take ECC and like it.
However, having ECC does not mean that I trust that my data is safe,
that is most certainly not a true statement.  The bus, the disks, the
disk controller, the disk driver, the buffer cache, etc, can all corrupt
the data.   Oh, yeah, let's not forget NFS.  I have seen each and every
one of those things corrupt data.

As to the BitKeeper stuff, those of you who think this is a BitKeeper
discussion are off wacking in the weeds.  The point isn't that BitKeeper
is good because it has integrity checks, the point is that integrity
checks are a good thing.  Period.   BitKeeper was just an example.
If there was a Linux filesystem that had built in integrity checks (and
I knew about it, for all I know there is one), then I would have used
that as the example.  I used BitKeeper as an example because I know it
and I can point to numerous cases where it exposed problems that ECC
would not have caught.  Ask Dave Miller about the mmap/read sparc linux
cache aliasing bug that BK exposed, that one was nasty.

Let's review:  ECC is nice, but it doesn't solve all data corruption
problems.  Applications which do their own end to end data integrity
checks will catch many more error cases than what ECC catches.  My efforts
in this thread had nothing to do with BitKeeper, they were trying to
get people to realize that end to end is good, and ECC isn't end to end.

Examples of end to end applications, which I should have thought of
sooner, are the md5sums on ftp.kernel.org, the integrity checks in rpms,
crcs in cpio.  I'm sure you can think of lots of others, this is an
old problem.

> My understanding is suns big machines stopped using ecc and they

The SUN problem was a cache problem and there is no way that I believe
that SUN would turn of ECC in the cache.  There are good reasons for
not doing so.  If you think through the end to end argument, you will
see that you have no way to do checks on the data path into/out of the
processor.  If that part of the datapath is not checked then no amount
of checking elsewhere does any good, the processor can be corrupting
your data and never know it.  If SUN was so stupid as to remove this,
then it is a dramatically different place.  I heard that there was a
bug in the cache controller, I never heard that they had removed ECC.
If you really want to know I can ask, I know at least one of the guys
who works on that stuff there.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
