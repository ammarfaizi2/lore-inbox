Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWGUWen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWGUWen (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 18:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbWGUWen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 18:34:43 -0400
Received: from gepetto.dc.ltu.se ([130.240.42.40]:40068 "EHLO
	gepetto.dc.ltu.se") by vger.kernel.org with ESMTP id S1751236AbWGUWem
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 18:34:42 -0400
Message-ID: <1153521067.44c155ab6b7d4@portal.student.luth.se>
Date: Sat, 22 Jul 2006 00:31:07 +0200
From: ricknu-0@student.ltu.se
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [RFC][PATCH] A generic boolean (version 2)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153445087.44c02cdf40511@portal.student.luth.se> <44C02F35.4000604@garzik.org>
In-Reply-To: <44C02F35.4000604@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
X-Originating-IP: 130.240.42.170
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Citerar Jeff Garzik <jeff@garzik.org>:

> ricknu-0@student.ltu.se wrote:
> > diff --git a/include/asm-i386/types.h b/include/asm-i386/types.h
> > index 4b4b295..841792b 100644
> > --- a/include/asm-i386/types.h
> > +++ b/include/asm-i386/types.h
> > @@ -1,6 +1,13 @@
> >  #ifndef _I386_TYPES_H
> >  #define _I386_TYPES_H
> >  
> > +#if defined(__GNUC__)
> > +typedef _Bool bool;
> > +#else
> > +#warning You compiler doesn't seem to support boolean types, will set
> 'bool' as
> > an 'unsigned int'
> > +typedef unsigned int bool;
> > +#endif
> > +
> >  #ifndef __ASSEMBLY__
> >  
> >  typedef unsigned short umode_t;
> 
> Just delete the #ifdef and assume its either gcc, or a compatible 
> compiler.  That's what we assume with other data types.

You are right. Will remove it.
Just remembered one of reasons I had version-check before, how about linux 2.4?
What I understand, they have the same drivers as 2.6 but they have not commited
to use gcc >= 3. Can anyone confirm or deny this? Otherwise the discussion about
alternetiv bool-type is off no relevence anymore.

> 
> 
> > @@ -10,6 +17,8 @@ typedef unsigned short umode_t;
> >   * header files exported to user space
> >   */
> >  
> > +typedef bool __u1;
> > +
> >  typedef __signed__ char __s8;
> >  typedef unsigned char __u8;
> >  
> > @@ -36,6 +45,8 @@ #define BITS_PER_LONG 32
> >  #ifndef __ASSEMBLY__
> >  
> >  
> > +typedef bool u1;
> > +
> >  typedef signed char s8;
> >  typedef unsigned char u8;
> >  
> 
> I wouldn't bother with these types.  Nobody uses creates in their own 
> hand-crafted bool uses, so I don't think people would suddenly start.

Removed

/Richard
