Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271424AbUJVQsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271424AbUJVQsK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbUJVQsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 12:48:10 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:55562 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S271424AbUJVQsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 12:48:03 -0400
Message-ID: <41793C94.3050909@techsource.com>
Date: Fri, 22 Oct 2004 13:00:04 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Jan Knutar <jk-lkml@sci.fi>
CC: Stephen Wille Padnos <spadnos@sover.net>, Jon Smirl <jonsmirl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4177DF15.8010007@techsource.com> <4177E50F.9030702@sover.net> <200410220238.13071.jk-lkml@sci.fi>
In-Reply-To: <200410220238.13071.jk-lkml@sci.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jan Knutar wrote:
> On Thursday 21 October 2004 19:34, Stephen Wille Padnos wrote:
> 
> 
>>I'm thinking more like microcode.  The functional blocks on the chip 
>>would be capable of being "rewired" by the OS, depending on the 
>>applications being run.  All of the functions would still operate out of 
>>card-local memory.
> 
> 
> Are you thinking something along the lines of an optimizing+profiling
> host-CPU-software-renderer to FPGA-reprogrammed JIT accelerator? :)
> 
> The idea of reprogramming the hardware to toss out the line drawing and
> other things that GTK and friends probably only present to X as pixmaps
> anyway, and use that 'die space' for something else, is certainly appealing.
> 
> Of course, for a software -> hardware JITc, I think the budget required would
> be a few magnitudes more than mentioned here earlier, and half a decade
> of debugging or more ontop..


For this graphics design, and I'm getting into premature implementation 
details, but I'm a geek, so I can't help myself... I think having some 
sort of primitive microcontroller at the front end of the design is 
necessary.  Two major things it would do would be to control the DMA bus 
mastering, and translate commands (both DMA and PIO) into the parameters 
required by the rendering engine.

See, I would design a very flexible, programmable rasterizer which could 
be programmed to do anything.  But for many operations like bitblt and 
line drawing, there's a load of redundancy.  For lines, all you need are 
the end-points.  If software had to program that directly, it would be a 
major non-win for small primitives like short lines and small bitblts 
where sending the command over the AGP bus would take longer than 
actually doing the rendering.

In my experience, throwing CPU time at a problem in order to reduce the 
bus traffic is almost always a win, a significant performance boost.

A good compromise between having the host waste a lot of bus traffic and 
using up chip area with too much dedicated hardware is to have the 
front-end microcontroller ("setup engine") do a fair amount of the work. 
  This way, I could eliminate anything from the rasterizer that was 
there only so it could draw diagonal lines but STILL be able to draw 
fast diagonal lines.



Here's an interesting philosophical question:  If I spend too much time 
discussing the technical issues of the design BEFORE it is released, am 
I significantly increasing the risk of a competitor cutting us off at 
the knees before I can even get started?  On the one hand, everyone will 
be happy if ANYONE produces a completely open-spec design.  On the other 
hand, I would be very unhappy if I didn't get to do it myself.

ATI and nVidia are secretive for damn good reasons.

