Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129220AbQKPSTl>; Thu, 16 Nov 2000 13:19:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbQKPSTa>; Thu, 16 Nov 2000 13:19:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:1448 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129220AbQKPSTL>;
	Thu, 16 Nov 2000 13:19:11 -0500
Date: Thu, 16 Nov 2000 12:49:06 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, linux-kernel@vger.kernel.org,
        Eric Paire <paire@ri.silicomp.fr>
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.LNX.4.10.10011160747260.2184-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0011161238520.13047-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Nov 2000, Linus Torvalds wrote:

> The cwd is not the problem. The '.' is.
> 
> The reason for that check is that allowing "rmdir(".")" confuses a lot of
> UNIX programs, because it wasn't traditionally allowed.

Moreover, allowing it means that you overload the semantics of rmdir()
(and rename(), where it becomes really nasty). And I'm not talking about
the locking issues - the things become extremely nasty there, esp. in
cases like foo/bar/., where bar is a symlink.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
