Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265970AbUFTWYo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265970AbUFTWYo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUFTWYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 18:24:44 -0400
Received: from cantor.suse.de ([195.135.220.2]:6813 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265970AbUFTWYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 18:24:36 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [PATCH 0/2] kbuild updates
Date: Mon, 21 Jun 2004 00:26:43 +0200
User-Agent: KMail/1.6.2
Cc: arjanv@redhat.com, Sam Ravnborg <sam@ravnborg.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>
References: <20040620211905.GA10189@mars.ravnborg.org> <1087767752.2805.18.camel@laptop.fenrus.com> <1087768362.14794.53.camel@nosferatu.lan>
In-Reply-To: <1087768362.14794.53.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200406210026.43988.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 June 2004 23:52, Martin Schlemmer wrote:
> On Sun, 2004-06-20 at 23:42, Arjan van de Ven wrote:
> > > Given, but to 'use' the kbuild infrastructure, you must still call it
> > > via:
> > >
> > >   make -C _path_to_sources M=`pwd`
> >
> > I see no problem with requiring this though; requiring a correct
> > makefile is perfectly fine with me, and this is the only and documented
> > way for 2.6 already.
> > (And it's also the only way to build modules against Fedora Core 2
> > kernels by the way)
>
> I did not mean I have a problem with that.  Say you take svgalib, and
> you want the build system to automatically compile the kernel module,
> you might do something like:
>
> ---
> build_2_6_module:
> 	@make -C /lib/modules/`uname -r`/build M=`PWD`
> ---
>
> will break with proposed patch ...

No it won't.

You always need to figure out $(objtree) to build external modules, with or 
without a separate output directory. Many modules don't need to know 
$(srctree) explicitly at all.

In case you want to do something depending on the sources/confguration, there 
are two ways:
  - follow the new source symlink,
  - let kbuild take you to $(srctree): When the makefile in the M directory
    is included, the current working directory is $(srctree). besides, all the
    usual variables like $(srctree), $(objtree), CONFIG_* variables, etc. are
    all available. That's a good time to check for features, etc.

> And the point I wanted to make was that AFIAK
> '/lib/modules/`uname -r`/build' is an interface to figure
> out where the _sources_ for the current running kernel are
> located.

That's a misconception. At the minimum, you want to be able to build the 
module. Directly messing with the sources is usually wrong. I know external 
module authors like to do that nevertheless; in a few cases it's actually 
useful. Most of the time it really is not. Most external modules have totally 
braindead/broken makefiles.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
