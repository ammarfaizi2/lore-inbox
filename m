Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbRFTWrv>; Wed, 20 Jun 2001 18:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbRFTWrc>; Wed, 20 Jun 2001 18:47:32 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:45702 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263070AbRFTWr2>; Wed, 20 Jun 2001 18:47:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Mike Harrold <mharrold@cas.org>,
        dalecki@evision-ventures.com (Martin Dalecki)
Subject: Re: [OT] Threads, inelegance, and Java
Date: Wed, 20 Jun 2001 13:46:23 -0400
X-Mailer: KMail [version 1.2]
Cc: landley@webofficenow.com, linux-kernel@vger.kernel.org
In-Reply-To: <200106201927.PAA01484@mah21awu.cas.org>
In-Reply-To: <200106201927.PAA01484@mah21awu.cas.org>
MIME-Version: 1.0
Message-Id: <01062013462308.00776@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 20 June 2001 15:27, Mike Harrold wrote:
> Martin Dalecki wrote:>
>
> > Blah blah blah. The performance of the Transmeta CPU SUCKS ROCKS. No
> > matter
> > what they try to make you beleve. A venerable classical desing like
> > the Geode outperforms them in any terms. There is simple significant

>[root@mobile1 /root]# cat /proc/cpuinfo
>processor       : 0
>vendor_id       : CyrixInstead
>cpu family      : 5
>model           : 7
>model name      : Cyrix MediaGXtm MMXtm Enhanced
>stepping        : 4
>fdiv_bug        : no
>hlt_bug         : no
>sep_bug         : no
>f00f_bug        : no
>coma_bug        : no
>fpu             : yes
>fpu_exception   : yes
>cpuid level     : 2
>wp              : yes
>flags           : fpu msr cx8 cmov 16 mmx cxmmx
>bogomips        : 46.89

Let's just say I haven't exactly been thrilled with the performance of the 
geode samples we've been using at work.  I have a 486 at home that 
outperforms this sucker.  Maybe it's clocking itself down for heat reasons, 
but it really, really sucks.  (Especially since I'm trying to get it to do 
ssl.)

And yes, we're thinking about transmeta as a potential replacement for the 
next generation hardware.  We're also looking around for other (x86 
compatable) alternatives...

> > Well the actual paper states that the theorethical performance was "just" 
> > 20% worser then a comparable normal design. Well "just 20%" is a half 
> > universe diameter for CPU designers.

In the case of transmeta, that's in exchange for a third processor core, 
which is probably worth something.

20% is only about 3 months of moore's law.  90% of processor speed 
improvements over the past few years have been die size shrinks.  You could 
clock a 486 at several hundred mhz with current manufacturing techniques, and 
get better performance out of it than low end pentiums.  (Somebody did it 
with a bottle of frozen alcohol and got themselves injured, but was managing 
a quite nice quake frame rate before the bottle exploded.)  And that's not 
counting the fact a pentium has twice as many pins to suck data through...

And I repeat, if you're clocking the processor over 10x the memory bus rate, 
your cache size and your memory bus become fairly important limiting factors. 
 (Modern processors are much more efficient about using the memory bus, doing 
bursts and predictive prefetches and all.  But that's a seperate issue.)

Look at pentium 4.  Almost all the work done there was simply so they could 
clock the sucker higher, because Intel uses racy logic in their designs and 
had to break everything down into really small pipeline stages to get the 
timing tolerances into something they could manufacture above 1 ghz.  It's AT 
LEAST 20% slower per clock than a PIII or Athlon.  It's all noise compared to 
manufacturing advances shrinking die sizes and reducing trace lengths and 
capacitance and all that fun stuff...

> So what? Crusoe isn't designed for use in supercomputers. It's designed
> for use in laptops where the user is running an email reader, a web

Not just that, think "cluster density".

142 processors per 1U, air cooled, running around 600 mhz each.  The winner 
hands down in mips per square foot.  (Well, I suppose you could do the same 
thing with arm, but I haven't seen it on the market yet.  I may not have been 
paying attention...)

> browser, a word processor, and where the user couldn't give a cr*p about
> performance as long as it isn't noticeable (20% *isn't* for those types
> of apps), but where the user does give a cr*p about how long his or her
> battery lasts (ie, the entire business day, and not running out of power
> at lunch time).

Our mobiles aren't (currently) battery powered, but a processor that doesn't 
clock itself down to 46 bogomips when it's running without a fan is a GOOD 
thing if you're trying to pump encrypted bandwidth through it at faster than 
350 kilobytes per second.  (The desktop units are getting 3.5 megs/second 
running the same code...)

> Yes, it *can* be used in a supercomputer (or more preferably, a cluster
> of Linux machines), or even as a server where performance isn't the
> number one concern and things like power usage (read: anywhere in
> California right now ;-) ), and rack size are important. You can always
> get faster, more efficient hardware, but you'll pay for it.

It's still not power, it''s heat.  You can run some serious voltage into a 
rack pretty easily, but it'll melt unless you bury the thing in fluorinert, 
which is expensive.  (Water cooling of an electrical applicance is NOT 
something you want to be anywhere near when anything goes wrong.)

Processors in a 1U are tied together by a PCI bus or some such.  The latency 
going from one to another is very low.  Processors in different racks are 
tied together by cat 5 or myrinet or some such, and have a much higher 
latency due to speed of light concerns.  A tightly enough coupled cluster can 
act like NUMA, which can deal with a lot more applications than high-latency 
clustering can.  (There hasn't been as much push for research here because 
it's been too expensive for your average grad student to play with, but now 
that the price is coming down...)

> Remember, the whole concept of code-morphing is that the majority of
> apps that people run repeat the same slice of code over and over (eg,
> a word processor). Once crusoe has translated it once, it doesn't need
> to do it again. It's the same concept as a JIT java compiler.

Except code morphing's translation happens about when you suck stuff in from 
main memory into the L1 or L2 cache, which is happening WAY slower than the 
inside of the processor is dealing with anyway, so basically it gives the 
processor extra work to do exactly when it's likely to be spending time on 
wait states...

> /Mike - who doesn't work for Transmeta, in case anyone was wondering... :-)

Neither does

Rob.
