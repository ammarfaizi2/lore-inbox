Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSIXQVL>; Tue, 24 Sep 2002 12:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261702AbSIXQVK>; Tue, 24 Sep 2002 12:21:10 -0400
Received: from dsl-213-023-039-208.arcor-ip.net ([213.23.39.208]:21435 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261698AbSIXQVK>;
	Tue, 24 Sep 2002 12:21:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 24 Sep 2002 07:09:20 +0200
X-Mailer: KMail [version 1.3.2]
Cc: trond.myklebust@fys.uio.no, Andrew Morton <akpm@digeo.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D811A6C.C73FEC37@digeo.com> <E17ta9C-0003bo-00@starship> <shshegg1g5h.fsf@charged.uio.no>
In-Reply-To: <shshegg1g5h.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17thwm-0003fX-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 00:43, Trond Myklebust wrote:
> >>>>> " " == Daniel Phillips <phillips@arcor.de> writes:
> 
>     >> Note that in doing so, we do not want to invalidate any reads
>     >> or writes that may have been already scheduled. The existing
>     >> mapping still would need to hang around long enough to permit
>     >> them to complete.
> 
>      > With the mechanism I described above, that would just work.
>      > The fault path would do lock_page, thus waiting for the IO to
>      > complete.
> 
> NFS writes do not hold the page lock until completion. How would you
> expect to be able to coalesce writes to the same page if they did?

Coalesce before initiating writeout?  I don't see why NFS should be special 
in this regard, or why it should not leave a page locked until IO has 
completed, like other filesystems.  Could you please explain?

-- 
Daniel
