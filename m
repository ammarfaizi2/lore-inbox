Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314243AbSEBDWW>; Wed, 1 May 2002 23:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314244AbSEBDWV>; Wed, 1 May 2002 23:22:21 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7016 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314243AbSEBDWV>; Wed, 1 May 2002 23:22:21 -0400
To: Stephen Lord <lord@sgi.com>
Cc: Andrew Morton <akpm@zip.com.au>, Mike Fedyk <mfedyk@matchmail.com>,
        Guillaume Boissiere <boissiere@attbi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  May 1, 2002
In-Reply-To: <3CCFBB21.9046.7889B0D2@localhost>
	<20020501201927.GS574@matchmail.com> <3CD0605D.ACC42AA2@zip.com.au>
	<1020301894.1171.2.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 May 2002 21:14:27 -0600
Message-ID: <m1adrjz1f0.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Lord <lord@sgi.com> writes:

> On Wed, 2002-05-01 at 16:38, Andrew Morton wrote:
> > Mike Fedyk wrote:
> > > 
> > > On Wed, May 01, 2002 at 09:53:37AM -0400, Guillaume Boissiere wrote:
> > > > new framebuffer layer, as well as some more delayed disk block
> > > > allocation bits.
> > > 
> > > Actually Andrews work on address_space based writeback is related somewhat,
> > > but really it's a rewrite/cleanup of the buffer layer.  Delayed block
> > > alocation is helped alot by this, and almost depends on it IIRC.
> > > 
> > > One vote for a seperate listing in the status for "Address Space based
> > > Writeback / Buffer layer cleanup".
> > 
> > Well the next major step here is going direct
> > pagecache<->BIO, bypassing the intermediate submit_bh
> > for most I/O.
> > 
> > Probably that will make most of the performance benefits
> > of delayed-allocate go away.
> 
> Most of the performance benefits of delayed allocate are that
> you do not the hard work of allocating the disk space in each
> write call, you get to do it once, in potentially larger chunks,
> and often not in the user's context.

Except for moving the work out of the users context, ext2 gets
a similar benefit by reserving disk space ahead of time.  So it isn't
clear that you need to have a delayed allocation to achieve this.

Eric
