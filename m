Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270825AbRINUnz>; Fri, 14 Sep 2001 16:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270847AbRINUno>; Fri, 14 Sep 2001 16:43:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12549 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270825AbRINUnd>; Fri, 14 Sep 2001 16:43:33 -0400
Date: Fri, 14 Sep 2001 13:43:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lazy umount (1/4)
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0109141341100.1769-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 14 Sep 2001, Alexander Viro wrote:
>
> There are only two things to take care of -
> 	a) if we detach a parent we should do it for all children
> 	b) we should not mount anything on "floating" vfsmounts.
> Both are obviously staisfied for current code (presence of children
> means that vfsmount is busy and we can't mount on something that
> doesn't exist).

I disagree about the "we can't mount on something that doesn't exist"
part.

If the detached mount is busy, it might be busy exactly because somebody
has his working directory in it. Which means that

	mount /dev/hda ./xxxx

by such a process could cause a mount within the "nonexisting" mount.

		Linus

