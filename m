Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265903AbUFOTrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265903AbUFOTrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 15:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265891AbUFOTrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 15:47:09 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:27156 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265890AbUFOTq3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 15:46:29 -0400
Date: Tue, 15 Jun 2004 21:55:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jari Ruusu <jariruusu@users.sourceforge.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] kbuild: external module build doc
Message-ID: <20040615195542.GE2310@mars.ravnborg.org>
Mail-Followup-To: Jari Ruusu <jariruusu@users.sourceforge.net>,
	Sam Ravnborg <sam@ravnborg.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204809.GF15243@mars.ravnborg.org> <40CF4C48.5A317311@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40CF4C48.5A317311@users.sourceforge.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 10:21:44PM +0300, Jari Ruusu wrote:
> Sam Ravnborg wrote:
> > --- /dev/null   Wed Dec 31 16:00:00 196900
> > +++ b/Documentation/kbuild/extmodules.txt       2004-06-14 22:25:21 +02:00
> [snip]
> > +A more advanced example
> > +- - - - - - - - - - - -
> > +This example shows a setup where a distribution has wisely decided
> > +to separate kernel source and output files:
> > +
> > +Kernel src:
> > +/usr/src/linux-<kernel-version>/
> > +
> > +Output from a kernel compile, including .config:
> > +/lib/modules/linux-<kernel-version>/build/
>                                        ^^^^^
> Wrong! The 'build' symlink has always pointed to kernel source dir in
> separate source and object directory case.

This document was written before Andreas posted his patch - I just never
came around updating it.
                                                            ^^^^^^
> Sam, You don't seem to have any idea how much breakage you introduce if you
> insist on redirecting the 'build' symlink from source tree to object tree.

No - and I still do not see it. Please explain how we can be backward
compatible when vendors start utilising separate directories for src and output.

Anyway, after I gave it some extra thoughs I concluded that
/lib/modules/kernel-<version>/ was the wrong place to keep
info about where to src for a given build is located.
This information has to stay in the output directory.

So what I will implement is that during the kernel build process
(not the install part) a symlink named 'source' is placed
in the root of the output directory - and links to the root of
the kernel src used for building the kernel.

Then /lib/modules/kernel-<version>/build/source will be where
the source is located.
And /lib/modules/kernel-<version>/build will point to the output files.

If the vendor does not utilise separate src and output directories
they will point to the same directory.
If the vendor utilises separate output and source directories
then thay will point in two different places.

Comments?

	Sam
