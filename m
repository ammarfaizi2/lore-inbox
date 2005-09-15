Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVIOJax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVIOJax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 05:30:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVIOJax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 05:30:53 -0400
Received: from koto.vergenet.net ([210.128.90.7]:19889 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S932371AbVIOJaw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 05:30:52 -0400
Date: Thu, 15 Sep 2005 18:22:46 +0900
From: Horms <horms@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marc Horowitz <marc@mit.edu>, 328135@bugs.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process stuck in disk wait
Message-ID: <20050915092246.GE25382@verge.net.au>
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net> <20050914025150.GR27828@verge.net.au> <1126742335.8807.74.camel@lade.trondhjem.org> <t533bo75e6t.fsf@central-air-conditioning.toybox.cambridge.ma.us> <1126773168.12556.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126773168.12556.13.camel@lade.trondhjem.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 09:32:47AM +0100, Trond Myklebust wrote:
> on den 14.09.2005 Klokka 21:10 (-0400) skreiv Marc Horowitz:
> > Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> > 
> > >> on den 14.09.2005 Klokka 11:51 (+0900) skreiv Horms:
> > >> > Hi Marc,
> > >> > 
> > >> > would is be possible to test linux-image-2.6.12-1-686-smp from 
> > >> > unstable to see if this problem persists? I am CCing the NFS
> > >> > maintainer and LKML as this looks reasonably nasty and they
> > >> > may be interested in looking into it.
> > >> > 
> > >> 
> > >> I doubt this has anything to do with NFS. We should no longer have a
> > >> sync_page VFS method in the 2.6 kernels. What other filesystems is the
> > >> user running?
> > 
> > In the stack trace I sent, from a running 2.6.11 kernel, vfs_read
> > appears to be the vfs method, not sync_page.  sync_page is called much
> > deeper in the stack trace.
> 
> So? It is clearly the call to sync_page that is Oopsing.
> 
> The NFS call is just trying to lock a page that appears to be owned by
> someone else. That triggers a call to that filesystem's sync_page, which
> then goes on to do a page allocation, which again Oopses.

I take it from your initial remarks that the use of sync_page()
in the VSF has changed recently. And in any case, it would
be worth testing 2.6.12 or 2.6.13 before investigating any further
as in your oppinion the problem is not NFS related, but related
to somthing that NFS coincidently triggers (but could just as
easily triggered by anything else).

-- 
Horms
