Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbWCUJpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbWCUJpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWCUJpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:45:06 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:45030 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S932370AbWCUJpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:45:05 -0500
To: trond.myklebust@fys.uio.no
CC: matthew@wil.cx, miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1142878975.7991.13.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Mon, 20 Mar 2006 13:22:55 -0500)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org> <1142878975.7991.13.camel@lade.trondhjem.org>
Message-Id: <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 21 Mar 2006 10:44:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The _only_ sane way to solve it is to decree that you lose your locks if
> you clone(CLONE_FILES) and then call exec(). If there are any
> applications out there that rely on the current behaviour,

Apps using LinuxThreads seem to be candidates:

     According to POSIX 1003.1c, a successful `exec*' in one of the
     threads should automatically terminate all other threads in the
     program.  This behavior is not yet implemented in LinuxThreads.
     Calling `pthread_kill_other_threads_np' before `exec*' achieves
     much of the same behavior, except that if `exec*' ultimately
     fails, then all other threads are already killed.

steal_locks() was probably added as a workaround for this case, no?

I wonder how many installations still run LinuxThreads with 2.6 kernels.

Miklos
