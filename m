Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317550AbSGaB2a>; Tue, 30 Jul 2002 21:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317577AbSGaB2a>; Tue, 30 Jul 2002 21:28:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27698 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S317550AbSGaB2a>; Tue, 30 Jul 2002 21:28:30 -0400
Date: Wed, 31 Jul 2002 03:32:38 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: async-io API registration for 2.5.29
Message-ID: <20020731013238.GJ1181@dualathlon.random>
References: <20020730214116.GN1181@dualathlon.random> <Pine.LNX.4.44L.0207302219400.23404-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0207302219400.23404-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 10:20:51PM -0300, Rik van Riel wrote:
> On Tue, 30 Jul 2002, Andrea Arcangeli wrote:
> > On Tue, Jul 30, 2002 at 08:49:39AM -0400, Benjamin LaHaise wrote:
> > > On Tue, Jul 30, 2002 at 07:41:11AM +0200, Andrea Arcangeli wrote:
> 
> > > What would you suggest as an alternative API?  The main point of multiplexing
> > > is that ios can be submitted in batches, which can't be done if the ios are
> > > submitted via individual syscalls, not to mention the overlap with the posix
> > > aio api.
> >
> > yes, sys_io_sumbit has the advantage you can mix read/write/fsync etc..
> > in the same array of iocb. But by the same argument we could as well
> > have a submit_io instead of sys_read/sys_write/sys_fsync.
> 
> You can't batch synchronous requests, so your "by the same
> argument" doesn't work.
> 
> Asynchronous requests, OTOH, could be submitted in large
> bundles since the app doesn't wait on each request.

disagree, merging synchronous requests would make much more sense than
merging asynchronous requests in the same syscall, it would make them
asynchronous with respect than each other without losing their global
synchronous behaviour w.r.t. userspace.

With async-io it doesn't matter at all to merge too much stuff (except to
avoid entering/exiting kernel that applies to synchronous operations
too).

Andrea
