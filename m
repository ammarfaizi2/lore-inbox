Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbULYCiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbULYCiV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 21:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbULYCiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 21:38:21 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:63680 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261475AbULYCiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 21:38:19 -0500
Date: Sat, 25 Dec 2004 03:37:35 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: VM fixes [4/4]
Message-ID: <20041225023735.GS13747@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <20041225000605.GB30430@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041225000605.GB30430@gaz.sfgoth.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2004 at 04:06:05PM -0800, Mitchell Blank Jr wrote:
> Andrea Arcangeli wrote:
> > > Again, older Alpha's do not.
> > 
> > If those old cpus really supported smp in linux,
> 
> The question isn't whether those CPUs support SMP; the question is whether
> it's possible to build a kernel that supports both SMP boxes and older
> CPUs.

If you want to support those, you must as well tell gcc with a special
flag to never do byte access. I doubt it'd be a good idea to ship a
single kernel that runs on both those ancient cpus and on the more
recent ones too.

The race was mostly theoretical even for alpha, the current PF_MEMDIE
race in mainline triggering in all x86 and all other actual
architectures, is more likely to trigger infact and it has a huge
priority compared to the alpha ev4 SMP race.

But I'm going to fix the ev4 SMP alpha cpus soon by following Linus's
suggestion to reuse the bitflag arrays we already allocated for similar
stuff.
