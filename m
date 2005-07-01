Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262775AbVGAIDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbVGAIDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 04:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVGAIDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 04:03:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263269AbVGAIDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 04:03:24 -0400
Date: Fri, 1 Jul 2005 01:02:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: miklos@szeredi.hu, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
Message-Id: <20050701010229.4214f04e.akpm@osdl.org>
In-Reply-To: <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	<20050630235059.0b7be3de.akpm@osdl.org>
	<E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	<20050701001439.63987939.akpm@osdl.org>
	<E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > >
> > > > >
> > > > >  > - aren't we going to remove the nfs semi-server feature?
> > > > > 
> > > > >  I leave the decision to you ;)  It's a separate independent patch
> > > > >  already (fuse-nfs-export.patch).
> > > > 
> > > > Let's leave it out - that'll stimulate some activity in the
> > > > userspace-nfs-server-for-FUSE area.
> > > > 
> > > > Speaking of which, dumb question: what does FUSE offer over simply using
> > > > NFS protocol to talk to the userspace filesystem driver?
> > > 
> > > Oh lots:
> > > 
> > >   - no deadlocks (NFS mounted from localhost is riddled with them)
> > 
> > It is?  We had some low-memory problems a while back, but they got fixed. 
> > During that work I did some nfs-to-localhost testing and things seemed OK.
> 
> Well, there's the "unsolvable" writeback deadlock problem, that FUSE
> works around by not buffering dirty pages (and not allowing writable
> mmap).  Does NFS solve that?  I'm interested :)

I don't know - first you'd have to describe it.

> Then there's the usual "filesystem recursing into itself" deadlock.

Describe this completely as well, please.

> Mounting with 'intr' probably solves this for NFS, but that has
> unwanted side effects.  FUSE only allows KILL to interrupt a request.

Maybe these things can be solved in NFS?

> > >   - dcache invalidation policy
> > 
> > What's that?
> 
> Userspace can tell the kernel, how long a dentry should be valid.  I
> don't think the NFS protocol provides this. Same holds for the inode
> attributes.

Why is that needed?

> > >   - probably more, but I can't remember
> > 
> > Please do..
> 
> OK, I'll do a little research.
> 

v9fs has a user-level server too.  Maybe it has been used in FUSE-like
scenarios more than NFS.

Plus NFS and v9fs work across the network...
