Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSIDUhY>; Wed, 4 Sep 2002 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315419AbSIDUhY>; Wed, 4 Sep 2002 16:37:24 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:24259 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S315416AbSIDUhX>; Wed, 4 Sep 2002 16:37:23 -0400
Date: Wed, 4 Sep 2002 13:56:52 -0700
From: Matt Porter <porter@cox.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Craig Arsenault <penguin@wombat.ca>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Tom Rini <trini@kernel.crashing.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org
Subject: Re: consequences of lowering "MAX_LOW_MEM"?
Message-ID: <20020904135652.C27144@home.com>
References: <Pine.LNX.4.44L.0209041453060.8359-100000@tabmow.ca.nortel.com> <20020904200227.30104@192.168.4.1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020904200227.30104@192.168.4.1>; from benh@kernel.crashing.org on Wed, Sep 04, 2002 at 10:02:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2002 at 10:02:27PM +0200, Benjamin Herrenschmidt wrote:
> 
> >
> >> >I think you'll find yourself with no virtual address space left to
> >> >do vmalloc / fixmap / kmap type stuff. Or at least you would on i386,
> >> >I presume it's the same for ppc. Sounds like you may have left
> >> >yourself enough space for fixmap & kmap, but any calls to vmalloc
> >> >will probably fail ?
> >>
> >> Yes, same problem on PPC, you'll run out of virtual space quite
> >> quickly for vmalloc and ioremap. Stuff a video board with lots
> >> of VRAM or any PCI card exposing large MMIO regions into your
> >> machines and it will probably not even boot.
> >>
> >> Ben.
> >>
> >
> >Ben,
> >  But doesn't using Matt's suggestion and moving both MAX_LOW_MEM and
> >changing KERNELBASE take care of this?  It's an embedded board with no
> >video, but it does have one PCI Mezzanine Card (PMC) on it.
> 
> Yes, Matt's suggestion would work, though I never tried lowering
> KERNELBASE. I don't think the kernel supports lowering it below
> 0x80000000 btw.

Take a look at those options. :)  I added one to tweak TASK_SIZE
from the PPC default of 0x80000000.

I've run a system with a TASK_SIZE of 1GB, MAX_LOW_MEM at 16MB,
PAGE_OFFSET at 0x40000000, and HIGHMEM on with the PKMAP_BASE
placed up higher than the default 0xfe000000 (with a 1GB of RAM
installed) to allow for close to 3GB of vmalloc space.  Certain
embedded systems with large PCI windows (like non-transparent
bridges, for example) gobble up vmalloc space pretty darn quickly.
This is just getting worse with RapidIO on a 32-bit processor.

Regards,
-- 
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.
