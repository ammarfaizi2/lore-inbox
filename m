Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129617AbRBKUPv>; Sun, 11 Feb 2001 15:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130004AbRBKUPl>; Sun, 11 Feb 2001 15:15:41 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:18694 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129617AbRBKUP3>;
	Sun, 11 Feb 2001 15:15:29 -0500
Message-ID: <3A86F2BA.1B50360C@mandrakesoft.com>
Date: Sun, 11 Feb 2001 15:14:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Nick Urbanik <nicku@vtc.edu.hk>,
        Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3 compile error in 6pack.c
In-Reply-To: <E14S04y-0004Tb-00@the-village.bc.nu> <3A86EF11.20C17FD8@mandrakesoft.com> <20010211210826.D20267@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Sun, Feb 11, 2001 at 02:59:13PM -0500, Jeff Garzik wrote:
> > Alan Cox wrote:
> > >
> > > > 2.4.2-pre3 doesn't compile with 6pack as a module; I had to disable it;
> > > > now it compiles (and so far, works fine).
> > >
> > > It has a slight dependancy on -ac right now.
> > >
> > > KMALLOC_MAXSIZE is the alloc size limit - 131072. It checks this as kmalloc
> > > now panics if called with an oversize request
> >
> > Would it be costly/reasonable to have kmalloc -not- panic if given a
> > too-large size?  Principle of Least Surprises says it should return NULL
> > at the very least.
> 
> It's on purpose; to find the erroneous drivers.

Oh good grief.  You will never find all such drivers.  Dynamic memory
allocation is by its definition dynamic.  Alloc size is often selected
at runtime based on a variety of factors.

printk a message and fail the call.  Don't panic.

We have a system in place to notify calls when kmalloc fails -- return
value.  Use that, it's what its there for...

	Jeff


-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
