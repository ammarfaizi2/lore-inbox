Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbTE0T7O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264106AbTE0T6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:58:02 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:50842
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264104AbTE0T5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:57:16 -0400
Date: Tue, 27 May 2003 22:10:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       manish <manish@storadinc.com>,
       Christian Klose <christian.klose@freenet.de>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-ID: <20030527201028.GJ3767@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com> <200305272004.02376.m.c.p@wolk-project.de> <20030527182547.GG3767@dualathlon.random> <200305272032.03645.m.c.p@wolk-project.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305272032.03645.m.c.p@wolk-project.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 27, 2003 at 08:35:33PM +0200, Marc-Christian Petersen wrote:
> On Tuesday 27 May 2003 20:25, Andrea Arcangeli wrote:
> 
> Hi Andrea,
> 
> > not exactly decreases I/O throughput, the latest I/O benchmarks I seen
> it decreases performance. I've seen this, Con also saw this (well it's better 
> than the 'nr_requests = 4' change ;) but mouse stops are still there.
> 
> > from Randy (dbench/tiotest/bonnie/etc..) were still the fastest and it
> > included the lowlatency elevator patch. So it may not help latency but
> > it doesn't hurt in the numbers, at least not in the high end (that in
> > theory is the one that needs the overkill length in the I/O queue most).
> I agree with the last sentence, in theory, but practice showed something 
> different (about 10% to 15% performance decrease)
> 
> But I am quite sure that this depends on your machine/hardware. Using IDE 
> instead of SCSI for example.

10/15 performance drop doesn't sound good, no matter what hardware ;).

However in contest I recall there was quite an improvement in latency at
least (I mean, it had some positive effect too)

Getting the best throughput and latency at the same time is normally not
possible, however evaluating if it's losing excessive throughput given a
certain latency improvement is difficult.


> 
> > However it definitely helps latency for me and I had a number of
> > positive reports.
> It helps but it's not as good as 2.4.18 stock.

I'll try to find what's the precise reason of the interactivity drop
with the 2.4.18->2.4.19 blkdev changes on Thu. I think I shortly looked
into it once but there was no definitive answer, or anyways going back
to the 2.4.18 code didn't appeal or make much sense.

However I suspect this responsiveness issue could be storage hardware
dependent.

The sentence by Linus in the last few days while talking with Jens,
about storage that reorders stuff and starve requests at the two ends of
the platter was very scary, maybe you're really bitten by something like
that. Linux does the right thing but your hardware keeps posting stuff
under the os and mine doesn't.


> 
> > Also make sure that you elvtune -r 0 -w 0 /dev/hda, also the journaling
> I also tried that.
> 
> > may affect the latency so you can try with plain ext2 to be sure it's
> > not a fs issue.
> Sure, I did this too. FS independent, where ReiserFS is still the best for 
> this scenario with the most few pauses than any other FS (ext2, ext3, ...)
> 
> But for desktop usage: not acceptable! No way, No go!
> 
> > the lowlatency elevator patch may not be perfect but it definitely seems
> > to work better here. especially since there's no apparent throughput
> > loss, it makes lots of sense to keep it applied, or it would waste lots
> > of ram for apparently no gain.
> hehe, well wasting RAM for no gain is my next part on my todo ;) (cache 
> everything even if there is no RAM for example, well but this is not the 
> point in this thread)
> 
> ciao, Marc
> 


Andrea
