Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317376AbSFMAUu>; Wed, 12 Jun 2002 20:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317380AbSFMAUt>; Wed, 12 Jun 2002 20:20:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57483 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317376AbSFMAUs>;
	Wed, 12 Jun 2002 20:20:48 -0400
Date: Wed, 12 Jun 2002 20:20:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org,
        mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <20020612183854.B4081@redhat.com>
Message-ID: <Pine.GSO.4.21.0206122016140.16357-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Benjamin LaHaise wrote:

> On Wed, Jun 12, 2002 at 06:26:55PM -0400, Alexander Viro wrote:
> > Not realistic - we have a recursion through the ->follow_link(), and
> > a lot of stuff can be called from ->follow_link().  We _do_ have a
> > limit on depth of recursion here, but it won't be fun to deal with.
> 
> Perfection isn't what I'm looking for, rather just an approximation.  
> Any tool would have to give up on non-trivial recursion, or have 

... in which case it will be useless - anything callable from path_walk()
will be out of its scope and that's a fairly large part of VFS, filesystems,
VM and upper halves of block devices.

> additional rules imposed on the system.  Checker seems to be growing 
> functionality in this area, so it seems like a useful feature request.

Just be careful with that loop - (mutual) recursion through ->follow_link()
must be special-cased if you want anything interesting to come out of that.

