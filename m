Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265130AbUFVSXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265130AbUFVSXy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265146AbUFVSX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:23:27 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:58269 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S265283AbUFVSVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 14:21:53 -0400
Message-ID: <40D87913.984D9F5B@users.sourceforge.net>
Date: Tue, 22 Jun 2004 21:23:15 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
References: <20040620211905.GA10189@mars.ravnborg.org> <20040620221824.GA10586@mars.ravnborg.org> <40D7C3D3.30DB5F72@users.sourceforge.net> <200406221120.18088.agruen@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> On Tuesday 22 June 2004 07:29, Jari Ruusu wrote:
> > Sam Ravnborg wrote:
> > > Now I recall why I did not like the object directory.
> > > I will break all modules using the kbuild infrastructure!
> >
> > No it does not. If 'export KBUILD_OUTPUT=/foo' command is used before
> > kernel is built, it is not any more difficult to compile external modules
> > with that same env variable defined.
> 
> This clearly is not an option. We want the most trivial way of building
> external modules to continue working, no matter whether the kernel is using a
> separate output directory or not; with Sam's patch we get that:
> 
>         make -C /lib/modules/$(uname -r)/build M=$(pwd)

Kernel already does that correctly, and follows KBUILD_OUTPUT env variable
that points to where user wants the object tree. No changes needed to
external module build scripts.

Maybe you SUSE guys just didn't realize that.
 
> We also want to build modules for other configurations; this is as simple as
> passing another path in -C. For example, in the SUSE setup this would give
> you a module for an i386 bigsmp kernel:
> 
>         make -C /usr/scc/linux-obj/i386/bigsmp M=$(pwd)

This is cool and desirable, but does not need or even justify
breaking/redirecting the 'build' symlink elsewhere.

> The environment variable proposal is worthless:

It is not a proposal. It has been in mainline since 2.5.x kernels and last
time I checked, it worked fine.

> Where on earth should that environment variable come from?

The person compiling kernel decides where he wants the object tree. He only
needs to set that once, before builing a kernel with separate object and
source trees. And same env variable works just fine when used with
externally compiled modules.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
