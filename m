Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284998AbRLQEqd>; Sun, 16 Dec 2001 23:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285000AbRLQEqY>; Sun, 16 Dec 2001 23:46:24 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:41227 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284998AbRLQEqP>;
	Sun, 16 Dec 2001 23:46:15 -0500
Date: Mon, 17 Dec 2001 14:49:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Rohland <cr@sap.com>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        "Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
Message-ID: <20011217144929.Q30975@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Christoph Rohland <cr@sap.com>,
	Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Padraig Brady <padraig@antefacto.com>,
	"Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C0D2843.5060708@antefacto.com> <E16BLxI-0003Ic-00@the-village.bc.nu> <snaqhzhj.wl@nisaaru.dvs.cs.fujitsu.co.jp> <m3wv02oz2w.fsf@linux.local> <20011206173755.D16513@zax> <m3snamhwle.fsf@linux.local> <20011214063559.J18103@zax> <m3bsh07rd6.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3bsh07rd6.fsf@linux.local>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2001 at 04:34:01PM +0100, Christoph Rohland wrote:
> Hi David,
> 
> On Fri, 14 Dec 2001, David Gibson wrote:
> >> But the core of shmem is always compiled. And the rest is as simple
> >> as ramfs...
> > 
> > The point of keeping ramfs simple isn't to reduce the kernel image
> > size, it's to keep it useful as an example of how to make a trivial
> > filesystem.
> 
> >From this point of view I prefer the oversimplified version in the
> stock kernel. We should probably correct the comment about missing
> features like limits and timestamps and tag it as experimental.  But
> IMHO this version explains the underlying concept best.
> 
> 
> If we want a useable ramfs implementation we should try to keep the
> image size down and try to make it as similar to tmpfs as
> possible. This would keep the administrators overhead low.
> 
> I append two cummulative patches against 2.4.17-rc1 (only slightly
> tested):
> 
> 1) Add removepage to the addresspace_operations to simplify
>    shmem.c. This is taken from your ramfs limits patch.
> 2) Add support for a ramfs2 filesystem type to shmem.c. The only
>    feature missing compared to ramfs + limits are loopback devices on
>    top of ramfs files. It does not add memory need compared to
>    ramfs. Have a look how small this is.

I don't think there's a lot of point playing with this in 2.4.x.  In
2.5 it depends a bit on what changes to the VFS happen.  I recall that
near the end of the 2.3 cycle Al Viro proposed a change to add
essentially a removepage operation (he called it detachpage IIRC) - he
was using it to eliminate a bunch of the "if (page->buffers)" tests.
I don't know it that's still on the cards - it so it could certainly
simplify both ramfs and shmfs.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

