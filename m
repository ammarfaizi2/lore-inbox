Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263791AbTLOQkZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLOQkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:40:24 -0500
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:50508 "EHLO
	floyd.gotontheinter.net") by vger.kernel.org with ESMTP
	id S263796AbTLOQkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:40:16 -0500
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups
	patch, no difference)
From: Disconnect <lkml@sigkill.net>
To: ross@datscreative.com.au
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200312131225.34937.ross@datscreative.com.au>
References: <200312131225.34937.ross@datscreative.com.au>
Content-Type: text/plain
Message-Id: <1071506410.2030.35.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 15 Dec 2003 11:40:12 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks greatly for the tips, btw.  Its much appreciated :)

Also, I think I forgot to mention (doh) its an Epox 8rda+.

On Fri, 2003-12-12 at 21:25, Ross Dickson wrote:
> I am not certain your problems are nforce2 type specific.
> Standard response: I don't suppose you can try a different stick of ram?

Unfortunately not - its a single kingston hyper-x 3200 stick.  (In
theory I'll be moving it up to 700M or a gig in the next couple months,
at which point I'll be in position to swap ram around and so forth.)  I
did get the bios all tuned and run memtest-mmx on it for 24 hours before
the system installation though, and it passed.  What I did yesterday is
turn the memory frequency down from 200 to 166. (Which leaves the cpu
overclocked by about 33 mhz, something I think it will survive just fine
;) ..)

> The local apic ack delay timing patch needs athlon cpu and amd/nvidia ide on in 
> kern config to kick in. If you are using it then I highly recommend uniprocessor 
> ioapic config as well to go with it to route the 8254 timer irq0 through pin 0 of 
> ioapic as using the apic config alone leaves a lot of ints generated on irq7 
> which can cause problems. (Reason for 8259 making them spurious on irq7 
> is explained in 8259A data sheet)

Thats how I'm running it now - its gone about 1 day without any oopses. 
(In the past it would go anywhere from hours to about a week, so the
results aren't in yet.)  

On the basis of it being a memory issue I poked around the epox site and
noticed something I hadn't seen before - they recommend what might be
different memory timings (I'll have to check if/when it crashes again):

If your PC3200 memory is not stable try the following BIOS settings:

Memory Frequency = 100%
Memory Timing = Expert
T(RAS) = 7
T(RCD) = 3
T(RP) = 3
CAS Latency = 2.5

Adjust the memory frequency above until you reach the resulting
frequency of 200MHz (for PC3200).

-- 
Disconnect <lkml@sigkill.net>

