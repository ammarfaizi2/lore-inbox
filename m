Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbTE2QJK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTE2QJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 12:09:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:20403
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262371AbTE2QJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 12:09:04 -0400
Date: Thu, 29 May 2003 18:22:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>, axboe@suse.de, m.c.p@wolk-project.de,
       kernel@kolivas.org, manish@storadinc.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030529162245.GP1453@dualathlon.random>
References: <200305281713.24357.kernel@kolivas.org> <20030528071355.GO845@suse.de> <200305280930.48810.m.c.p@wolk-project.de> <20030528073544.GR845@suse.de> <20030528005156.1fda5710.akpm@digeo.com> <20030528101348.GA804@rz.uni-karlsruhe.de> <20030528032315.679e77b0.akpm@digeo.com> <20030528121040.GA1193@rz.uni-karlsruhe.de> <20030529131937.GJ1453@dualathlon.random> <20030529141034.GA1547@rz.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529141034.GA1547@rz.uni-karlsruhe.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 29, 2003 at 04:10:34PM +0200, Matthias Mueller wrote:
> On Thu, May 29, 2003 at 03:19:37PM +0200, Andrea Arcangeli wrote:
> > On Wed, May 28, 2003 at 02:10:40PM +0200, Matthias Mueller wrote:
> > > Tested all of them and some combinations:
> > > patch 1 alone: still mouse hangs
> > > patch 2 alone: still mouse hangs
> > > patch 3 alone: no hangs, but I get some zombie process (starting a lot of
> > >                xterms results in zombie xterms, not noticed with vanilla
> > >                and the other patches)
> > > patch 1+2: no mouse hangs
> > > patch 1+2+3: no mouse hangs, no zombies
> > 
> > I can't find a sense in the zombie thing, how can you generate zombie at
> > all from xterms? That sounds like your userspace is terribly broken and
> > it may have race conditions or whatever. In no way those patches can
> > generate or not-generate zombies from xterms. I never ever seen a zombie
> > xterm in my whole linux experience.
> 
> I rechecked everything an noticed, that it wasn't a xterm, but a wrapper
> script, that executed rxvt. I changed that to plain xterm and the zombies
> were gone. So I think there was probably a bug in rxvt triggered there.
> After that I redid the tests, with the same result (and no zombies).
> I can feel no difference between 1+2 or 1+2+3.

this sounds very sane now thanks for fixing the issues with the zombies!

it also makes sense to me that 1+2 is the same as 1+2+3, because I'd be
very surprised if the (purely smp) race condition in 3 made a whole lot
of difference for interactivity of a large write.

Andrea
