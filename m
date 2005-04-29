Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263035AbVD2Wdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263035AbVD2Wdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 18:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVD2Wb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 18:31:56 -0400
Received: from av2.karneval.cz ([81.27.192.108]:28974 "EHLO av2.karneval.cz")
	by vger.kernel.org with ESMTP id S263035AbVD2WbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 18:31:13 -0400
From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
To: Russell King <rmk+lkml@arm.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] preserve ARCH and CROSS_COMPILE in the build directory generated Makefile
Date: Sat, 30 Apr 2005 00:32:13 +0200
User-Agent: KMail/1.8
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200504291335.34210.pisa@cmp.felk.cvut.cz> <20050429210053.GC8699@mars.ravnborg.org> <20050429224212.G30010@flint.arm.linux.org.uk>
In-Reply-To: <20050429224212.G30010@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504300032.13764.pisa@cmp.felk.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 29 April 2005 23:42, Russell King wrote:
> On Fri, Apr 29, 2005 at 11:00:53PM +0200, Sam Ravnborg wrote:
> > On Fri, Apr 29, 2005 at 01:35:33PM +0200, Pavel Pisa wrote:
> > > This patch ensures, that architecture and target cross-tools prefix
> > > is preserved in the Makefile generated in the build directory for
> > > out of source tree kernel compilation. This prevents accidental
> > > screwing of configuration and builds for the case, that make without
> > > full architecture specific options is invoked in the build
> > > directory. It is secure use accustomed "make", "make xconfig",
> > > etc. without fear and special care now.
> >
> > Hi Pavel.
> > I will not apply this path because it introduce a difference when
> > building usign a separate output direcory compared to an in-tree build.
> >
> > I have briefly looked into a solution where I could add this information
> > in .config but was sidetracked by other stuff so I newer got it working.
> >
> > The build system for the kernel needs to be as predictable as possible
> > and introducing functionality that is only valid when using a separate
> > output directory does not help here.

> Without it, folk will then do (and this is taken from someone elses
> example):

> which I think you'll agree is far worse.

Hello Sam and Russell,

thanks, Russell, for defending me through pointing me
as an bad example :-) .

Excuse me for that outcome of my two neurons scratch,
but I have decided to send my ideas for discussion
and possibly to help others. The decision,
what is good thing to do now and what should
be left in air for future better decisions
is on you. Thanks for energy put into reading
and thinking about my ideas.

I provide another idea, which is not dependant
on out of source tree build

ifeq ("$(origin ARCH)", "command line")
prepare1: archpreserve

archpreserve:
	echo "ARCH ?= $(ARCH)" >$(objtree)/.archconfig
	echo "CROSS_COMPILE ?= $(CROSS_COMPILE)" >>$(objtree)/.archconfig
else
-include $(objtree)/.archconfig
endif

With wish of sunny weekend 

                Pavel
