Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932564AbWGSXRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932564AbWGSXRs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932565AbWGSXRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:17:48 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:22663 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S932564AbWGSXRs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:17:48 -0400
Message-ID: <1153351042.44bebd82356a4@portal.student.luth.se>
Date: Thu, 20 Jul 2006 01:17:22 +0200
From: ricknu-0@student.ltu.se
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se> <44BE9E78.3010409@garzik.org>
In-Reply-To: <44BE9E78.3010409@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Jeff Garzik <jeff@garzik.org>:

> ricknu-0@student.ltu.se wrote:
> > A first step to a generic boolean-type. The patch just introduce the bool
> (in
> 
> Since gcc supports boolean types and can optimize for such, introducing 
> bool is IMO a good thing.
Good to hear :)

> > -Why would we want it?
> > -There is already some how are depending on a "boolean"-type (like NTFS).
> 
> A better reason is that there is intrinsic compiler support for booleans.
Yeah, true.


> > -Why false and not FALSE, why not "enum {...} bool"
> > -They are not #define(d) and shouldn't because it is a value, like 'a'.
> But
> > because it is just a value, then bool is just a variable and should be able
> to
> > handle 0 and 1 equally well.
> > 
> > Well, this is _my_ opinion, it may be totally wrong. If so, please tell me
> ;)
> 
> > Yes, I know about Andrew's try to unify TRUE and FALSE, did read the thread
> with
> > interest (that's from where I got to know about _Bool). But mostly (then
> still
> > on the subject) was some people did not want FALSE and TRUE instead of 0
> and 1.
> > I look at it as: 'a' = 97, if someone like to write 97 instead of 'a',
> please do
> > if you find it easier to read. I, on the other hand, think it is easier
> with
> > 'a', false/FALSE, NULL, etc.
> 
> We should follow what C99 directs.
Yes. But I can not say I know what you are refering to. The enum vs #define,
false vs FALSE or both. May you please point me to appropriate text.


> > diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> > index 4b4b295..e35709a 100644
> > --- a/include/asm-i386/types.h
> > +++ b/include/asm-i386/types.h
> > @@ -10,6 +10,15 @@ typedef unsigned short umode_t;
> >   * header files exported to user space
> >   */
> >  
> > +#if defined(__GNUC__) && __GNUC__ >= 3
> > +typedef _Bool bool;
> > +#else
> > +#warning You compiler doesn't seem to support boolean types, will set
> 'bool' as
> > an 'unsigned char'
> > +typedef unsigned char bool;
> > +#endif
> > +
> > +typedef bool u2;
> 
> NAK.  gcc >= 3 is required by now, AFAIK.
Thanks, I forgot to remove it


> Also, you don't want to force 'unsigned char' on code, because often 
> code prefers a machine integer to something smaller than a machine integer.
But isn't a bit smaller than a byte? Sorry, do not understand what you mean.


> > diff --git a/include/linux/stddef.h b/include/linux/stddef.h
> > index b3a2cad..5e5c611 100644
> > --- a/include/linux/stddef.h
> > +++ b/include/linux/stddef.h
> > @@ -10,6 +10,8 @@ #else
> >  #define NULL ((void *)0)
> >  #endif
> >  
> > +enum { false = 0, true = 1 } __attribute__((packed));
> 
> How is 'packed' attribute useful here?
Oh, nothing really. Added without thinking, nice catch.

