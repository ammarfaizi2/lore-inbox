Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317606AbSFMNYY>; Thu, 13 Jun 2002 09:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317610AbSFMNYX>; Thu, 13 Jun 2002 09:24:23 -0400
Received: from maild.telia.com ([194.22.190.101]:58066 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S317606AbSFMNYV>;
	Thu, 13 Jun 2002 09:24:21 -0400
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 37 stack variables >= 1K in 2.4.17
Date: Thu, 13 Jun 2002 15:24:14 +0200
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.GSO.4.21.0206122016140.16357-100000@weyl.math.psu.edu> <3D08583F.B40A4AFD@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200206131524.14495.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 June 2002 10.30, Helge Hafting wrote:
> Alexander Viro wrote:
> > 
> > On Wed, 12 Jun 2002, Benjamin LaHaise wrote:
> > 
> > > On Wed, Jun 12, 2002 at 06:26:55PM -0400, Alexander Viro wrote:
> > > > Not realistic - we have a recursion through the ->follow_link(), and
> > > > a lot of stuff can be called from ->follow_link().  We _do_ have a
> > > > limit on depth of recursion here, but it won't be fun to deal with.
> > >
> > > Perfection isn't what I'm looking for, rather just an approximation.
> > > Any tool would have to give up on non-trivial recursion, or have
> > 
> > ... in which case it will be useless - anything callable from path_walk()
> > will be out of its scope and that's a fairly large part of VFS, 
filesystems,
> > VM and upper halves of block devices.
> 
> The automated checker may use hard-coded limits for recursions with
> limited depth.  If follow_link stops after n iterations, tell
> the checker about it and it will use that in its computations.

Alexander Viro <viro@math.psu.edu> wrote:
> (link_path_walk->do_follow_link->foofs_follow_link->
> vfs_follow_link->link_path_walk)

It would not need to follow the recursion at all.

A simple warning "vfs_follow_link makes a recursive call back
to link_path_walk, stack space needed for each recursion is N bytes"

/RogerL

