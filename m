Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbTI3JOO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 05:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTI3JOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 05:14:14 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:48078 "EHLO
	executor.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S261231AbTI3JOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 05:14:08 -0400
Subject: Re: RFC: [2.6 patch] disallow modular IPv6
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, netdev@oss.sgi.com,
       pekkas@netcore.fi, lksctp-developers@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030930015125.5de36d97.davem@redhat.com>
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
Content-Type: text/plain; charset=UTF-8
Message-Id: <1064913241.21551.69.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Tue, 30 Sep 2003 10:14:02 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-09-30 at 01:51 -0700, David S. Miller wrote:
> So it's OK for modversions to make modules depend upon the main kernel
> image, but it's not OK for ipv6 to do the same exact thing.  Is this
> what you're saying?

Not at all. You're talking about something entirely different.

We are not talking about _changing_ the value of $CONFIG_MODVERSIONS.

CONFIG_MODVERSIONS is a boolean option, and of _course_ changing it from
'n' to 'y' should change the core kernel.

Your 'dependency on modversions' is entirely unrelated to any changes in
.config. 

In the 2.4 kernel you needed to run 'make dep', which had the
side-effect of creating all the version strings which were required to
make any modules. 

In the 2.6 kernel, I suspect that these same version strings are now
produced as a side-effect of the 'make vmlinux' stage, and hence that
it's required to 'make vmlinux' before any modules can be built.

This (potential) dependency is entirely unrelated to any _changes_ in
configuration. It would be optimal to be able to build modules _without_
actually having to build the kernel image, but if that dependency exists
due to the current build mechanism, then it would be a bug for 'make
modules' to refrain from also building vmlinux.

It was offered as an example of a case in which your assertion would be
correct; that 'make modules' should also rebuild vmlinux. I'm sorry if
it caused confusion -- I should probably not have followed your
digression.

> > If there's no actual dependency on the core kernel image, however, then
> > it should not be rebuilt for 'make modules'. If 'make modules' was
> > equivalent to 'make all' then it should not exist at all.
> 
> I don't see how you can say that modversions can create this module
> dependency upon the kernel image, but ipv6 is not allowed to.

There is no inconsistency. It's very simple:

 ∃ configuration option CONFIG_xxx :
Changing CONFIG_xxx from 'n' to 'y' may change the resulting vmlinux.
Changing CONFIG_xxx from 'n' to 'm' should not do so.



-- 
dwmw2

