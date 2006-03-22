Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbWCVGWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWCVGWV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbWCVGWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:22:21 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:37351 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750813AbWCVGWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:22:20 -0500
To: chrisw@sous-sol.org
CC: trond.myklebust@fys.uio.no, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20060321191605.GB15997@sorel.sous-sol.org> (message from Chris
	Wright on Tue, 21 Mar 2006 11:16:05 -0800)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org> <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu> <20060320153202.GH8980@parisc-linux.org> <1142878975.7991.13.camel@lade.trondhjem.org> <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu> <1142962083.7987.37.camel@lade.trondhjem.org> <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu> <20060321191605.GB15997@sorel.sous-sol.org>
Message-Id: <E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Mar 2006 07:21:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Concrete breakage.  Something like:
> 
> clone(CLONE_FILES)
>   /* in child */
>   lock
>   execve
>   lock
> 
> w/out the kludge[1], the lock fails.  I should have a test program about
> that I wrote to test this, although it was originally triggered via some
> LTP or LSB type of test (don't recall which).
> 
> thanks,
> -chris
> 
> [1] happy to see it go.

We all agree on this then.

I'm just little paranoid about a real-world app (LTP/LSB don't matter)
relying on the current semantics.

But maybe there's no other way to find out, than to remove
steal_locks() and see if anybody complains.

> i concur with Trond, there's no sane way to get rid of it w/out
> formalizing CLONE_FILES and locks on exec

Probably there is.  It would involve allocating a separate
lock-owner-ID stored in files_struct but separate from it.  But it's
more complicated than simply not propagating locks on exec in the
CLONE_FILES case.

Miklos
