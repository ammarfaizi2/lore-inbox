Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292388AbSBUO1U>; Thu, 21 Feb 2002 09:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292390AbSBUO1L>; Thu, 21 Feb 2002 09:27:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292388AbSBUO1A>;
	Thu, 21 Feb 2002 09:27:00 -0500
Message-ID: <3C7503B1.E7CA83AA@mandrakesoft.com>
Date: Thu, 21 Feb 2002 09:26:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Giacomo Catenazzi <cate@debian.org>
CC: andersen@codepoet.org, Roman Zippel <zippel@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <fa.fsgrt4v.1bngh9t@ifi.uio.no> <fa.hp69onv.i7qtq3@ifi.uio.no> <3C74FF03.8070502@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo Catenazzi wrote:
> 
> Jeff Garzik wrote:
> 
> > Erik Andersen wrote:
> >
> >>I like this.  It's simple, its clean, and it keeps all the
> >>information in one spot.  I think we can go a bit farther here
> >>and add in a list of the .c files that enabling this feature
> >>should add to the Makefile (per the current
> >>    obj-$(CONFIG_FOO)            += foo.o
> >>stuff in the current Makefile).
> >
> > Seriously, yep, that's exactly where we eventually want to be:  all
> > config, makefile, and help text info in one place.  To add a new net
> > driver, I want to be able to simply add two files, driver.c and
> > driver.conf, and be done with it.
> 
> with kbuild-2.5 this can be done easy. We should maintain
> the syntax of kbuild-2.5 (or a subset).
> 
> But the makefile/makefile.in will remain: not all code
> in kernel is drivers, and for the non drivers makefile/config.in
> IMHO it is better to have 'central' (per directory/per type)
> config and makefile files.

yes and no :)

We do not want to limit one-driver one-file, just support it.

And, makefile information needs to be included along with config
information.  For a more realistic example, when I add a new net driver,
I would modify
drivers/net/new-driver.c
drivers/net/net-drivers.conf

and the second file includes the makefile rules necessary to build
things.

For directories like kernel/* and mm/* and arch/*, I imagine that down
the road we will want kernel.conf and mm.conf too, though right now they
would probably remain as makefiles...

If you look closely at the problem, you will see there is no fundamental
reason why we cannot package makefile rules like we want to package
config information.

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
