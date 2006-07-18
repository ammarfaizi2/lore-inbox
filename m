Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWGRVtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWGRVtZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWGRVtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:49:25 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:50742 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932171AbWGRVtZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:49:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=l3SSYHm01NlYdWUD9IgHBIrsHAGDhwi5WB8gGXmR4qheePcg2iouxM04YwUjqNhS7HsLST+4OEinWIsoTJ0rzKwOofY/10LL3nFIJLDHU11L963/eeSXVt4nlZHpYJrngYOsyPlY6CXVtiIMcQ/UTCng8b75hDyCJiHnIlRjGUM=
Message-ID: <1defaf580607181449p138c2cfayc3df3657430624f8@mail.gmail.com>
Date: Tue, 18 Jul 2006 23:49:24 +0200
From: "Haavard Skinnemoen" <hskinnemoen@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: 2.6.18-rc1-mm2
Cc: "Haavard Skinnemoen" <hskinnemoen@atmel.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>, "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <1152892123.24925.67.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20060713224800.6cbdbf5d.akpm@osdl.org>
	 <1152892123.24925.67.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/06, Dave Hansen <haveblue@us.ibm.com> wrote:
> > +#define PFN_UP(x)    (((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
> > +#define PFN_DOWN(x)  ((x) >> PAGE_SHIFT)
> > +#define PFN_PHYS(x)  ((x) << PAGE_SHIFT)
>
> Please use include/linux/pfn.h instead of defining these

Ah, of course.

> > Since there's only a single board available, and that board has no use for
> > discontigmem or sparsemem anyway, I figured it's better to just turn it off
> > until a need for it arises.
>
> How about we help you get sparsemem working properly, and you can kill
> all of the discontigmem support from your arch?  You can be the first
> non-legacy-impeded architecture. ;)

That would be great. I think maybe I should start by ripping out the
discontigmem stuff altogether, since there are no boards available
that requires it. But I can perhaps test sparsemem on a prototype
board.

> Feel free to mail Andy or myself with your compile errors, and I'm sure
> we can iron it out.  I'd try myself, but I don't have a cross-compiler
> for your arch yet.  Do you have one handy?

Thanks. There are patches for binutils and gcc available from avr32linux.org:

http://avr32linux.org/twiki/pub/Main/GccPatches/gcc-4.0.2-avr32.patch
http://avr32linux.org/twiki/bin/view/Main/BinutilsPatches

For binutils you should probably grab the pre-patched source tarball
unless you want to mess around with autoconf. I tried to make a patch
after regenerating all the makefiles, but the patch ended up being 5x
the size of the original one...

> It would also be nice to see a _couple_ of patches that perhaps abstract
> a thing or two into generic code.  I know that new architectures usually
> begin with a 'cp -r', but it would be nice to see a wee bit of code
> refactoring as a small price of admission.  Some of the ioremap and
> other pagetable code looked pretty generic to me.

The pagetable code in ioremap.c is indeed copied verbatim from another
architecture (I think it was MIPS.) I'll look at all the
implementations of remap_area_pages() and see if it's possible to
consolidate them when I get back to work in a bit less than two weeks.

I won't be submitting any patches until then, but your mail will wait
for me in my inbox so I won't forget about it. Thanks for taking the
time to review this.

Håvard
