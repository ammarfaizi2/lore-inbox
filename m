Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262337AbTJAT5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 15:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262351AbTJAT5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 15:57:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:36067 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262337AbTJAT5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 15:57:50 -0400
X-Authenticated: #20450766
Date: Wed, 1 Oct 2003 21:47:43 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Reply-To: Guennadi Liakhovetski <g.liakhovetski@web.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: "David S. Miller" <davem@redhat.com>, <acme@conectiva.com.br>,
       <bunk@fs.tum.de>, <netdev@oss.sgi.com>, <pekkas@netcore.fi>,
       <lksctp-developers@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
In-Reply-To: <1064903505.6154.157.camel@imladris.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0310012112440.4364-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, David Woodhouse wrote:

> On Mon, 2003-09-29 at 22:17 -0700, David S. Miller wrote:
> > On Mon, 29 Sep 2003 10:02:55 +0100
> > David Woodhouse <dwmw2@infradead.org> wrote:
> >
> > > The underlying point being that your static kernel should not change if
> > > you change an option from 'n' to 'm'. It should only affect the kernel
> > > image if you change options to/from 'y'.
> >
> > I totally disagree, what ipv6 is doing is perfectly fine.
>
> Your right.

Well, maybe you are right, but I certainly liked the feature, that I could
just add a module to a currently running kernel's configuration, compile
and insmod it. But, if this is how it is (going to be) now - that one
shouldn't rely on this, do you agree, that such attempts should be stopped
by the build system? If so, I think, a script, trying to find possible
problems could be of help? It wouldn't be trivial, but maybe there's
already framework available, that can be taught to do this? Ideally, you
would want to check:
for each tristate CONFIG_ find from the respective Makefile(s) which
source (*.[Sc])-files are involved with obj-$(CONFIG_x). Find depending
source-files from "depends on x" in respective Kconfig recursively. If
CONFIG_x appears in any other source-files - it is already a (likely)
problem. Now headers. Well, if we want to check infinitely deep inclusions
- it would require a fat cluster / SMP, I guess:-) So, is there a piece of
software among all automatic checkers, that could be relatively easily
taught to do this and would it make sense to run such a check on each -pre
and -rc version?

Actually, is anybody checking for recursive includes?

Guennadi
---
Guennadi Liakhovetski


