Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286224AbSAAI4I>; Tue, 1 Jan 2002 03:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287563AbSAAIzt>; Tue, 1 Jan 2002 03:55:49 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:43015 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S286224AbSAAIzp>; Tue, 1 Jan 2002 03:55:45 -0500
Date: Tue, 1 Jan 2002 02:55:40 -0600
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: State of the new config & build system
Message-ID: <20020101085540.GB1303@cadcamlab.org>
In-Reply-To: <20011227174723.V25698@work.bitmover.com> <19047.1009504678@ocs3.intra.ocs.com.au> <20011231200359.A22497@bluemug.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011231200359.A22497@bluemug.com>
User-Agent: Mutt/1.3.24i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Mike Touloumtzis]
> Why not use '$(GCC) -c -Wp,-MD,foo.d foo.c' to generate the
> dependencies as a side effect of the regular compile step?

As Keith said, kbuild 2.5 *does* use 'gcc -MD' - although the *current*
system does not.

Linus has said that he doesn't like -MD, and he has a point: it only
extracts dependencies for your *current* compile, which means they have
to be rebuilt if you change CONFIG options.  However, those CONFIG
options would cause rebuilding of the file *anyway*, and -MD is almost
free since the preprocessor already has to read the files in question,
so I'm not convinced that it's a big deal.

> The "build whole clean tree" case is a common one even among kernel
> developers, e.g. for compile-testing patches before resending them.

One of the main points of kbuild 2.5 is that, unlike the current
system, it tracks dependencies perfectly.  Thus you should almost never
have to run 'make clean' before test compiling something - unless you
need to see non-fatal compile warnings.

It may take some time to get used to the soon-to-be new reality of "ok,
so I just applied eight kernel patches from three different places but
I know I don't need to bother with 'make clean' because the dependency
system is just *that good*."

Peter
