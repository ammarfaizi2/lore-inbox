Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSFSOpz>; Wed, 19 Jun 2002 10:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317894AbSFSOpy>; Wed, 19 Jun 2002 10:45:54 -0400
Received: from [213.23.20.58] ([213.23.20.58]:46484 "EHLO starship")
	by vger.kernel.org with ESMTP id <S317892AbSFSOpx>;
	Wed, 19 Jun 2002 10:45:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>, <Andries.Brouwer@cwi.nl>
Subject: Re: [PATCH+discussion] symlink recursion
Date: Wed, 19 Jun 2002 16:44:48 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0206181646220.2562-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0206181646220.2562-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17KghU-0000oC-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 June 2002 01:57, Linus Torvalds wrote:
> I see no advantages to handling it by hand, since this isn't even a very
> deep recursion, and since even if you do the recursive part by hand by a
> linked list you still need to limit the depth _anyway_ to avoid DoS
> attacks.

It's the recursive trip through the filesystem that causes the problem.
Suddenly the stack space consumption becomes (N * greediest_filesystem) and
that has to be factored into all worst case calculations.  It's a huge hole
to blow out of this severely restricted resource, so reducing N to 1 is a big
deal.

Also, as a practical matter, it's much easier to lay down a rule for 
filesystem developers that reads: "thou shalt in no case use more than N 
bytes of stack on your longest path" than "in no case use more than N bytes 
of stack except on any symlink resolution path, in which case see the limit 
on recursive symlinks to know how to analyze that path".

-- 
Daniel
