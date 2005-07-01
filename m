Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263338AbVGAN3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbVGAN3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbVGAN3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:29:09 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:8682 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263338AbVGAN3E convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:29:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PLslrBSO9hMWdBTuPeFZmvqSPJ18IGtztKM7WNroUuFREhy66gRrQPfP+F8iGAN24aIteGiM5s4QeExqcZR/NP7gNxa09EDH3VWnGRl2Bh3Nu2kgNj97TbMhVd1of0asQX66+30zkDW6KIjUGd/VYVLR+muaMpGwMGUAu5/6uvo=
Message-ID: <a4e6962a050701062939ed1eb3@mail.gmail.com>
Date: Fri, 1 Jul 2005 08:29:01 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: FUSE merging?
Cc: Miklos Szeredi <miklos@szeredi.hu>, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com,
       v9fs-developer@lists.sourceforge.net
In-Reply-To: <20050701042955.39bf46ef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	 <20050630124622.7c041c0b.akpm@osdl.org>
	 <E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	 <20050630235059.0b7be3de.akpm@osdl.org>
	 <E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	 <20050701001439.63987939.akpm@osdl.org>
	 <E1DoG6p-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <20050701010229.4214f04e.akpm@osdl.org>
	 <E1DoIUz-0002a5-00@dorka.pomaz.szeredi.hu>
	 <20050701042955.39bf46ef.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/05, Andrew Morton <akpm@osdl.org> wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote: 
> > > > Userspace can tell the kernel, how long a dentry should be valid.  I
> > > > don't think the NFS protocol provides this. Same holds for the inode
> > > > attributes.
> > >
> > > Why is that needed?
> >
> > Because, I can well imagine a synthetic filesystem, where file
> > data/metadata change aribitrarily.  In this case the timeout heuristic
> > in NFS is not useful.
> >
> > In fact with NFS it's often a PITA, that it doesn't want to refresh a
> > file's data/metatata, which I _know_ has changed on the server.
> 
> I think nfs can do this, as long as the modification was done through the
> server.  I'd expect v9fs would be the same.
> 

v9fs aggressively invalidates dentries by default -- it is our
experience that caching metadata (particularly in synthetics) causes
more problems than it is worth.  That being said, there are prototype
designs for v9fs cache layers which actively detect if underlying file
systems are synthetic or static and allow parametrized cache policies
(for both the dcache and the page cache).

As a side-note which I know less about, I believe NFSv4 includes
server-push invalidation semantics, but I can't remember if that
applies to metadata or just data.

          -eric
