Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbVGVQfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbVGVQfu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 12:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVGVQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 12:35:50 -0400
Received: from coriana6.CIS.McMaster.CA ([130.113.128.17]:55718 "EHLO
	coriana6.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S262111AbVGVQfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 12:35:48 -0400
Date: Fri, 22 Jul 2005 12:35:32 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
       <ckrm-tech@lists.sourceforge.net>
Subject: Re: 2.6.13-rc3-mm1 (ckrm) 
In-Reply-To: <E1DvzoN-0007Dg-00@w-gerrit.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0507221216090.25001-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.7.22.16
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > the fast path slower and less maintainable.  if you are really concerned
> > > about isolating many competing servers on a single piece of hardware, then
> > > run separate virtualized environments, each with its own user-space.
> > 
> > And the virtualisation layer has to do the same job with less
> > information. That to me implies that the virtualisation case is likely
> > to be materially less efficient, its just the inefficiency you are
> > worried about is hidden in a different pieces of code.

I imagine you, like me, are currently sitting in the Xen talk,
and I don't believe they are or will do anything so dumb as to throw away
or lose information.  yes, in principle, the logic will need to be 
somewhere, and I'm suggesting that the virtualization logic should
be in VMM-only code so it has literally zero effect on host-native 
processes.  *or* the host-native fast-path.

> > Secondly a lot of this doesnt matter if CKRM=n compiles to no code
> > anyway
> 
> I'm actually trying to keep the impact of CKRM=y to near-zero, ergo
> only an impact if you create classes.  And even then, the goal is to
> keep that impact pretty small as well.

but to really do CKRM, you are going to want quite extensive interaction with
the scheduler, VM page replacement policies, etc.  all incredibly
performance-sensitive areas.

actually, let me also say that CKRM is on a continuum that includes 
current (global) /proc tuning for various subsystems, ulimits, and 
at the other end, Xen/VMM's.  it's conceivable that CKRM could wind up
being useful and fast enough to subsume the current global and per-proc
tunables.  after all, there are MANY places where the kernel tries to 
maintain some sort of context to allow it to tune/throttle/readahead
based on some process-linked context.  "embracing and extending"
those could make CKRM attractive to people outside the mainframe market.


> Plus you won't have to manage each operating system instance which
> can grow into a pain under virtualization.  But I still maintain that
> both have their place.

CKRM may have its place in an externally-maintained patch ;)

regards, mark hahn.

