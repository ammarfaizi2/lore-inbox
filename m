Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313911AbSELSPP>; Sun, 12 May 2002 14:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314277AbSELSPO>; Sun, 12 May 2002 14:15:14 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61144 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S313911AbSELSPN>;
	Sun, 12 May 2002 14:15:13 -0400
Date: Sun, 12 May 2002 14:15:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Elladan <elladan@eskimo.com>
cc: Jakob ?stergaard <jakob@unthought.net>,
        Kasper Dupont <kasperd@daimi.au.dk>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] ext2 and ext3 block reservations can be bypassed
In-Reply-To: <20020512103432.A24018@eskimo.com>
Message-ID: <Pine.GSO.4.21.0205121412160.25791-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 May 2002, Elladan wrote:

> His test was different.
> 
> He opened a file in a legal situation (shell can create a new file), and
> then forked off a suid process over and over with the stdout of that
> process set to a dup of the shell's already open fd.
> 
> It's perfectly legal for the shell to sit around with a file open and
> pass it off to a child, even if the disk is full.
> 
> It's also perfectly legal for root to write to the fd, even if the disk
> is full (for normal users).  
> 
> It just happens that the suid program wasn't the one who chose what file
> it was going to write stdout to - the shell did.
> 
> Thus, the security violation.

	<shrug> relying on 5% in security-sensitive setup is *dumb*.
In that case you need properly set quota (better yet, no lusers with write
access anywhere on that fs)..

	There are worse holes problems 5% rule.  E.g. you can create a
file with hole, mmap over that hole, dirty the pages and exit.  Guess
who ends up writing them out?  Right, kswapd.  Which is run as root.
No suid applications required...

