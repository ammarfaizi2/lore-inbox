Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130576AbRBAPQR>; Thu, 1 Feb 2001 10:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130564AbRBAPQG>; Thu, 1 Feb 2001 10:16:06 -0500
Received: from kirk.nscl.msu.edu ([35.8.34.84]:7699 "EHLO kirk.nscl.msu.edu")
	by vger.kernel.org with ESMTP id <S129168AbRBAPP7>;
	Thu, 1 Feb 2001 10:15:59 -0500
From: Eric Kasten <kasten@nscl.msu.edu>
Message-Id: <200102011515.f11FFDd17690@kirk.nscl.msu.edu>
Subject: Re: BUG: v2.4.1 missing EXPORT_SYMBOL
In-Reply-To: <9869.980988032@kao2.melbourne.sgi.com> from Keith Owens at "Feb
 1, 2001 11:40:32 am"
To: Keith Owens <kaos@ocs.com.au>
Date: Thu, 1 Feb 2001 10:15:13 -0500 (EST)
CC: linux-kernel@vger.kernel.org, Ken Sandars <ksandars@eurologic.com>
Reply-To: kasten@nscl.msu.edu
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 31 Jan 2001 15:44:29 -0500 (EST), 
> Eric Kasten <kasten@nscl.msu.edu> wrote:
> >Quick bug report for kernel 2.4.1.  There needs to be a
> >EXPORT_SYMBOL(name_to_kdev_t); at the bottom of linux/init/main.c.
> >name_to_kdev_t is used by the md driver (and maybe others).  If the
> >driver is built as a module it won't load due to the missing symbol.
> 
> Don't blame us when the driver gets an oops.  name_to_kdev_t is defined
> __init so the code is discarded after boot and the area is reused as
> scratch space.  You must not EXPORT_SYMBOL() any __init or __exit code.
> 
> The only place name_to_kdev_t is used in md is in the md_setup routine,
> that routine probably only makes sense when md is built in, not when md
> is a module.  I recommend wrapping md_setup and all its data in #ifndef
> MODULE.

Which is fine by me.  I'm not using the md driver much on 2.4.1 at the
moment -- just testing to make sure that most of the things that I'll
use in the longer run are working.  Hence, pass on what I know of the
problem and what appears to fix it and hopefully get a bit of a review
by those buried deeper in the kernel than I am (have time to be)
at the moment (which you have aptly provided).

Thanks.

...Eric

Eric Kasten
kasten@nscl.msu.edu
National Superconducting Cyclotron Lab
(517) 333-6412
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
