Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSFJMnj>; Mon, 10 Jun 2002 08:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSFJMnP>; Mon, 10 Jun 2002 08:43:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314096AbSFJMlS>;
	Mon, 10 Jun 2002 08:41:18 -0400
Date: Mon, 10 Jun 2002 13:41:19 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Saurabh Desai <sdesai@austin.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
Message-ID: <20020610134119.D27449@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk> <20020610064120.GH20388@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 12:41:20AM -0600, Andreas Dilger wrote:
> I would pass this by the Samba folks first.  I seem to recall them
> complaining about this area.  The "one thread closing a file removes
> locks from another thread" is one area that I'm sure they don't like.

I know they don't; they've complained about it in the past.  However, this
_is_ mandated by POSIX so we can't really fix that (Turns out everyone
thinks POSIX locks are broken in a different way, so my definition of
sane locking semantics is very different from yours).

> Making it so that multiple threads ignore file locks is probably
> not going to make them happy either.  I believe one of the issues is
> that Samba is running server threads for many remote processes, and
> it needs to be able to enforce these locks.

Looking at samba-2.2.4/source/locking/posix.c, it seems to me that samba
trusts the OS file locking so little that this change will have no effect.

> Otherwise, this change makes it impossible to write a multi-threaded
> program that _does_ allow you use locking between threads.  If anything,
> this PID check could be conditional on some extra lock flag (e.g.
> THREADS_SHARE_LOCKS or whatever).

if you're locking between threads, you should be using posix thread
mutexes, not file locks, IMO.  There's nothing in SUS v3 which says
you can do what you've described.

-- 
Revolutions do not require corporate support.
