Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315338AbSELSiO>; Sun, 12 May 2002 14:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSELSiN>; Sun, 12 May 2002 14:38:13 -0400
Received: from mail.eskimo.com ([204.122.16.4]:21008 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S315338AbSELSiM>;
	Sun, 12 May 2002 14:38:12 -0400
Date: Sun, 12 May 2002 11:37:30 -0700
To: Alexander Viro <viro@math.psu.edu>
Cc: Elladan <elladan@eskimo.com>, Jakob ?stergaard <jakob@unthought.net>,
        Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
Message-ID: <20020512113730.A24085@eskimo.com>
In-Reply-To: <20020512103432.A24018@eskimo.com> <Pine.GSO.4.21.0205121412160.25791-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2002 at 02:15:12PM -0400, Alexander Viro wrote:
> 
> On Sun, 12 May 2002, Elladan wrote:
> > 
> > It just happens that the suid program wasn't the one who chose what file
> > it was going to write stdout to - the shell did.
> > 
> > Thus, the security violation.
> 
> 	<shrug> relying on 5% in security-sensitive setup is *dumb*.
> In that case you need properly set quota (better yet, no lusers with write
> access anywhere on that fs)..
> 
> 	There are worse holes problems 5% rule.  E.g. you can create a
> file with hole, mmap over that hole, dirty the pages and exit.  Guess
> who ends up writing them out?  Right, kswapd.  Which is run as root.
> No suid applications required...

Regardless of whether it's a good thing to depend on security-wise, it
is a problem to have something that appears to be a security feature
which doesn't actually work.

Reading the documentation, I would expect that if I create an ext3
filesystem, reserve 20% of it for root, and then run a cron job as root
that uses 16% of that filesystem periodically, that cron job will not
actually fail whenever some luser decides they want it to.

I don't recall seeing it plastered in huge letters, "This space reserve
is just a convenience feature, and can easily be circumvented by the
user.  You must never rely on it for anything."

Having unsupported security features is typically a bad idea.

-J
