Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286162AbRLJFco>; Mon, 10 Dec 2001 00:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286163AbRLJFce>; Mon, 10 Dec 2001 00:32:34 -0500
Received: from sydney1.au.ibm.com ([202.135.142.193]:17414 "EHLO wagner")
	by vger.kernel.org with ESMTP id <S286162AbRLJFcP>;
	Mon, 10 Dec 2001 00:32:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: anton@samba.org, davej@suse.de, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: Linux 2.4.17-pre5 
In-Reply-To: Your message of "Mon, 10 Dec 2001 00:41:43 -0000."
             <E16DEVr-0008SW-00@the-village.bc.nu> 
Date: Mon, 10 Dec 2001 16:31:41 +1100
Message-Id: <E16DJ2T-0002Af-00@wagner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <E16DEVr-0008SW-00@the-village.bc.nu> you write:
> > 	If you number each CPU so its two IDs are smp_num_cpus()/2
> > 	apart, you will NOT need to put some crappy hack in the
> > 	scheduler to pack your CPUs correctly.
> 
> Which is a major change to the x86 tree and an invasive one. Right now the
> X86 is doing a 1:1 mapping, and I can offer Marcelo no proof that somewhere
> buried in the x86 arch code there isnt something that assumes this or mixes
> a logical and physical cpu id wrongly in error. 

Agreed, but does the current x86 code does map them like this or not?
If it does, I'm curious as to why they saw a problem which this fixed.

I've been playing with this on and off for months, and trying to
understand what is happening.  I posted my findings, and I'd really
like to get some feedback from others doing the same thing.

BUT I CAN'T DO THAT WHEN THERE'S NO DISCUSSION ABOUT PATCHES FROM
ANONYMOUS SOURCES WHICH GET MERGED!  FUCK ARGHH FUCK FUCK FUCK.

(BTW, "I trust Intel engineers" is NOT discussion).

> Congratulations on your zen like mastery of the scheduler algorithm.

8) I just try to understand what I've seen on real hardware.  It leads
to my belief that HMT cannot be a win on # processes = # CPUS + 1
situations on a non-preemptible scheduler.

> The simple scheduler doesn't work. I've run about 20 schedulers on playing
> cards, and at the point you are shuffling things around and its clear what 
> is happening its actually hard not to start laughing at the current
> scheduler once you hit a serious load or serious amounts of processors.

Ack.  Even in the limited case of trying to get HMT to work reasonably
in simple cases, scheduling changes are not simply "change the
goodness() function and it alters behavior". 8(

BTW: Alchemy, Voodoo, Zen and Cards.  Maybe you should start hacking
on something more deterministic? 8)

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
