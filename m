Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270847AbRINUyf>; Fri, 14 Sep 2001 16:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270857AbRINUyZ>; Fri, 14 Sep 2001 16:54:25 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:63181 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270847AbRINUyL>;
	Fri, 14 Sep 2001 16:54:11 -0400
Date: Fri, 14 Sep 2001 16:54:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
In-Reply-To: <Pine.LNX.4.33.0109141341100.1769-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0109141648260.11172-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Sep 2001, Linus Torvalds wrote:

> 
> On Fri, 14 Sep 2001, Alexander Viro wrote:
> >
> > There are only two things to take care of -
> > 	a) if we detach a parent we should do it for all children
> > 	b) we should not mount anything on "floating" vfsmounts.
> > Both are obviously staisfied for current code (presence of children
> > means that vfsmount is busy and we can't mount on something that
> > doesn't exist).
> 
> I disagree about the "we can't mount on something that doesn't exist"
> part.
> 
> If the detached mount is busy, it might be busy exactly because somebody
> has his working directory in it. Which means that
> 
> 	mount /dev/hda ./xxxx
> 
> by such a process could cause a mount within the "nonexisting" mount.

Sure, which is exactly why we need to add checks.  See part 3 - calls of
check_mnt() prevent precisely that kind of situations.

	What I mean is that adding these checks is backwards-compatible -
in absence of lazy umounts they are never triggered.

