Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317482AbSFMG7j>; Thu, 13 Jun 2002 02:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317483AbSFMG7i>; Thu, 13 Jun 2002 02:59:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36301 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317482AbSFMG7h>;
	Thu, 13 Jun 2002 02:59:37 -0400
Date: Thu, 13 Jun 2002 02:59:37 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Dawson Engler <engler@csl.Stanford.EDU>
cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <200206130638.XAA08477@csl.Stanford.EDU>
Message-ID: <Pine.GSO.4.21.0206130254360.18281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Dawson Engler wrote:

> > Not realistic - we have a recursion through the ->follow_link(), and
> > a lot of stuff can be called from ->follow_link().  We _do_ have a
> > limit on depth of recursion here, but it won't be fun to deal with.
> 
> You mean following function pointers is not realistic?  Actually the
> function pointers in linxu are pretty easy to deal with since, by
> and large, they are set by static structure initialization and not
> really fussed with afterwards.

I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
->vfs_follow_link->link_path_walk) you will get infinite maximal depth
for everything that can be called by any of these functions.  And that's
a _lot_ of stuff.

