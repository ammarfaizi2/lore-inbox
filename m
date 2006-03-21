Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965009AbWCUSRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWCUSRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 13:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWCUSRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 13:17:05 -0500
Received: from pat.uio.no ([129.240.130.16]:51117 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932418AbWCUSRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 13:17:03 -0500
Subject: Re: DoS with POSIX file locks?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: chrisw@osdl.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
	 <1142878975.7991.13.camel@lade.trondhjem.org>
	 <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu>
	 <1142962083.7987.37.camel@lade.trondhjem.org>
	 <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 13:16:41 -0500
Message-Id: <1142965001.7987.70.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.653, required 12,
	autolearn=disabled, AWL 1.35, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 18:58 +0100, Miklos Szeredi wrote:
> > > Apps using LinuxThreads seem to be candidates:
> > > 
> > >      According to POSIX 1003.1c, a successful `exec*' in one of the
> > >      threads should automatically terminate all other threads in the
> > >      program.  This behavior is not yet implemented in LinuxThreads.
> > >      Calling `pthread_kill_other_threads_np' before `exec*' achieves
> > >      much of the same behavior, except that if `exec*' ultimately
> > >      fails, then all other threads are already killed.
> > > 
> > > steal_locks() was probably added as a workaround for this case, no?
> > 
> > Possibly, but LinuxThreads were never really POSIX thread compliant
> > anyway. Anyhow, the problem isn't really LinuxThreads, it is rather that
> > the existence of the standalone CLONE_FILES flag allows you to do a lot
> > of weird inheritance crap with 'posix locks' that the POSIX standards
> > committees never even had to consider.
> 
> Yes.  The execve-with-multiple-threads/posix-locks interaction is not
> documented for LinuxThreads but removing steal_locks() makes that
> implementation slighly differently incompatible to POSIX.  Some
> application _might_ be relying on the current behavior.

That really doesn't matter: the current behaviour isn't ever going to
work for some of the most commonly used Linux filesystems out there.
IOW: Such an application isn't even going to be portable from one Linux
installation to another.

Cheers,
  Trond

