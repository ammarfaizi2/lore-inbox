Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284141AbRLFQoB>; Thu, 6 Dec 2001 11:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284933AbRLFQnv>; Thu, 6 Dec 2001 11:43:51 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:26372 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S284141AbRLFQnp>;
	Thu, 6 Dec 2001 11:43:45 -0500
Date: Thu, 6 Dec 2001 17:37:55 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Christoph Rohland <cr@sap.com>
Cc: Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Padraig Brady <padraig@antefacto.com>,
        "Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: question about kernel 2.4 ramdisk
Message-ID: <20011206173755.D16513@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Christoph Rohland <cr@sap.com>,
	Tachino Nobuhiro <tachino@open.nm.fujitsu.co.jp>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Padraig Brady <padraig@antefacto.com>,
	"Roy S.C. Ho" <scho1208@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C0D2843.5060708@antefacto.com> <E16BLxI-0003Ic-00@the-village.bc.nu> <snaqhzhj.wl@nisaaru.dvs.cs.fujitsu.co.jp> <m3wv02oz2w.fsf@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wv02oz2w.fsf@linux.local>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 09:23:03AM +0100, Christoph Rohland wrote:
> Hi Tachino,
> 
> On Wed, 05 Dec 2001, Tachino Nobuhiro wrote:
> > +		if (!strcmp(optname, "maxfilesize") && value) {
> > +			p->filepages = simple_strtoul(value, &value, 0)
> > +				/ K_PER_PAGE;
> > +			if (*value)
> > +				return -EINVAL;
> > +		} else if (!strcmp(optname, "maxsize") && value) {
> > +			p->pages = simple_strtoul(value, &value, 0)
> > +				/ K_PER_PAGE;
> > +			if (*value)
> > +				return -EINVAL;
> > +		} else if (!strcmp(optname, "maxinodes") && value) {
> > +			p->inodes = simple_strtoul(value, &value, 0);
> > +			if (*value)
> > +				return -EINVAL;
> > +		} else if (!strcmp(optname, "maxdentries") && value) {
> > +			p->dentries = simple_strtoul(value, &value, 0);
> > +			if (*value)
> > +				return -EINVAL;
> > +		}
> 
> Please! If you do the limit checking for ramfs adapt the same options
> like shmem.c i.e. size,nr_inodes,nr_blocks,mode(+uid+gid). Don't
> invent yet another mount option set. Also give them the same
> semantics. Best would be to use shmem_parse_options.

The options are different because the ramfs limits patch predates
shmfs.

> Further thought: Wouldn't it be better to add a no_swap mount option
> to shmem and try to merge the two? There is a lot of code duplication
> between mm/shmem.c and fs/ramfs/inode.c.

Possibly.  In fact the patch to fs/ramfs/inode.c will be insufficient
- the limits patch also requires a change to struct
address_space_operations in fs.h, and also a change in mm/pagemap.c.
shmfs applies the limits in a different way which doesn't need this, I
haven't looked at it enough to see how it's done - by the time shmfs
came around I'd moved on from the ramfs stuff.

On the other hand one of the nice things about ramfs is it's
simplicity and ramfs with limits is quite a bit less complex than
shmfs.  Of course, ramfs without limits is even simpler which is, I
believe, why Linus didn't merge the patch in the first place.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

