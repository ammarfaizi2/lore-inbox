Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261703AbSIXQgJ>; Tue, 24 Sep 2002 12:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261704AbSIXQgJ>; Tue, 24 Sep 2002 12:36:09 -0400
Received: from mons.uio.no ([129.240.130.14]:15072 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S261703AbSIXQgJ>;
	Tue, 24 Sep 2002 12:36:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Organization: Dept. of Physics, University of Oslo, Norway
To: Daniel Phillips <phillips@arcor.de>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 24 Sep 2002 18:40:39 +0200
User-Agent: KMail/1.4.1
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       Urban Widmark <urban@teststation.com>, Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3D811A6C.C73FEC37@digeo.com> <shshegg1g5h.fsf@charged.uio.no> <E17thwm-0003fX-00@starship>
In-Reply-To: <E17thwm-0003fX-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209241840.40070.trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 07:09, Daniel Phillips wrote:

> Coalesce before initiating writeout?  I don't see why NFS should be special
> in this regard, or why it should not leave a page locked until IO has
> completed, like other filesystems.  Could you please explain?

It does that for reads.

For writes, however, I see no point in keeping the page lock beyond what is 
required in order to safely copy data from userland. To do so would give 
disastrous performances if somebody was trying to write < page-sized records. 
I belive this is true for all filesystems.
For some reason or another, the buffer stuff needs to re-take the page lock 
when it actually performs the physical commit to disk. NFS doesn't need to do 
this in order to perform an RPC call, so we don't...

Cheers,
  Trond
