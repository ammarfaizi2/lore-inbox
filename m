Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266466AbUFUWT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266466AbUFUWT1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266490AbUFUWT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:19:27 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:50316 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266466AbUFUWTZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:19:25 -0400
Date: Tue, 22 Jun 2004 00:31:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] kbuild updates
Message-ID: <20040621223108.GC2903@mars.ravnborg.org>
Mail-Followup-To: Andreas Gruenbacher <agruen@suse.de>,
	Martin Schlemmer <azarah@nosferatu.za.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <200406210026.43988.agruen@suse.de> <1087771141.14794.89.camel@nosferatu.lan> <200406210151.43325.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406210151.43325.agruen@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 01:51:43AM +0200, Andreas Gruenbacher wrote:
> > But my original concern (that the only way to figure where the source
> > are for the running kernel will be broken) is still valid.
> 
> User-space stuff that needs access to kernel headers at build time is a 
> problem. But for those programs, depending on the running kernel instead of 
> simply looking in /usr/src/linux is an even bigger problem: What guarantees 
> that the first time the program is run, the kernel will still be the same? So 
> depending on the running kernel is definitely wrong. Depending 
> on /usr/src/linux is also wrong; ideally those programs should look 
> in /usr/include/{linux,asm}. Unfortunately these headers are not always 
> recent enough, and so recently added definitions may be missing.

But Martin has a point here.
How to figure out for example the number of arguments to remap_page_range.
One could do some grepping in the mm.h file, or one could try to compile
a minimal module calling this function.
If we go for the simple version by grepping we need to figure out where
to find the source. In the past this was simple - just follow the
build symlink. But now kernels may be shipped with separate source
and output directory exposing the weakness of this method.
A much more reliable way is to build a simple module.
If the module build succeeds that specific version
of remap_page_range is OK.

nvidia does something similar, but they take the false assumption
that the running kernel is always the one being build for.
So they call gcc direct.

Other modules uses the grep method - which will fail when the kernel
is build with separate output and source directories.

> 
> > Makefile-pre_M_flag - 100% valid kbuild Makefile for kernels that
> >                       do not support M=
> >
> > Makefile-post_M_flag - 100% valid kbuild Makefile for kernels
> >                        supporting M=
> 
> Right now I would collapse the pre/post Makefiles and use SUBDIRS instead. 
> There is no easy and reliable test for M= support, and it's only cosmetic. 
> Sam will probably disagree.

SUBDIRS were kept for backward compatibility - and I realise it will stay
for a long time. The implementation were kept straightforward so no problem.

	Sam
