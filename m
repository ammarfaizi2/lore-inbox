Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264096AbTE0SWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTE0SWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:22:07 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40596 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264096AbTE0SWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:22:01 -0400
Date: Tue, 27 May 2003 15:33:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <20030527182547.GG3767@dualathlon.random>
Message-ID: <Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com> <200305271952.34843.m.c.p@wolk-project.de>
 <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
 <200305272004.02376.m.c.p@wolk-project.de> <20030527182547.GG3767@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

u

On Tue, 27 May 2003, Andrea Arcangeli wrote:

> On Tue, May 27, 2003 at 08:08:43PM +0200, Marc-Christian Petersen wrote:
> > On Tuesday 27 May 2003 19:57, Marcelo Tosatti wrote:
> >
> > Hi Marcelo,
> >
> > > > I do, people I know do also, numbers of those people only _I_ know are
> > > > about ~30. I've reported this problem over a year ago while 2.4.19-pre
> > > > time.
> > > Can you please try to reproduce it with -aa?
> > not again ;)
> >
> > I've tried almost all known kernel tree's around, every kernel has the same
> > effect. I even tried SuSE and Redhat Kernels.
> >
> > I've 'wasted' tons of time just find a solution for it.
> >
> > Andrea introduced, to address _exact_ this problem (pauses, stops, mouse is
> > dead etc.), his lowlatency elevator. Side effect: decreases i/o throughput,
>
> not exactly decreases I/O throughput, the latest I/O benchmarks I seen
> from Randy (dbench/tiotest/bonnie/etc..) were still the fastest and it
> included the lowlatency elevator patch. So it may not help latency but
> it doesn't hurt in the numbers, at least not in the high end (that in
> theory is the one that needs the overkill length in the I/O queue most).
>
> However it definitely helps latency for me and I had a number of
> positive reports.
>
> Also make sure that you elvtune -r 0 -w 0 /dev/hda, also the journaling
> may affect the latency so you can try with plain ext2 to be sure it's
> not a fs issue.
>
> the lowlatency elevator patch may not be perfect but it definitely seems
> to work better here. especially since there's no apparent throughput
> loss, it makes lots of sense to keep it applied, or it would waste lots
> of ram for apparently no gain.

Andrea,

It seems your "fix-pausing" patch is fixing a potential wakeup
miss, right? (I looked quickly throught it). Could you explain me the
problem its trying to fix and how?

Its too late to fix that in 2.4.21 (rc5 is going out in hours).
