Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289185AbSANKSZ>; Mon, 14 Jan 2002 05:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289184AbSANKSO>; Mon, 14 Jan 2002 05:18:14 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:22030 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S289185AbSANKSD>; Mon, 14 Jan 2002 05:18:03 -0500
Date: Mon, 14 Jan 2002 11:16:44 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: <roman@serv>
To: <yodaiken@fsmlabs.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        Kenneth Johansson <ken@canit.se>, <arjan@fenrus.demon.nl>,
        Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <20020113180559.A18194@hq.fsmlabs.com>
Message-ID: <Pine.LNX.4.33.0201140957490.28512-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

yodaiken@fsmlabs.com wrote:

> I mean, that these conversations are not very useful if you don't
> read what the other people write.

Oh, I do read everything that's for me, but it happens I'm not answering
everything, but thanks for your kind reminder.

> Here's a prior response by Andrew to a post by you.
>
> I've heard this so many times, and it just ain't so.   The overwhelming
> majority of problem areas are inside locks.  All the complexity and
> maintainability difficulties to which you refer exist in the preempt
> patch as well.    There just is no difference.

There is a difference. There is of course the maintenance work which have
both approaches in common, every kernel has to be tested for new latency
problems. What differs is the amount of problems that needs fixing, as
preempt can handle the problems outside of locks automatically, but
inserting schedule points for these cases is usually quite simple. (I
leave it open whether these problem are really only the minority, it
doesn't matter much, it only matters that they do exist.)
The remaining problems need to be examined again by either approach.
Breaking up the locks and inserting (implicit or explicit) schedule points
is often the simpler solution, but analyzing the problem and adjusting the
algorithm leads usually to the cleaner solution. Anyway, this is again
pretty much common for both approaches.
There is an additional cost for maintaining the explicit schedule points,
as they mean additional code all over the kernel, which has to be
maintained and to be verified overtime something is changed in that area.
This work has to be done by someone, if the ll patch would be included
into the standard kernel, the burden would be put onto every maintainer of
the systems that were changed. The easy approach by these maintainers
could be of course to just drop these schedule points, but then the ll
maintainer can start from zero and it adds up to the testing costs above.
This additional cost does not exist for all cases that are automatically
handled by preempting.

bye, Roman

