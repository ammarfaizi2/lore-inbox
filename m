Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316089AbSFJUad>; Mon, 10 Jun 2002 16:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSFJUac>; Mon, 10 Jun 2002 16:30:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15118 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316089AbSFJUab>;
	Mon, 10 Jun 2002 16:30:31 -0400
Date: Mon, 10 Jun 2002 21:30:31 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Saurabh Desai <sdesai@austin.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
Message-ID: <20020610213031.G27449@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk> <20020610064120.GH20388@turbolinux.com> <20020610134119.D27449@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 01:41:19PM +0100, Matthew Wilcox wrote:
> On Mon, Jun 10, 2002 at 12:41:20AM -0600, Andreas Dilger wrote:
> > Otherwise, this change makes it impossible to write a multi-threaded
> > program that _does_ allow you use locking between threads.  If anything,
> > this PID check could be conditional on some extra lock flag (e.g.
> > THREADS_SHARE_LOCKS or whatever).
> 
> if you're locking between threads, you should be using posix thread
> mutexes, not file locks, IMO.  There's nothing in SUS v3 which says
> you can do what you've described.

the light dawned... of course it doesn't say.  If you have userlevel
threads (or some M:N system), either you force the threading library
to reimplement the fcntl lock interface, or they have to share locks.
I can't imagine that even the posix threading people require a
reimplementation of the grotesque solaris file locking scheme in
userspace.

-- 
Revolutions do not require corporate support.
