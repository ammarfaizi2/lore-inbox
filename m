Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130382AbRAKRj3>; Thu, 11 Jan 2001 12:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131452AbRAKRjT>; Thu, 11 Jan 2001 12:39:19 -0500
Received: from zeus.kernel.org ([209.10.41.242]:62428 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130382AbRAKRjM>;
	Thu, 11 Jan 2001 12:39:12 -0500
Date: Thu, 11 Jan 2001 17:35:12 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010111173512.M25375@redhat.com>
In-Reply-To: <20010111125604.A17177@redhat.com> <200101111650.f0BGoLG473101@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <200101111650.f0BGoLG473101@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Thu, Jan 11, 2001 at 11:50:21AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 11, 2001 at 11:50:21AM -0500, Albert D. Cahalan wrote:
> Stephen C. Tweedie writes:
> >
> > But is it really worth the pain?  I'd hate to have to audit the
> > entire VFS to make sure that it works if another thread changes our
> > credentials in the middle of a syscall, so we either end up having to
> > lock the credentials over every VFS syscall, or take a copy of the
> > credentials and pass it through every VFS internal call that we make.
> 
> 1. each thread has a copy, and doesn't need to lock it

We already have that...

> 2. threads are commanded to change their own copy

We already do that: that's how the current pthreads works.
 
> Credentials could be changed on syscall exit. It is a bit like
> doing signals I think, with less overhead than making userspace
> muck around with signal handlers and synchronization crud.

Yuck.  Far better to send a signal than to pollute the syscall exit
path.  And what about syscalls which block indefinitely?  We _want_
the signal so that they get woken up to do the credentials change.

--Stephen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
