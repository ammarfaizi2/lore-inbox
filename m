Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSGPLit>; Tue, 16 Jul 2002 07:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315779AbSGPLis>; Tue, 16 Jul 2002 07:38:48 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:23689 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S315611AbSGPLis>;
	Tue, 16 Jul 2002 07:38:48 -0400
Date: Tue, 16 Jul 2002 13:41:39 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020716134139.A7352@ucw.cz>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <agtl95$ihe$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <agtl95$ihe$1@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jul 15, 2002 at 05:06:45AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2002 at 05:06:45AM +0000, Linus Torvalds wrote:
> In article <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com>,
> Grover, Andrew <andrew.grover@intel.com> wrote:
> >
> >But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> >these been quantified?
> 
> I've never had good reason to believe the latency/perf benefits myself,
> but I was approached at OLS about problems with something as simple as
> DVD playing, where a 100Hz timer means that the DVD player ends up
> having to busy-loop on gettimeofday() because it cannot sanely sleep due
> to the lack in sufficient sleeping granularity.
> 
> You apparently end up visibly missing frames - a frame is just 3 timer
> ticks at 100 Hz, and considering that the kernel has to round up by one
> due to POSIX requirements _and_ considering that you lose roughly one
> for actually processing the frame itself, that doesn't sound _that_
> outlandish. 

Actually, this example is pretty much false I believe.

Since there is always the screen refresh rate going at say 85 Hz, you'll
be missing frames anyway.

The really correct solution would be to use the vertical blank
interrupt, which all recent cards provide, to wake the X process to tell
it that it should flip it's xvideo double-buffer (*), and to tell the
DVD player to supply another frame to it, which it would then preferably
DMA over AGP straight into the video card memory.

Now, if you wanted a real smooth video, you'd set your screen refresh
rate to 100 Hz in Europe and 120 Hz in US. (Without that it never can be
100% smooth anyway). And it also has the nice side effect of eliminating
the screen flicker caused by fluorescent lamp interference.

(*) If our interrupt-to-wake latency is too large for X to do the buffer
flip in the vblank, then we'll probably need some more kernel support
for that.

-- 
Vojtech Pavlik
SuSE Labs
