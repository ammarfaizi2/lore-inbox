Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbTE2NFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 09:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbTE2NFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 09:05:55 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:49832
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262211AbTE2NFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 09:05:54 -0400
Date: Thu, 29 May 2003 15:19:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>, axboe@suse.de, m.c.p@wolk-project.de,
       kernel@kolivas.org, manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529131937.GJ1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de> <200305280930.48810.m.c.p@wolk-project.de> <20030528073544.GR845@suse.de> <20030528005156.1fda5710.akpm@digeo.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <20030528121040.GA1193@rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030528121040.GA1193@rz.uni-karlsruhe.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 28, 2003 at 02:10:40PM +0200, Matthias Mueller wrote:
> Tested all of them and some combinations:
> patch 1 alone: still mouse hangs
> patch 2 alone: still mouse hangs
> patch 3 alone: no hangs, but I get some zombie process (starting a lot of
>                xterms results in zombie xterms, not noticed with vanilla
>                and the other patches)
> patch 1+2: no mouse hangs
> patch 1+2+3: no mouse hangs, no zombies

I can't find a sense in the zombie thing, how can you generate zombie at
all from xterms? That sounds like your userspace is terribly broken and
it may have race conditions or whatever. In no way those patches can
generate or not-generate zombies from xterms. I never ever seen a zombie
xterm in my whole linux experience.

either that or the GUI is doing something intentionally to try to reduce
the number of wait4 syscalls to the miniumum colescing the wait4, but
that would be very bad design of the GUI software since you're not going
to start an xterm (or whatever else window) a every millisecond, so it
would be very pointless and confusing, I certainly wouldn't like it.
(the wait4 thing I don't love it even in the servers where it might
be accepted as a microoptimization)

It's impossible to trust the rest of the report while hearing about such
a fundamental brekage in the core of your GUI, the mouse hangs could be
just an userspace bug that triggers when some timing changes in presence
of writes, or whatever. So please install an userspace that never
generates zombie xterm ever, and see if you can reproduce still.

Andrea
