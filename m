Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSFNKGU>; Fri, 14 Jun 2002 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317903AbSFNKGT>; Fri, 14 Jun 2002 06:06:19 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:7955 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317587AbSFNKGS>; Fri, 14 Jun 2002 06:06:18 -0400
Message-ID: <3D09C00F.C43ADE77@aitel.hist.no>
Date: Fri, 14 Jun 2002 12:06:07 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.20-dj3 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
In-Reply-To: <Pine.GSO.4.21.0206122016140.16357-100000@weyl.math.psu.edu> <3D08583F.B40A4AFD@aitel.hist.no> <200206131524.14495.roger.larsson@skelleftea.mail.telia.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson wrote:

> > The automated checker may use hard-coded limits for recursions with
> > limited depth.  If follow_link stops after n iterations, tell
> > the checker about it and it will use that in its computations.
> 
> Alexander Viro <viro@math.psu.edu> wrote:
> > (link_path_walk->do_follow_link->foofs_follow_link->
> > vfs_follow_link->link_path_walk)
> 
> It would not need to follow the recursion at all.
> 
> A simple warning "vfs_follow_link makes a recursive call back
> to link_path_walk, stack space needed for each recursion is N bytes"
> 
That's all you can do with recursion of unknown depth, sure.

But the recursion here is known limited, and we want to know
"what is the deepest stack we can get into, following the
deepest call chain _after_ VFS recursed 5 levels of symlinks"
We know it won't recurse after that - but it might go
on calling x levels of non-recursive functions.

Hard-coding the limit for that particular call chain makes
sense as a lot of stuff may be called from it.  Or similiar,
various stuff may pile up on the stack and _then_ call into VFS
and recurse to the limit.

Printing the hardcoded assumption is probably a good idea when 
it is used to find some max depth - the kernel code might change
after all.


Helge Hafting
