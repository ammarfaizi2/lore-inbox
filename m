Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278108AbRJLUHX>; Fri, 12 Oct 2001 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278115AbRJLUHP>; Fri, 12 Oct 2001 16:07:15 -0400
Received: from nsd.netnomics.com ([216.71.84.35]:44098 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278111AbRJLUHC>; Fri, 12 Oct 2001 16:07:02 -0400
Date: Fri, 12 Oct 2001 15:07:14 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: <200110121945.f9CJjX0V019814@pincoya.inf.utfsm.cl>
Message-ID: <Pine.LNX.3.96.1011012150220.6594E-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2001, Horst von Brand wrote:
> Matt Domsch <Matt_Domsch@dell.com> said:
> > In trying to get my EFI GUID Partition Table patch included into the stock
> > kernel, Andreas Dilger suggested it was time for some crc32 cleanup, as
> > the GPT patch added yet another copy of the common crc32 function.  So,
> > here's my first pass at it.  Comments welcome.
> 
> [...]
> 
> > This patch (appended below), makes include/linux/crc32.h and
> > lib/crc32.c.  It generates a table based on the commonly used polynomial
> > at init time provided a driver needs it.  It changes ether_crc_le() to use
> > this table.  It renames the commonly seen ether_crc() to be
> > ether_crc_be(), and puts it in crc32.h (allowing lots of copies to be
> > deleted).
> 
> You could just place the functions (each with its table) into separate .c
> files, and place them in the library. The linker will then include them iff
> they are referenced somewhere. OTOH, they _are_ all over the place right
> now, so they could just be included unconditionally. Thinking of ways to
> set up to have them included in case only modules use them makes me
> shiver...

Then leave that task to others ;-)

We must consider the case where the kernel is built, and then a random
3rd party module comes along that needs crc32 features.  An ar library
won't cut it, and neither will [the existing crc32 method of] patching
linux/lib/crc32.c.  That leaves (a) unconditionally building it into the
kernel, or (b) Makefile and Config.in rules.

	Jeff



