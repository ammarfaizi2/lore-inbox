Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317643AbSGJWUb>; Wed, 10 Jul 2002 18:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317648AbSGJWUa>; Wed, 10 Jul 2002 18:20:30 -0400
Received: from dsl-213-023-043-112.arcor-ip.net ([213.23.43.112]:9960 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317643AbSGJWU3>;
	Wed, 10 Jul 2002 18:20:29 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rick Lindsley <ricklind@us.ibm.com>, Larry McVoy <lm@bitmover.com>
Subject: Re: BKL removal
Date: Thu, 11 Jul 2002 00:24:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Greg KH <greg@kroah.com>, Dave Hansen <haveblue@us.ibm.com>,
       Thunder from the hill <thunder@ngforever.de>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com>
In-Reply-To: <200207102128.g6ALS2416185@eng4.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SPsV-00028p-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 July 2002 23:28, Rick Lindsley wrote:
> So threading is difficult to manage or even impossible without a global
> lock for everyone to use? True -- I suppose that would force people to
> think about what they are locking and which lock is appropriate to avoid
> unnecessary contention.  It would require that the new locks' scopes and
> assumptions be documented instead of handed down verbally from 
> teacher to student.

Hear hear!  Well, Al at least has made a pretty good attempt to do that
for VFS locks.  The rest of the kernel is pretty much a disaster.  If
we're lucky, we find the odd comment here and there: 'must be called
holding such-and-such lock', and on a good day the comment is even
correct.  Which reminds me of a janitorial idea I discussed briefly with
Acme, which is to replace all those above-the-function lock coverage
comments with assert-like thingies:

   spin_assert(&pagemap_lru_lock);

And everbody knows what that does: when compiled with no spinlock
debugging it does nothing, but with spinlock debugging enabled, it oopses
unless pagemap_lru_lock is held at that point in the code.  The practical
effect of this is that lots of 3 line comments get replaced with a
one line assert that actually does something useful.  That is, besides
documenting the lock coverage, this thing will actually check to see if
you're telling the truth, if you ask it to.

Oh, and they will stay up to date much better than the comments do,
because nobody needs to to be an ueber-hacker to turn on the option and
post any resulting oopses to lkml.

> It would have the side effect of making it easier
> for a newcomer to come up to speed on a particular section of code, thus
> allowing a greater number of people to understand the code and offer fixes
> or enhancements.

Yup, and double-yup.

-- 
Daniel
