Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSHMOgV>; Tue, 13 Aug 2002 10:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315439AbSHMOgV>; Tue, 13 Aug 2002 10:36:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:30319 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S315431AbSHMOgU>; Tue, 13 Aug 2002 10:36:20 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: klibc and logging
References: <Pine.GSO.4.21.0208130626481.1689-100000@weyl.math.psu.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 13 Aug 2002 08:27:12 -0600
In-Reply-To: <Pine.GSO.4.21.0208130626481.1689-100000@weyl.math.psu.edu>
Message-ID: <m18z3arfzz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro <viro@math.psu.edu> writes:

> On Tue, 13 Aug 2002, Erik Andersen wrote:
> 
> > I would love to see an example of how to do an NFS mount w/o
> > resorting to the C library at all.  Plainly, having generic RPC
> > code in the C library sucks, even if you trim it down.  Having
> > the entire NFS mount process live in application space, and not
> > in the C library, is clearly a win....
> 
> See below - it's crud, but it works.  Based of fs/nfs/nfsroot.c, moved
> to userland with RPC done via syscalls and nothing else.  Arguments are
> passed via environment variables, replacing that with use of argv is
> trivial...   Other than syscalls uses: alarm(3), getenv(3), str... and
> mem..., {s,}printf(3), htonl(3) and htons(3).  About 4Kb of .text + .data
> and aforementioned functions shouldn't add much to that.
> 
> Hardly usable as generic-purpose mount_nfs(8), but for nfsroot...  I'd
> prefer to have timeouts handled properly and code - cleaned up, but
> other than that it should be usable.

It might be worth looking at etherboot (www.etherboot.org).  It isn't
exactly userspace but it also has a minimal nfs client that can mount
an nfs filesystem and read a file, and timeouts are handled.  If
nothing else it should generate some ideas.

Eric
