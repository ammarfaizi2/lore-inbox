Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSKBTUJ>; Sat, 2 Nov 2002 14:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261318AbSKBTUI>; Sat, 2 Nov 2002 14:20:08 -0500
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:17683 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id <S261307AbSKBTUG>; Sat, 2 Nov 2002 14:20:06 -0500
Date: Sat, 2 Nov 2002 20:26:31 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Erik Andersen <andersen@codepoet.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Where's the documentation for Kconfig?
In-Reply-To: <20021102135109.GA6321@codepoet.org>
Message-ID: <Pine.LNX.4.44.0211021913260.6949-100000@serv>
References: <20021031134308.I27461@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0210311452531.13258-100000@serv> <20021102135109.GA6321@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Nov 2002, Erik Andersen wrote:

> On Thu Oct 31, 2002 at 03:43:26PM +0100, Roman Zippel wrote:
> > kconfig:
> > config /symbol/
> > 	bool /prompt/
> > 	default /word/
> 
> Suppose at some time we wished to move things like architecture
> specific CFLAGS into Kconfig.  It would be implemented as a
> "string" object and would look something like:
> 
> config CPU_CFLAGS
>         string
>         default "-march=i386" if M386
>         default "-march=i486" if M486
>         default "-march=i586" if M586
>         default "-march=i686 -malign-functions=4" if MK7

It's possible, but I don't think we will start in the arch part. More 
interesting would be driver entries like:

driver foo
	tristate "foo support"
	depends on BAR
	source foo.c

part of this could also be:

	cflags "..." [if ...]


> So for the K7 case, we could expand it to something much more
> sneaky later on, something like:
>     default "$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)" if MK7
> and the check_gcc macro could be correctly evaluated by make.
> Neat stuff.  (Such a check_gcc macro does not yet exist in the 
> kernel Makefiles, but surely will sometime).

Having make specific macros in the configuration is not really a good 
idea. Such tests should rather be done by a shell script and its output 
would be imported into the build system.

bye, Roman

