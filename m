Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278246AbRJMCgx>; Fri, 12 Oct 2001 22:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278247AbRJMCgn>; Fri, 12 Oct 2001 22:36:43 -0400
Received: from nsd.mandrakesoft.com ([216.71.84.35]:38208 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S278246AbRJMCgX>; Fri, 12 Oct 2001 22:36:23 -0400
Date: Fri, 12 Oct 2001 21:36:45 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org
Subject: Re: crc32 cleanups 
In-Reply-To: <14801.1002937877@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.3.96.1011012213105.20962B-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 13 Oct 2001, Keith Owens wrote:

> On Fri, 12 Oct 2001 14:37:52 -0500 (CDT), 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >(linux/lib/Makefile)
> >obj-$(CONFIG_TULIP) += crc32.o
> >obj-$(CONFIG_NATSEMI) += crc32.o
> >obj-$(CONFIG_DMFE) += crc32.o
> >obj-$(CONFIG_ANOTHERDRIVER) += crc32.o
> 
> It is better to define CONFIG_CRC32 and have the Config.in files set
> CONFIG_CRC32 for selected drivers.  That avoids the problem of lots of
> drivers wanting to patch the same Makefile, instead the selection of
> crc32 is kept with the driver selection.
> 
> lib/Makefile
> obj-$(CONFIG_CRC32) += crc32.o
> 
> drivers/foo/Config.in
> if [ "$CONFIG_FOO" = "y" ]; then
>   define_bool CONFIG_CRC32 y
> fi
> 
> It is even cleaner in CML2.
> require FOO implies CRC32=y

No, because that doesn't take care of the module case (CONFIG_CRC32=m).
Note how things get a whole lot uglier when you remember that.  Now
consider when CONFIG_FOO=m (implies CONFIG_CRC32=m), and then later on
in the Config.in files, CONFIG_BAR=y (which means CONFIG_CRC32 much be
switched from 'm' to 'y').


> In general it is a bad idea to handle selections in the Makefile, that
> is what CML is for.  Makefiles should just build the code based on CML
> output, not try to decide what to build.

Um, whatever.  That's the whole purpose of

	obj-$(CONFIG_FOO) += ...

it allows the makefile to automagically decide whether or not to build
that particular module into the kernel or separately with -DMODULE.  And
that decision occurs at build time, after all the 'make config' steps
have occurred, and we know exactly what modules to build.

	Jeff



