Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317787AbSFMRmi>; Thu, 13 Jun 2002 13:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317788AbSFMRmi>; Thu, 13 Jun 2002 13:42:38 -0400
Received: from dsl-213-023-039-067.arcor-ip.net ([213.23.39.67]:47253 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317787AbSFMRmg>;
	Thu, 13 Jun 2002 13:42:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Alexander Viro <viro@math.psu.edu>,
        Dawson Engler <engler@csl.Stanford.EDU>
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Date: Thu, 13 Jun 2002 19:41:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
In-Reply-To: <Pine.GSO.4.21.0206130254360.18281-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17IYam-0000Qh-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 June 2002 08:59, Alexander Viro wrote:
> On Wed, 12 Jun 2002, Dawson Engler wrote:
> 
> > > Not realistic - we have a recursion through the ->follow_link(), and
> > > a lot of stuff can be called from ->follow_link().  We _do_ have a
> > > limit on depth of recursion here, but it won't be fun to deal with.
> > 
> > You mean following function pointers is not realistic?  Actually the
> > function pointers in linxu are pretty easy to deal with since, by
> > and large, they are set by static structure initialization and not
> > really fussed with afterwards.
> 
> I mean that due to the loop (link_path_walk->do_follow_link->foofs_follow_link
> ->vfs_follow_link->link_path_walk) you will get infinite maximal depth
> for everything that can be called by any of these functions.  And that's
> a _lot_ of stuff.

Then at the point of recursion a dynamic check for stack space is
needed, and [checker]'s role would be to determine the deepest static
depth, to plug into the stack check.  If we want to be sure about 
stack integrity there isn't any way around this.

-- 
Daniel
