Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132512AbRCZRiD>; Mon, 26 Mar 2001 12:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132513AbRCZRhz>; Mon, 26 Mar 2001 12:37:55 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:26932 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S132511AbRCZRhj>; Mon, 26 Mar 2001 12:37:39 -0500
Message-ID: <3ABF7DCE.6C4F9FAA@sgi.com>
Date: Mon, 26 Mar 2001 09:35:10 -0800
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: linux-fsdevel@vger.kernel.org
Subject: Re: 64-bit block sizes on 32-bit systems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Matthew Wilcox wrote:
> 
> On Mon, Mar 26, 2001 at 08:39:21AM -0800, LA Walsh wrote:
> > I vaguely remember a discussion about this a few months back.
> > If I remember, the reasoning was it would unnecessarily slow
> > down smaller systems that would never have block devices in
> > the 4-28T range attached.
> 
> 4k page size * 2GB = 8TB.
---
        Drat...was being more optimistic -- you're right
the block_nr can be negative.  Somehow thought page size could
be 8K....living in future land.  That just makes the limitations
even closer at hand...:-(

> you keep on trying to increase the size of types without looking at
> what gcc outputs in the way of code that manipulates 64-bit types.
---
        Maybe someone will backport some of the features of the
IA-64 code generator into 'gcc'.  I've been told that in some 
cases it's a 2.5x performance difference.  If 'gcc' is generating
bad code, then maybe the 'gcc' people will increase the quality
of their code -- I'm sure they are just as eagerly working on
gcc improvements as we are kernel improvements.  When I worked
on the PL/M compiler project at Intel, I know our code-optimization
guy would spend endless cycles trying to get better optimization
out of the code.  He got great joy out of doing so. -- and
that was almost 20 years ago -- and code generation has come
a *long* way since then.

> seriously, why don't you just try it?  see what the performance is.
> see what the code size is.  then come back with some numbers.  and i mean
> numbers, not `it doesn't feel any slower'.
---
        As for 'trying' it -- would anyone care if we virtualized
the block_nr into a typedef?  That seems like it would provide
for cleaner (type-checked) code at no performance penalty and
more easily allow such comparisons.

        Well this is my point: if I have disks > 8T, wouldn't
it be at *all* beneficial to be able to *choose* some slight
performance impact and access those large disks vs. having not
choice?  Having it as a configurable would allow a given 
installation to make that choice rather than them having no
choice.  BTW, are block_nr's on RAID arrays subject to this
limitation?
> 
> personally, i'm going to see what the situation looks like in 5 years time
> and try to solve the problem then.
---
        It's not the same, but SGI has had customers for over
3 years using >2T *files*.  The point I'm looking at is if
the P-X series gets developed enough, and someone is using a
4-16P system, a corp user might be approaching that limit
today or tomorrow.  Joe User, might not for 5 years, but that's
what the configurability is about.  Keep linux usable for both
ends of the scale -- "I love scalability"....

-l

-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-- 
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
