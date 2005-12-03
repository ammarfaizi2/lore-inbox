Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVLCPjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVLCPjr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 10:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVLCPjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 10:39:47 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:7107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751270AbVLCPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 10:39:46 -0500
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
From: Arjan van de Ven <arjan@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203152339.GK31395@stusta.de>
References: <20051203135608.GJ31395@stusta.de>
	 <1133620598.22170.14.camel@laptopd505.fenrus.org>
	 <20051203152339.GK31395@stusta.de>
Content-Type: text/plain
Date: Sat, 03 Dec 2005 16:39:43 +0100
Message-Id: <1133624383.22170.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > this is a contradiction. You can't eat a cake and have it; either you're
> > really low churn (like existing -stable) or you start adding new
> > features like hardware support. the problem with hardware support is
> > that it's not just a tiny driver update. If involves midlayer updates as
> > well usually, and especially if those midlayers diverge between your
> > stable and mainline, the "backports" are getting increasingly unsafe and
> > hard.
> 
> In the beginning, backporting hardware support is relatively easy, and 
> therefore cherry-picking from mainline 2.6 should be relatively safe.

and then there's reality. At least in my experience as distro kernel
maintainer... you can do this for a few months, but it gets
exponentially more expensive after 4 to 5 months. And "safe" is just not
true. API, midlayer and locking changes in the newer kernels just void
that concept entirely. And then there's the testing dillema; the people
who'd run such a branch are EXACTLY the ones who wouldn't test
prereleases of such branch (and yes 2.4 suffers from this as well). 

I doubt many distros would go for it as well for longer than a few
months, simply because the hardware support and other features are going
to be needed for them.


> Things will change as time passes by, but then there's the possibility 
> to open the next branch and bring the older branch into a security-fixes 
> only mode.

if you end up with 5 such branches it's no longer fun, trust me on that.
Especially if the security fix is in a tricky area or a high flux area,
then it's just not a matter of a simple backport anymore, even knowing
if you're vulnerable or not is going to be a pain. And then there are
the holes that happened to have gone away by later changes... what are
you going to do then... put those changes in? that won't work longer
term.

> 
> > If the current model doesn't work as you claim it doesn't, then maybe
> > the model needs finetuning. Right now the biggest pain is the userland
> > ABI changes that need new packages; sometimes (often) for no real hard
> > reason. Maybe we should just stop doing those bits, they're not in any
> > fundamental way blocking general progress (sure there's some code bloat
> > due to it, but I guess we'll just have to live with that).
> 
> IOW, we should e.g. ensure that today's udev will still work flawlessly 
> with kernel 2.6.30 (sic)?

I'd say yes. It doesn't need to support all new functionality, but at
least what it does today it should be able to do then. If that really
isn't possible maybe udev should be part of the kernel build and per
kernel version.


> This could work, but it should be officially announced that e.g. a 
> userspace running kernel 2.6.15 must work flawlessly with _any_ future 
> 2.6 kernel.

I would argue that this in theory already is the current policy. Now
"any" is pretty wide, but still. Maybe any such changes need to be
scheduled to specific kernel releases only. Eg only do it every 4th or
5th kernel release.



