Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291084AbSBLULz>; Tue, 12 Feb 2002 15:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291162AbSBLULp>; Tue, 12 Feb 2002 15:11:45 -0500
Received: from mail.libertysurf.net ([213.36.80.91]:10022 "EHLO
	mail.libertysurf.net") by vger.kernel.org with ESMTP
	id <S291084AbSBLULa> convert rfc822-to-8bit; Tue, 12 Feb 2002 15:11:30 -0500
Date: Mon, 11 Feb 2002 22:10:44 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Daniel Stodden <stodden@in.tum.de>
cc: "David S. Miller" <davem@redhat.com>, <alan@lxorguk.ukuu.org.uk>,
        <zaitcev@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pci_pool reap?
In-Reply-To: <1013528224.2240.245.camel@bitch>
Message-ID: <20020211220922.I1867-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So, everything is ok. :-)

  Gérard.

On 12 Feb 2002, Daniel Stodden wrote:

> hi.
>
> On Tue, 2002-02-12 at 03:44, David S. Miller wrote:
> >    From: Gérard Roudier <groudier@free.fr>
> >    Date: Sun, 10 Feb 2002 21:20:05 +0100 (CET)
> >
> >    On Mon, 11 Feb 2002, Alan Cox wrote:
> >
> >    > This function may not be called in interrupt context.
> >
> >    Such limitation looks poor implementation to me.
> >
> > I agree with you Gerard, and probably nobody truly even requires
> > this limitation.  I do plan to remove it after I've done a thorough
> > investigation of the platform implementations.
>
> ok, i've looked through most of 2.5.4 now.
> results look like this:
>
> 			pci_alloc_consistent()	pci_free_consistent()
> i386:
> 		[1]	ok			ok
>
> ppc:
> 		[1]	ok			ok
>
> mips:
> 		[1]	ok			ok
>
> sh:
> 		[1]	ok			ok
>   stm:		[1]	ok			ok
>   dc:		[3]	ok			ok
>
> mips64:
>   ip32:		[1]	ok			ok
>   ip27:		[1]	ok			ok
>
> sparc:
> 		[1]	GFP_KERNEL		ok
> sparc64:
> 		[2]	ok			ok
>
> arm:		[4]	BUG()/GFP_KERNEL	BUG()
>
> alpha:
> 		[2]	ok			ok
>
> ia64:		[5]	ok?			ok?
>
>
> [1]
> gfp() + __pa() (or similar)
>
> [2]
> gfp() + IOMMU
>
> [3]
> dummy, offsets only
>
> [4]
> ARM does GFP_KERNEL, and then __ioremaps the underlying pages.
> ugh. is that the only way to get the area coherent?
> furthermore i don't see why this could not be interrupt safe.
>
> [5]
> i don't understand ia64. but it looks somewhat atomic :)
>
> well, assuming i didn't oversee anything, there are indeed few reasons
> left why the whole _consistent() machinery shouldn't be callable from
> interrupts.
>
> back to my original question: what were the last trees with shrinking
> pools? would the original version still work or any redesigns needed?
>
>
> regards,
> dns
>
> --
> ___________________________________________________________________________
>  mailto:stodden@in.tum.de
>
>

