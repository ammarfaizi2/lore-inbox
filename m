Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317289AbSFLBIJ>; Tue, 11 Jun 2002 21:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317293AbSFLBIJ>; Tue, 11 Jun 2002 21:08:09 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:21923 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317289AbSFLBII>; Tue, 11 Jun 2002 21:08:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: george anzinger <george@mvista.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, dent@cosy.sbg.ac.at,
        adilger@clusterfs.com, da-x@gmx.net, patch@luckynet.dynu.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 - list.h cleanup 
In-Reply-To: Your message of "Tue, 11 Jun 2002 07:52:56 MST."
             <3D060EC8.321A0D66@mvista.com> 
Date: Wed, 12 Jun 2002 11:10:38 +1000
Message-Id: <E17Hwek-0002Y8-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3D060EC8.321A0D66@mvista.com> you write:
> On wonders if it might be useful to split header files into
> say for example, list_d.h and list_i.h with the declarations
> in the "_d.h" and inlines in the "_i.h".  Then we could move
> the "_i.h" includes to the end of the include list.  Yeah, I
> know, too many includes in includes to work.  

The only really sane way to implement "CONFIG_SMALL_NO_INLINES" that I
can think of is to have headers do

#include <linux/inline.h>

inline_me int function(int x) { return x++; }

Then inline.h contain:

#include <linux/config.h>
#ifdef CONFIG_SMALL_NO_INLINES
#define inline_me
#else
#define inline_me static inline
#endif

And if do a final compile of a file "inlines.c" like so if
CONFIG_SMALL_NO_INLINES is set:

#include <linux/config.h>
#undef CONFIG_SMALL_NO_INLINES

/* Instantiate one of each inline for real: auto-generated list */

#include <linux/header1.h>
#include <linux/header2.h>
#include <linux/header3.h>
#include <linux/header4.h>

Expect an implementation in... um... well, someone else perhaps?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
