Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261633AbSIXJ62>; Tue, 24 Sep 2002 05:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbSIXJ62>; Tue, 24 Sep 2002 05:58:28 -0400
Received: from unthought.net ([212.97.129.24]:2540 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S261633AbSIXJ6Z>;
	Tue, 24 Sep 2002 05:58:25 -0400
Date: Tue, 24 Sep 2002 12:03:38 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, Hans Reiser <reiser@namesys.com>
Subject: Re: ReiserFS buglet
Message-ID: <20020924100338.GH2442@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>
References: <20020924072455.GE2442@unthought.net> <20020924132110.A22362@namesys.com> <20020924092720.GF2442@unthought.net> <20020924134816.A23185@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020924134816.A23185@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2002 at 01:48:16PM +0400, Oleg Drokin wrote:
> Hello!
...
> > Disk errors are common. Software can also flip that bit.
> 
> Not only disk errors are common, but also CPU/memory/chipset/wiring errors are.

It's a question of which errors one wishes to handle, and which you
simply choose to ignore.

It's a compromise, and I understand that.

For example, BK uses checksums on all it's files (AFAIK).  This allows
you to at least discover hardware errors.  CVS doesn't - but CVS is
still "good enough" for a lot of people.

Some hardware problems cannot be detected, much less recovered from,
without adding some significant cost (run-time performance wise,
complexity wise, or ...).

This problem, however, you can both detect and recover from perfectly,
with little extra effort.  Whether you want to do so or not is of course
up to you.

I'm not going to push - I just wanted to point it out  :)

...
> > I posted to LKML about a month ago with some questions regarding exactly
> > this issue.  I had a disk that worked on 128 byte atomic writes - a
> > standard IDE disk.
> 
> Hm. This is still much larger than 20 bytes we use.

Assuming your 20 bytes do not span a 128 byte boundary  ;)

Perhaps you're safe on current LVM/RAID/partition layers (which may
guarantee a coarser alignment - today).

And perhaps there is no disk out there with less than 128 byte atomic
writes.  Maybe.   Do you know?  I certanly don't.

> 
> > The conclusion was something like "we know jack about the disk's
> > internal logic" so we need consistency measures instead of relying on
> > anything from the disk.
> 
> Actually we submit data to disk in 512 byte chunks (4k blocksize case),
> and disk should not write any data before it receives all of it and
> checks the integrity (hm, this is only true for UDMA, though.)
> Still I do not see why any sane disk would start to write a sector before fully
> receiving new sector's content (thinking of disk drives of course, solid state
> stuff should take its own measures in this direction too).

Please read the original mails about the IDE disk writing.

The date is 5th of August this year, the subject was "Disk (block) write
strangeness".

The conclusion really was that there is no such thing as a 512 byte
sector.  Not in the real world.  The disk interface may emulate it, but
that doesn't mean that the disk is internally working with a concept
even remotely close to that.

> This is even more insane than ACKing data and putting it in not battery
> backed cache to be lost on power loss (Yes, I know this is a common
> practice now. At least there is a way either to turn such feature off
> or to flush a cache on demand).

I was pretty surprised about all this myself, and I just wanted to bring
the issue to your attention.

The real world just sucks sometimes  ;)

> 
> Thanks for bringing our attention to such issues, though changing disk format
> is our of questions for reiser3 now, some kind of verifying single instance
> on-disk structures may/will be incorporated in reiser4.

Of course - I look forward to seeing how/if you will deal with the
problem.

Cheers,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
