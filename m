Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUHKCtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUHKCtu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 22:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbUHKCtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 22:49:50 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:28304 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S267891AbUHKCtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 22:49:41 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8-rc3-O4
From: Tim Wright <timw@splhi.com>
To: Dave Jones <davej@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Ingo Molnar <mingo@elte.hu>, Florian Schmidt <mista.tapas@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
In-Reply-To: <20040810173756.GB22928@redhat.com>
References: <20040726204720.GA26561@elte.hu>
	 <20040729222657.GA10449@elte.hu> <20040801193043.GA20277@elte.hu>
	 <20040809104649.GA13299@elte.hu> <20040809130558.GA17725@elte.hu>
	 <20040809190201.64dab6ea@mango.fruits.de> <1092103522.761.2.camel@mindpipe>
	 <20040810085849.GC26081@elte.hu> <1092157841.3290.3.camel@mindpipe>
	 <1092155147.16979.33.camel@localhost.localdomain>
	 <20040810173756.GB22928@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1092192564.20043.110.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 10 Aug 2004 19:49:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 10:37, Dave Jones wrote:
> On Tue, Aug 10, 2004 at 05:25:48PM +0100, Alan Cox wrote:
>  > On Maw, 2004-08-10 at 18:10, Lee Revell wrote:
>  > > OK, with CONFIG_M586TSC, I am getting a lot of lockups.  A few happened
>  > > during normal desktop use, and it locks up hard when starting jackd. 
>  > > Could this have anything to do with the ALSA drivers (which I am
>  > > compiling seperately from ALSA cvs) detecting my build system as i686? 
>  > > I have read that the C3 is more like a 486 (with MMX & 3DNow) than a
>  > > 686.
>  > 
>  > The C3 is a full 686 instruction set. The kernel is different because
>  > the GNU tool people couldn't read manuals and once the error was made 
>  > it was a bit too late to fix it.
>  > 
>  > Thus ALSA deciding its 686 is fine.
> 
> Depends which C3.  If OP's C3 lacks cmov, it definitly is not ok.
> Any cmov ending up in that module will blow up.
> 

Not that it helps at all, but the conditional move instruction was
marked as optional by Intel, hence the 'cmov' capability flag (in the
flags part of /proc/cpuinfo). As you say, the earlier C3 chips (like the
one in my firewall) lack support for this instruction:

model name      : VIA Samuel 2
cpu MHz         : 533.365
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow

So, strictly speaking, you shouldn't use cmov for something that's
simply "i686" compatible. Of course, gcc etc. uses it because it's very
nice from the point of view of avoiding having to do branches and the
associated malarky and someone failed to spot that it was optional. So,
yes, it's not OK to use -march=i686 on these chips. Modern gccs know
about -march=c3, which ought to be a good bet for these chips (one would
hope).

Tim

-- 
Tim Wright <timw@splhi.com>
Splhi
