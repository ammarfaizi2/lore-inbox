Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143663AbRA1TMu>; Sun, 28 Jan 2001 14:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143673AbRA1TMk>; Sun, 28 Jan 2001 14:12:40 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:52493 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S143663AbRA1TM2>; Sun, 28 Jan 2001 14:12:28 -0500
Date: Sun, 28 Jan 2001 14:17:10 -0500
From: Chris Mason <mason@suse.com>
To: Andrew Morton <andrewm@uow.edu.au>, Shawn Starr <Shawn.Starr@Home.net>
cc: Shawn Starr <Shawn.Starr@Home.com>, Gregory Maxwell <greg@linuxpower.cx>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.x and 2.4.1-preX - Higher latency then 2.2.xkernels?
Message-ID: <203550000.980709430@tiny>
In-Reply-To: <3A739205.7C71EF89@uow.edu.au>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, January 28, 2001 02:29:09 PM +1100 Andrew Morton
<andrewm@uow.edu.au> wrote:

> Shawn Starr wrote:
>> 
>> Andrew, the patch HAS made a difference. For example, while untaring
>> glibc-2.2.1.tar.gz the system was not sluggish (mouse movements in X)
>> etc.
>> 
>> Seems to be a go for latency improvements on this system.
> 
> hmm..  OK, thanks.
> 
> Chris, this seems to be a worthwhile improvement to mainstream
> reiserfs, independent of the low-latency thing.   You can
> probably achieve 10 milliseconds with just a few lines of
> code - a subset of the patch which Shawn tested. (Unless you
> were planning on magical algorithmic improvements...).
> 
> I'm all set up to generate those few lines of code, so
> I'll propose a patch later this week.

Perfect, I was thinking exactly the same thing.  We have to be careful here
though, since the extra schedules will increase the chance the searching
has to be redone from scratch, which can have big performance ramifications.

I think your change to search_by_key will be the safest for performance
considerations, along with the change to prepare_for_delete_or_cut.  If
those won't be enough, we can attack reiserfs_get_block (who is probably
the biggest single offender without your patch).

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
