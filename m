Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274655AbRITVa3>; Thu, 20 Sep 2001 17:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274659AbRITVaT>; Thu, 20 Sep 2001 17:30:19 -0400
Received: from rj.sgi.com ([204.94.215.100]:13703 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274655AbRITVaK>;
	Thu, 20 Sep 2001 17:30:10 -0400
Message-Id: <200109202131.f8KLVbB19795@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: hch@sgi.com, Steve Lord <lord@sgi.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Gonyou, Austin" <austin@coremetrics.com>,
        narancs@narancs.tii.matav.hu, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: XFS to main kernel source 
In-Reply-To: Message from Christoph Hellwig <hch@ns.caldera.de> 
   of "Thu, 20 Sep 2001 22:26:43 +0200." <20010920222643.A7267@caldera.de> 
Date: Thu, 20 Sep 2001 16:31:37 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Sep 20, 2001 at 03:16:52PM -0500, Steve Lord wrote:

> > Since we have your attention - which chunks? One of the frustrations we hav
> e
> > had is the lack of feedback from anyone who has looked at XFS.
> 
>  o The whole vnode layer

Two answers here - economics and code stability. This is a filesystem
which has been worked on by people being payed to do so by a corporation,
therefore there is a budget (long since blown). It was simpler and hence
cheaper to wrap XFS in a conversion layer than to rework the code down
into the bowels of the filesystem. Then the stability part of it, we
started with a working filesystem, from an engineering standpoint it 
made more sense to keep as much of the existing code base intact as
possible - the less surgery performed the better in terms of keeping
things running, and making it easy to take enhancements and fixes made
in the Irix base into the Linux code (we don't do it the other way around).

>  o checks already peformed by the VFS all over the place
>    (just take a look at xfs_rename.c!)

I think I will answer this one more slowly and in response to Al Viro's
email. But that economics/stability thing comes into it again.

>  o the own quoata code

XFS quotas are transactional, when space is added to a file the quota is
adjusted in the same transaction. It is fairly hard to do this without your
own quota code.

>  o the hooks for a propritary clusterfs..

Well we have to make money on something you know.... and in reality
there are not a lot of them in the filesystem.

Thanks

   Steve


> 
> My 2 (euro-)cents,
> 
> 	Christoph
> 
> -- 
> Of course it doesn't work. We've performed a software upgrade.


