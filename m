Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWFMMrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWFMMrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 08:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWFMMrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 08:47:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:1144 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750759AbWFMMrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 08:47:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mr8f+kzAcstUhIf3M7IGje0ASiK5JGA0BgzM/n9LjMFBbO4MfbQaORxMsIQ768CYjCyOxFTfgbbrvEsenlJlGJ2iIavKRZPAdUukUTN8exQr3rCAlyB4nLKNm9+PUWD+jQAbKj08GugBGOAwhYmns4gOJeOYMOBUywmaCD22ACM=
Message-ID: <b0943d9e0606130547v408b2326r43ee481a5c6ac1ff@mail.gmail.com>
Date: Tue, 13 Jun 2006 13:47:48 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 2.6.17-rc6 1/9] Base support for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020606130414m9f1cdaq2a0ccb29a5c3b2dd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
	 <20060611112105.8641.31038.stgit@localhost.localdomain>
	 <84144f020606130414m9f1cdaq2a0ccb29a5c3b2dd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/06/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 6/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > --- /dev/null
> > +++ b/include/linux/memleak.h
> > @@ -0,0 +1,83 @@
> > +extern void memleak_scan_area(const void *ptr, unsigned long offset, size_t length);
> > +extern void memleak_insert_aliases(struct memleak_offset *ml_off_start,
> > +                                  struct memleak_offset *ml_off_end);
> > +
> > +#define memleak_erase(ptr)     do { (ptr) = NULL; } while (0)
>
> Use static inline functions instead of macros, please.

That was the simplest way in some cases when kmemleak was not
dependent on DEBUG_SLAB obj_size() in mm/slab.c was not always
defined. It works correctly with inlining now so I'll change them.

> > +#define memleak_container(type, member)

This cannot be an inline function as it takes a type as argument.

> > +static int __initdata preinit_pos = 0;
>
> Unnecessary initialization to zero.
>
> > +static struct memleak_pointer *last_pointer = NULL;
>
> Same here for NULL.

True, it is unnecessary. That's just my style of marking them as initialised.

> > +static int insert_alias(unsigned long size, unsigned long offset)
> > +{
> > +       int ret = 0;
>
> Unnecessary initialization to zero.

That's needed because there is an exit path which doesn't set this variable.

I am OK with the other comments. Thanks.

-- 
Catalin
