Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264110AbTE0UMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 16:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTE0UMH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 16:12:07 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:64666
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264057AbTE0UMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 16:12:06 -0400
Date: Tue, 27 May 2003 22:25:20 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527202520.GN3767@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305271952.34843.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva> <200305272004.02376.m.c.p@wolk-project.de> <20030527182547.GG3767@dualathlon.random> <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva> <20030527200339.GI3767@dualathlon.random> <Pine.LNX.4.55L.0305271707370.9487@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0305271707370.9487@freak.distro.conectiva>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 05:08:38PM -0300, Marcelo Tosatti wrote:
> 
> 
> On Tue, 27 May 2003, Andrea Arcangeli wrote:
> 
> > > It seems your "fix-pausing" patch is fixing a potential wakeup
> > > miss, right? (I looked quickly throught it). Could you explain me the
> >
> > yes, not just one but multiple of them, all similar. lots of boxes were
> > hanging in a weird manner until I found and fixed this glitch.
> >
> > > problem its trying to fix and how?
> >
> > I'm attaching the old email, it should have all the explanataions.
> >
> > but don't use that old patch (that was the first revision and it missed
> > one last race in wait_for_request noticed by Chris or Andrew [or
> > both?]), use this one instead (seems just the second revision, should be
> > that one plus that last race fix):
> >
> > 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21rc2aa1/9980_fix-pausing-2
> 
> I wonder if the additional wakeups result in performance degradation (not
> that it matters much in case there is no other way to fix the problem).

in theory yes.

> 
> But anyway I would like to have some numbers with/without the patch.
> 
> Do you have them ?

Hmm, in bigbox.html we should find the difference of the timings
before/after, and I recall it wasn't measurable. I can search for it on
Thu if you want the exact numbers.

However the last numbers from Randy showed my tree going faster than 2.5
with bonnie and tiotest so I think we don't need to worry and I would
probably not fix it in a different way in 2.4 even if it would mean a 1%
degradation. When it was shipped there was no time to measure any
degradation but the problem it fix is so severe that we never had any
doubt if to include it or not ;).

Andrea
