Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285554AbRLNWZT>; Fri, 14 Dec 2001 17:25:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285555AbRLNWZK>; Fri, 14 Dec 2001 17:25:10 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:60945 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S285554AbRLNWYy>;
	Fri, 14 Dec 2001 17:24:54 -0500
Date: Fri, 14 Dec 2001 06:35:59 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Rohland <cr@sap.com>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        "Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
Message-ID: <20011214063559.J18103@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Christoph Rohland <cr@sap.com>,
	Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Padraig Brady <padraig@antefacto.com>,
	"Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C0D2843.5060708@antefacto.com> <E16BLxI-0003Ic-00@the-village.bc.nu> <snaqhzhj.wl@nisaaru.dvs.cs.fujitsu.co.jp> <m3wv02oz2w.fsf@linux.local> <20011206173755.D16513@zax> <m3snamhwle.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3snamhwle.fsf@linux.local>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2001 at 10:53:48AM +0100, Christoph Rohland wrote:
> Hi David,
> 
> On Thu, 6 Dec 2001, David Gibson wrote:
> > The options are different because the ramfs limits patch predates
> > shmfs.
> 
> But tmpfs made it earlier into the kernel and if we want to merge the
> ramfs patch we should unify the options.

I know, just giving you the background.

> >> Further thought: Wouldn't it be better to add a no_swap mount
> >> option to shmem and try to merge the two? There is a lot of code
> >> duplication between mm/shmem.c and fs/ramfs/inode.c.
> > 
> > Possibly.  In fact the patch to fs/ramfs/inode.c will be
> > insufficient - the limits patch also requires a change to struct
> > address_space_operations in fs.h, and also a change in mm/pagemap.c.
> > shmfs applies the limits in a different way which doesn't need this, I
> > haven't looked at it enough to see how it's done - by the time shmfs
> > came around I'd moved on from the ramfs stuff.
> 
> I thought the patch in question does it without the removepage
> operation.

Oh, so it does, I wonder who did that.  Yes, I thought of doing it the
way its done there but rejected it on the grounds of ugliness - plus I
wasn't sure of some details of the VFS which meant I wasn't sure if it
would always work correctly.

> > On the other hand one of the nice things about ramfs is it's
> > simplicity and ramfs with limits is quite a bit less complex than
> > shmfs. 
> 
> But the core of shmem is always compiled. And the rest is as simple as
> ramfs...

The point of keeping ramfs simple isn't to reduce the kernel image
size, it's to keep it useful as an example of how to make a trivial
filesystem.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

