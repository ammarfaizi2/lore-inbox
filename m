Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281719AbRLGSPD>; Fri, 7 Dec 2001 13:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284272AbRLGSOx>; Fri, 7 Dec 2001 13:14:53 -0500
Received: from cj46222-a.reston1.va.home.com ([65.1.136.109]:2969 "HELO
	sanosuke.troilus.org") by vger.kernel.org with SMTP
	id <S281719AbRLGSOh>; Fri, 7 Dec 2001 13:14:37 -0500
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: horrible disk thorughput on itanium
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de>
	<Pine.LNX.4.33.0112070941330.8465-100000@penguin.transmeta.com>
	<20011207185847.A20876@wotan.suse.de>
From: Michael Poole <poole@troilus.org>
Date: 07 Dec 2001 13:14:35 -0500
In-Reply-To: <20011207185847.A20876@wotan.suse.de>
Message-ID: <87wuzyq4ms.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Civil Service)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> > You can be thread-safe without sucking dead baby donkeys through a straw.
> > I already mentioned two possible ways to fix it so that you have locking
> > when you need to, and no locking when you don't.
> 
> Your proposals sound rather dangerous. They would silently break recompiled
> threaded programs that need the locking and don't use -D__REENTRANT (most
> people do not seem to use it). I doubt the possible pain from that is 
> worth it for speeding up an basically obsolete interface like putc. 
> 
> i.e. if someone wants speed they definitely shouldn't use putc()

Threaded programs that need locking and don't define _THREAD_SAFE or
_REENTRANT or whatever is appropriate are already broken -- they just
don't know it yet.

FreeBSD #defines putc and getc to their unlocked versions unless
_THREAD_SAFE is defined, and people don't seem to think its libc is
broken.  Many lightly threaded programs, in fact, wouldn't need or
even want the locked variants to be the default.  One app I've worked
with only reads and writes any given FILE* from one thread, and I saw
an 4x speedup by switching to the unlocked variants.

It's generally a bad idea to make people pay for a feature they don't
ask for.  FreeBSD's libc understands this; glibc apaprently doesn't.

-- Michael Poole
