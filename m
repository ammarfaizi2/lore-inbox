Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129106AbRBAAle>; Wed, 31 Jan 2001 19:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129088AbRBAAlT>; Wed, 31 Jan 2001 19:41:19 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:32086 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129055AbRBAAlC>;
	Wed, 31 Jan 2001 19:41:02 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: kasten@nscl.msu.edu
cc: linux-kernel@vger.kernel.org, "Ken Sandars" <ksandars@eurologic.com>
Subject: Re: BUG: v2.4.1 missing EXPORT_SYMBOL 
In-Reply-To: Your message of "Wed, 31 Jan 2001 15:44:29 CDT."
             <200101312044.PAA11405@tiger.nscl.msu.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Feb 2001 11:40:32 +1100
Message-ID: <9869.980988032@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2001 15:44:29 -0500 (EST), 
Eric Kasten <kasten@nscl.msu.edu> wrote:
>Quick bug report for kernel 2.4.1.  There needs to be a
>EXPORT_SYMBOL(name_to_kdev_t); at the bottom of linux/init/main.c.
>name_to_kdev_t is used by the md driver (and maybe others).  If the
>driver is built as a module it won't load due to the missing symbol.

Don't blame us when the driver gets an oops.  name_to_kdev_t is defined
__init so the code is discarded after boot and the area is reused as
scratch space.  You must not EXPORT_SYMBOL() any __init or __exit code.

The only place name_to_kdev_t is used in md is in the md_setup routine,
that routine probably only makes sense when md is built in, not when md
is a module.  I recommend wrapping md_setup and all its data in #ifndef
MODULE.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
