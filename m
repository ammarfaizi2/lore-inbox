Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVIOIdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVIOIdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 04:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVIOIdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 04:33:11 -0400
Received: from pat.uio.no ([129.240.130.16]:7555 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932194AbVIOIdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 04:33:10 -0400
Subject: Re: Bug#328135: kernel-image-2.6.11-1-686-smp: nfs reading process
	stuck in disk wait
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marc Horowitz <marc@mit.edu>
Cc: Horms <horms@debian.org>, 328135@bugs.debian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <t533bo75e6t.fsf@central-air-conditioning.toybox.cambridge.ma.us>
References: <20050913194707.8C8C28E6F0@ayer.connecterra.net>
	 <20050914025150.GR27828@verge.net.au>
	 <1126742335.8807.74.camel@lade.trondhjem.org>
	 <t533bo75e6t.fsf@central-air-conditioning.toybox.cambridge.ma.us>
Content-Type: text/plain
Date: Thu, 15 Sep 2005 09:32:47 +0100
Message-Id: <1126773168.12556.13.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.345, required 12,
	autolearn=disabled, RCVD_IN_NJABL_DUL 1.66,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on den 14.09.2005 Klokka 21:10 (-0400) skreiv Marc Horowitz:
> Trond Myklebust <trond.myklebust@fys.uio.no> writes:
> 
> >> on den 14.09.2005 Klokka 11:51 (+0900) skreiv Horms:
> >> > Hi Marc,
> >> > 
> >> > would is be possible to test linux-image-2.6.12-1-686-smp from 
> >> > unstable to see if this problem persists? I am CCing the NFS
> >> > maintainer and LKML as this looks reasonably nasty and they
> >> > may be interested in looking into it.
> >> > 
> >> 
> >> I doubt this has anything to do with NFS. We should no longer have a
> >> sync_page VFS method in the 2.6 kernels. What other filesystems is the
> >> user running?
> 
> In the stack trace I sent, from a running 2.6.11 kernel, vfs_read
> appears to be the vfs method, not sync_page.  sync_page is called much
> deeper in the stack trace.

So? It is clearly the call to sync_page that is Oopsing.

The NFS call is just trying to lock a page that appears to be owned by
someone else. That triggers a call to that filesystem's sync_page, which
then goes on to do a page allocation, which again Oopses.

Cheers,
  Trond

