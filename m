Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270135AbRHGHz2>; Tue, 7 Aug 2001 03:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270136AbRHGHzS>; Tue, 7 Aug 2001 03:55:18 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:36330 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S270135AbRHGHzC>; Tue, 7 Aug 2001 03:55:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Paul Flinders <ptf@ftel.co.uk>, lm@bitmover.com
Subject: Re: SIS 630E perf problems?
Date: Mon, 6 Aug 2001 18:52:39 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200108061713.f76HDaj16575@work.bitmover.com> <3B6F14E2.3030209@ftel.co.uk>
In-Reply-To: <3B6F14E2.3030209@ftel.co.uk>
MIME-Version: 1.0
Message-Id: <01080618523906.04153@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 August 2001 18:06, Paul Flinders wrote:
> Larry McVoy wrote:
> >I use bookpcs - all in one, really nice form factor - for build machines,
> >firewalls (with a USB ethernet), etc.  I used the first generation which
> >had intel i810 graphics (sucked) but had fairly typical performance,
> >competitive for kernel builds with other current platforms at the time.
> >
> >I recently bought a couple of the second generation of these boxes, these
> >have an SIS 630E based motherboard.  This has a much better graphics
> > interface, quite reasonable at 1280x1024, and all the other bits work
> > fine under RH 7.1 without tweaking.
> >
> >Performance sucks, however.  I did an LMbench run to try and figure out
> > why and it's obvious - the memory latencies are 430 ns - that's 2x more
> > than what is reasonable.  I tweaked the various bios settings a bit and
> > could not get it to change much, maybe 20ns but not the 200ns I was
> > looking for. The fact that this system is running a celeron with a dinky
> > cache makes it feel really slow.  These boxes with a 633Mhz celeron feel
> > slower than the old boxes with a 400Mhz celeron.
>
> If there is a problem it appears to be OS, and even processor independent.
>
> I have one of these and had made essentially the same observation as Larry
> - that memory bandwidth seems extremely poor.
>
> Larry's mail prompted me to have another look so I installed Win 2k and
> ran the Sandra benchmarks - which came up with a memory bandwidth of
> 130MB/s, about 1/3 of it's reference value for a SiS 630S.
>
> Disk throughput was poor as well, about 8MB/s for a 10G 5400 Seagate
> running in Ultra DMA 66. Presumably this is secondary to the lousy memory
> bandwidth and (?) points to a bottleneck between chipset & RAM
>
> Mine has a 667Mhz Citrix (Samual I core) and normally runs RH 7.1,
>
> Does anybody else have one?

I've used a few funky SIS chipsets, on and off, for a long time now, and they 
always have one leeeetle problem...

Try benchmarking it with a lower screen resolution (like 640x480x256 colors). 
 If the video is sharing main memory, it's sharing the memory bandwidth as 
well.  So you've basically got a constant ultra-high-priority DMA going to 
the screen, sucking up bandwidth and fighting with everything else.  
(Everything else MUST lose or the display would sparkle.  
1280x1024x32bitsx70hz is HOW much bandwidth we're talking here?)

The resulting leftover main memory bandwidth is going to SUCK.  Badly.  And 
the higher your resolution, the worse it gets.

The only possible excuse for it is that it's really really cheap to do, and I 
suppose saves space on the motherboard.  And if it's a game box where FPS is 
your primary concern than at least updating screen memory isn't constrained 
by PCI or AGP bus bandwidth...

(P.S.  When your i810, which also sucks a video signal out of main memory, 
had performance you considered not-as-sucky, was your screen resolution 
perchance less than it is now?  Pixels (and hence memory bandwidth 
requirements) increase exponentially with resolution, dontcha know.  And a 
greater color depth or more hertz aren't improving matters either...)

Rob
