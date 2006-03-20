Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWCTMjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWCTMjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 07:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWCTMjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 07:39:54 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:14982 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S932261AbWCTMjx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 07:39:53 -0500
Date: Mon, 20 Mar 2006 05:39:50 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DoS with POSIX file locks?
Message-ID: <20060320123950.GF8980@parisc-linux.org>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 01:19:12PM +0100, Miklos Szeredi wrote:
> > > Unlike open files there doesn't seem to be any limit on the number of
> > > locks being held either globally or by a single process.
> > 
> > RLIMIT_LOCKS
> 
> Which is not actually used anywhere.

Right.  Um.  I took it out back in March 2003 after enough people
convinced me it wasn't worth trying to account for all the memory
processes use, and the userbeans project would take care of it anyway.
Haha.

It's hard to fix the accounting.  You have to deal with one thread
allocating the lock, and then a different thread freeing it.  We never
actually accounted for posix locks (which are the ones we really needed
to!) and on occasion had current->locks go negative, with all kinds of
associated badness.

So you're welcome to try and fix it, but you may well go mad doing so.
Fortunately, I'm no longer maintaining locks.c, but I'd be happy to
answer questions.
