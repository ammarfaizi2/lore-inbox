Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVEOJtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVEOJtF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 05:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbVEOJtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 05:49:04 -0400
Received: from colin.muc.de ([193.149.48.1]:16137 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262068AbVEOJsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 05:48:54 -0400
Date: 15 May 2005 11:48:53 +0200
Date: Sun, 15 May 2005 11:48:53 +0200
From: Andi Kleen <ak@muc.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Dave Jones <davej@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Matt Mackall <mpm@selenic.com>,
       Andy Isaacson <adi@hexapodia.org>,
       "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515094853.GC68736@muc.de>
References: <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org> <20050513215905.GY5914@waste.org> <1116024419.20646.41.camel@localhost.localdomain> <1116025212.6380.50.camel@mindpipe> <20050513232708.GC13846@redhat.com> <1116027488.6380.55.camel@mindpipe> <20050513234406.GG13846@redhat.com> <1116056238.7360.9.camel@mindpipe> <20050514153307.GA6695@g5.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050514153307.GA6695@g5.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 14, 2005 at 05:33:07PM +0200, Andrea Arcangeli wrote:
> On Sat, May 14, 2005 at 03:37:18AM -0400, Lee Revell wrote:
> > The apps that bother to use rdtsc vs. gettimeofday need a cheap high res
> > timer more than a correct one anyway - it's not guaranteed that rdtsc
> > provides a reliable time source at all, due to SMP and frequency scaling
> > issues.
> 
> On x86-64 the cost of gettimeofday is the same of the tsc, turning off

It depends, on many systems it is more costly. e.g. on many SMP
systems we have to use HPET or even the PM timer, because TSC is not
reliable.

> tsc on x86-64 is not nice (even if we usually have HPET there, so
> perhaps it wouldn't be too bad). TSC is something only the kernel (or a
> person with some kernel/hardware knowledge) can do safely knowing it'll
> work fine. But on x86-64 parts of the kernel runs in userland...

Agreed. It is quite complicated to decide if TSC is reliable or not
and I would not recommend user space to do this.

[hmm actually I already have constant_tsc fake cpuid bit, but 
it only refers to single CPUs. I wonder if I should add another
one for SMP "synchronized_tsc". The latest mm code already has
this information, but it does not export it yet] 


> 
> Preventing tasks with different uid to run on the same physical cpu was
> my first idea, disabled by default via sysctl, so only if one is
> paranoid can enable it.

The paranoid should just fix their crypto code. And if they're
clinically paranoid they can always boot with noht or disable
it in the BIOS. But really I think they should just fix OpenSSL. 

> 
> But before touching the kernel in any way it would be really nice if
> somebody could bother to demonstrate this is real because I've an hard
> time to believe this is not purely vapourware. On artificial

Similar feeling here.

> Nobody runs openssl -sign thousand of times in a row on a pure idle
> system without noticing the 100% load on the other cpu for months (and
> he's not root so he can't hide his runaway 100% process, if he was root
> and he could modify the kernel or ps/top to hide the runaway process,
> he'd have faster ways to sniff).

Exactly.

> 
> So to me this sounds a purerly theoretical problem. Cache covert

Perhaps not purely theoretical, but it is certainly not something
that needs drastic action like disabling HT in general.

> This was an interesting read, but in practice I'd rate this to have
> severity 1 on a 0-100 scale, unless somebody bothers to demonstrate it
> in a remotely realistic environment.

Agreed.

-Andi
