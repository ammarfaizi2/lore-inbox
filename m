Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317452AbSFCTCA>; Mon, 3 Jun 2002 15:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317454AbSFCTB7>; Mon, 3 Jun 2002 15:01:59 -0400
Received: from pc132.utati.net ([216.143.22.132]:19365 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S317452AbSFCTB5>; Mon, 3 Jun 2002 15:01:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Louis Garcia <louisg00@bellsouth.net>,
        Davide Libenzi <davidel@xmailserver.org>
Subject: Re: P4 hyperthreading
Date: Mon, 3 Jun 2002 09:03:34 -0400
X-Mailer: KMail [version 1.3.1]
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206011842370.976-100000@blue1.dev.mcafeelabs.com> <1022981972.2456.10.camel@tiger>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020603193227.C1FD07BD@merlin.webofficenow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 June 2002 09:39 pm, Louis Garcia wrote:
> I was just thinking about that. Do you now if this has a real speed
> improvement?

As with most speed improvements, it depends on your workload.

Hyper-threading is a way of keeping more execution cores busy more of the 
time, hopefully without putting as much pressure on the cache and memory bus 
(which are the REAL performance bottlenecks with a clock multipler of 18X or 
so) quite as badly as VLIW/EPIC seem to.

If you're running something like distributed.net that has a small enough 
cache footprint, hyperthreading might be really nice.  But seti@home will 
probably suck: it flushes cache contents 24/7.

More to the point, one of the recurring arguments in favor of dual processors 
is that having a second proc to handle interrupt-triggered asynchronous work 
(disk activity,mouse move, keypress, network packet) can, in theory, 
significantly lower your latency.

And in the future, it allows them to pull the Xeon trick of blowing a HUGE 
transistor budget on L1 or on-die L2 cache (next time they rev their 
manufacturing process), and potentially get some actual real-world benefit 
out of it (as something other than compensating for their brain-dead SMP 
memory bus design).

The main down side (other than two threads fighting for the same cache space, 
although interrupts and context switches are going to do that ANYWAY, so...) 
is probably less locality of reference about memory access, so you wind up 
doing more bank switching and such, adding latency to main memory accesses.

There's a great old series about how memory works on Ars Technica (from SRAM 
and DRAM to DDR vs Rambus...):

Part 1: http://www.arstechnica.com/paedia/r/ram_guide/ram_guide.part1-1.html
Part 2: http://www.arstechnica.com/paedia/r/ram_guide/ram_guide.part2-1.html
Part 3: http://www.arstechnica.com/paedia/r/ram_guide/ram_guide.part3-1.html

(And once again, a new technology emerges for which DDR is just a little bit 
better than Rambus... :)

</rampant opinion>

Rob
