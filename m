Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbRAKTv6>; Thu, 11 Jan 2001 14:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130192AbRAKTvs>; Thu, 11 Jan 2001 14:51:48 -0500
Received: from zeus.kernel.org ([209.10.41.242]:58579 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130112AbRAKTvh>;
	Thu, 11 Jan 2001 14:51:37 -0500
Date: Thu, 11 Jan 2001 19:47:53 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
        Daniel Phillips <phillips@innominate.de>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010111194753.P25375@redhat.com>
In-Reply-To: <20010111141330.H25375@redhat.com> <Pine.GSO.4.21.0101111401430.17363-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0101111401430.17363-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Jan 11, 2001 at 02:03:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 11, 2001 at 02:03:48PM -0500, Alexander Viro wrote:
> On Thu, 11 Jan 2001, Stephen C. Tweedie wrote:
> 
> > On Thu, Jan 11, 2001 at 02:12:05PM +0100, Trond Myklebust wrote:
> > > 
> > >  What's wrong with copy-on-write style semantics? IOW, anyone who
> > > wants to change the credentials needs to make a private copy of the
> > > existing structure first.
> > 
> > Because COW only solves the problem if each task is only changing its
> > own, local, private copy of the credentials.  Posix threads demand
> > that one thread changing credentials also affects all the other
> > threads immediately, and making your own local private copy won't help
> > you to change the other tasks' credentials safely.
> 
> And how is that different from the current situation?

It's not, which is the point I was making: COW doesn't actually solve
the pthreads problem.  Far better to do it in user space.

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
