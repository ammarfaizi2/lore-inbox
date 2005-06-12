Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVFLUDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVFLUDS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 16:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbVFLTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:23:08 -0400
Received: from aun.it.uu.se ([130.238.12.36]:8180 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262650AbVFLREJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 13:04:09 -0400
Date: Sun, 12 Jun 2005 19:03:53 +0200 (MEST)
Message-Id: <200506121703.j5CH3rZs020503@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: vda@ilport.com.ua
Subject: Re: [PATCH 2.4.31 9/9] gcc4: fix i386 struct_cpy() warnings
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2005 19:43:03 +0300, Denis Vlasenko wrote:
> > diff -rupN linux-2.4.31/include/asm-i386/string.h linux-2.4.31.gcc4-i386-struct_cpy-warnings/include/asm-i386/string.h
> > --- linux-2.4.31/include/asm-i386/string.h	2001-08-12 11:35:53.000000000 +0200
> > +++ linux-2.4.31.gcc4-i386-struct_cpy-warnings/include/asm-i386/string.h	2005-06-12 11:52:25.000000000 +0200
> > @@ -337,7 +337,7 @@ extern void __struct_cpy_bug (void);
> >  #define struct_cpy(x,y) 			\
> >  ({						\
> >  	if (sizeof(*(x)) != sizeof(*(y))) 	\
> > -		__struct_cpy_bug;		\
> > +		__struct_cpy_bug();		\
> >  	memcpy(x, y, sizeof(*(x)));		\
> >  })
> 
> 1) Don't you need a void __struct_cpy_bug(void) declaration before this
>    (as a matter of style, not correctness)?

Not any more than would the original version with the variable.
gcc4 doesn't complain.

> 2) Why __ ? It is not compiler- or library-special, why not
>    BUG_struct_cpy_different_sizes() or something like this?

Ask the original author. I'm just following existing practise.
(I only seek minimal changes to enable gcc4 support, I'm _not_
on a mission to "clean up" code.)

/Mikael
