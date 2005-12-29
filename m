Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbVL2KR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbVL2KR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 05:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVL2KR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 05:17:56 -0500
Received: from nproxy.gmail.com ([64.233.182.196]:40111 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964903AbVL2KR4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 05:17:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MntBFC6D3rppGwWFa265aCKTyZ9T3Cf8LTKrXNutYAE2JzkMfwIG5z78h8oNFyBz465VFv3AzobnSQgfqpYPiIB7i7stwtxqiQ2S+SufgSQEO7AcNeS5FwCfZBpS9rReKilHrao/TxC40SJ0kOB1w38CmeFGBUnfejYT/IMpJHk=
Message-ID: <2cd57c900512290217k529e0d2bn@mail.gmail.com>
Date: Thu, 29 Dec 2005 18:17:54 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: + drop-pagecache.patch added to -mm tree
Cc: akpm@osdl.org
In-Reply-To: <2cd57c900512290154k12a2265cx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200512020130.jB21UWpS019783@shell0.pdx.osdl.net>
	 <2cd57c900512290154k12a2265cx@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/12/29, Coywolf Qi Hunt <coywolf@gmail.com>:
> 2005/12/2, akpm@osdl.org <akpm@osdl.org>:
> >
> > The patch titled
> >
> >      drop-pagecache
> >
> > has been added to the -mm tree.  Its filename is
> >
> >      drop-pagecache.patch
> >
> >
> > From: Andrew Morton <akpm@osdl.org>
> >
> > Add /proc/sys/vm/drop-pagecache.  When written to, this will cause the kernel
> > to discard as much pagecache and reclaimable slab objects as it can.
> >
> > It won't drop dirty data, so the user should run `sync' first.
> >
> > Caveats:
> >
> > a) Holds inode_lock for exorbitant amounts of time.
> >
> > b) Needs to be taught about NUMA nodes: propagate these all the way through
> >    so the discarding can be controlled on a per-node basis.
> >
> > c) The pagecache shrinking and slab shrinking should probably have separate
> >    controls.
>
> Yes. Let /proc/sys/vm/drop-pagecache for pagecache shrinking only and
> add another /proc/sys/vm/drop-slab for slab shrinking.

Hadn't checked the mm snapshort. ignore the above comment then.

>
> >
> >
> > Signed-off-by: Andrew Morton <akpm@osdl.org>
> > ---
> >
> >  fs/Makefile            |    2 -
> >  fs/drop-pagecache.c    |   62 +++++++++++++++++++++++++++++++++++++++++++++++++
>
> I'd rather have drop-pagecache.c stay in mm/. Fix mm/Makefile and do
> not touch fs/ at all.
>
> -- Coywolf
>
> >  include/linux/mm.h     |    5 +++
> >  include/linux/sysctl.h |    1
> >  kernel/sysctl.c        |    9 +++++++
> >  mm/truncate.c          |    1
> >  mm/vmscan.c            |    3 --
> >  7 files changed, 79 insertions(+), 4 deletions(-)
> >

--
Coywolf Qi Hunt
