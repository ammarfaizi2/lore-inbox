Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTI3KCz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTI3KCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:02:55 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:52687 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261294AbTI3KCw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:02:52 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030930022410.08c5649c.davem@redhat.com>
References: <20030928225941.GW15338@fs.tum.de>
	 <20030928231842.GE1039@conectiva.com.br> <20030928232403.GX15338@fs.tum.de>
	 <20030929220916.19c9c90d.davem@redhat.com>
	 <1064903562.6154.160.camel@imladris.demon.co.uk>
	 <20030930000302.3e1bf8bb.davem@redhat.com>
	 <1064907572.21551.31.camel@hades.cambridge.redhat.com>
	 <20030930010855.095c2c35.davem@redhat.com>
	 <1064910398.21551.41.camel@hades.cambridge.redhat.com>
	 <20030930013025.697c786e.davem@redhat.com>
	 <1064911360.21551.49.camel@hades.cambridge.redhat.com>
	 <20030930015125.5de36d97.davem@redhat.com>
	 <1064913241.21551.69.camel@hades.cambridge.redhat.com>
	 <20030930022410.08c5649c.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1064916168.21551.105.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 11:02:49 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 02:24 -0700, David S. Miller wrote:
> I think they are the same.  It's module building depending upon the
> kernel image being up to date.
> 
> modules: vmlinux image
> 	... blah blah blah
> 
> or however you want to express it in the makefiles.

In the case of modversions, we are talking about the fact that it may be
physically _impossible_ to build a module referencing an in-kernel
symbol, if the checksum required for that symbol -- the 'version string'
-- is not yet calculated. If the version strings are generated as a
side-effect of compiling the files which actually export the symbols in
question, then it's necessary to do that before building any module
which attempts to use those symbols.

Note that it's not actually necessary to provide a vmlinux file, nor to
do any linking. It's only necessary to perform those steps which produce
the version strings for those symbols actually referenced by the modules
which are being built.

That is the requirement for correctness from the makefiles; nothing
more. Of course it's usually considered acceptable for the makefiles to
recompile _more_ than is necessary, so your way of expressing it above
could indeed be a first, extremely suboptimal, attempt at a 'fix' if the
build is indeed currently broken in the way that you suggest.

> I don't see how this changes the argument I'm trying to make.
> 
> I'm saying that either you accept that the kernel image must be
> uptodate in order to build modules, or you don't.  It doesn't matter
> what creates that dependency.

I agree with your assertion -- it is true that I either accept that fact
or I don't. 

Furthermore, I agree that if it is physically necessary for the kernel
image to be up to date in order to build modules, then it would be a bug
for the build system not to do so. 

That is all irrelevant to the question which started this thread though.
That would be correctly stated as follows:

I am saying that even if I run 'make all', I do not accept that the
resulting kernel image should be _different_ when I change any option
from 'n' to 'm'.

-- 
dwmw2

