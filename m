Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263996AbTE0SN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTE0SNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 14:13:00 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:56209
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264050AbTE0SMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 14:12:43 -0400
Date: Tue, 27 May 2003 20:25:52 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527182547.GG3767@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305271952.34843.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva> <200305272004.02376.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272004.02376.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 08:08:43PM +0200, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 19:57, Marcelo Tosatti wrote:
> 
> Hi Marcelo,
> 
> > > I do, people I know do also, numbers of those people only _I_ know are
> > > about ~30. I've reported this problem over a year ago while 2.4.19-pre
> > > time.
> > Can you please try to reproduce it with -aa?
> not again ;)
> 
> I've tried almost all known kernel tree's around, every kernel has the same 
> effect. I even tried SuSE and Redhat Kernels.
> 
> I've 'wasted' tons of time just find a solution for it.
> 
> Andrea introduced, to address _exact_ this problem (pauses, stops, mouse is 
> dead etc.), his lowlatency elevator. Side effect: decreases i/o throughput, 

not exactly decreases I/O throughput, the latest I/O benchmarks I seen
from Randy (dbench/tiotest/bonnie/etc..) were still the fastest and it
included the lowlatency elevator patch. So it may not help latency but
it doesn't hurt in the numbers, at least not in the high end (that in
theory is the one that needs the overkill length in the I/O queue most).

However it definitely helps latency for me and I had a number of
positive reports.

Also make sure that you elvtune -r 0 -w 0 /dev/hda, also the journaling
may affect the latency so you can try with plain ext2 to be sure it's
not a fs issue.

the lowlatency elevator patch may not be perfect but it definitely seems
to work better here. especially since there's no apparent throughput
loss, it makes lots of sense to keep it applied, or it would waste lots
of ram for apparently no gain.

> and the "pauses/stops" are still there. Much less but not gone.
> 
> The _only_ workaround yet (known to the public) is to change nr_requests in 
> drivers/block/ll_rw_blk.c from 128 to 4 which gives a performance hit of 
> about 40% (not acceptable in any way).
> 
> .oO( I am quite sure I've mailed you all this stuff privately in response to 
>       your private mail to me ;) )Oo.
> 
> ciao, Marc
> 


Andrea
