Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbRAOSXq>; Mon, 15 Jan 2001 13:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129601AbRAOSXh>; Mon, 15 Jan 2001 13:23:37 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:38414 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S129485AbRAOSX1>; Mon, 15 Jan 2001 13:23:27 -0500
Date: Mon, 15 Jan 2001 19:22:01 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@frodo.biederman.org
Subject: Re: Caches, page coloring, virtual indexed caches, and more
Message-ID: <20010115192201.A18795@pcep-jamie.cern.ch>
In-Reply-To: <Pine.LNX.4.10.10101101100001.4457-100000@penguin.transmeta.com> <E14GR38-0000nM-00@the-village.bc.nu> <20010111005657.B2243@khan.acc.umu.se> <20010112035620.B1254@bacchus.dhis.org> <m17l40hhtd.fsf@frodo.biederman.org> <20010115005315.D1656@bacchus.dhis.org> <m1snmlfbrx.fsf_-_@frodo.biederman.org> <20010115095432.A14351@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010115095432.A14351@bacchus.dhis.org>; from ralf@uni-koblenz.de on Mon, Jan 15, 2001 at 09:54:32AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Baechle wrote:
> > mremap.  Linux specific but pretty much the same as mmap, but easier.
> > We just enforce that the virtual address of the source of mremap,
> > and the destination of mremap match on VIRT_INDEX_BITS.
> 
> Correct and as mremap doesn't take any address argument we won't break
> any expecations on the properties of the returned address in mmap.

See MREMAP_FIXED.  There is an address argument, not mentioned in the
manpage (man-pages 1.30).

> > Hmm.  This doesn't sound right.  And this sounds like a silly way to
> > use reverse mappings anyway, since you can do it up front in mmap and
> > their kin.  Which means you don't have to slow any of the page fault
> > logic up.
> 
> Then how do you handle something like:
> 
>   fd = open(TESTFILE, O_RDWR | O_CREAT, 664);
>   res = write(fd, one, 4096);
>   mmap(addr            , PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
>   mmap(addr + PAGE_SIZE, PAGE_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> 
> If both mappings are immediately created accessible you'll directly endup
> with aliases.  There is no choice, if the pagesize is only 4kb an R4x00
> will create aliases in the case.  Bad.

Indeed, a particularly nice way to handle circular buffers for DSP
algorithms provided it works :-)

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
