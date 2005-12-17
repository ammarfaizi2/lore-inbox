Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbVLQUMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbVLQUMU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbVLQUMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:12:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20183 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932180AbVLQUMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:12:19 -0500
Date: Sat, 17 Dec 2005 12:11:39 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, mingo@redhat.com, akpm@osdl.org
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes 
In-Reply-To: <14917.1134847311@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org> 
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain> 
 <14917.1134847311@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Dec 2005, David Howells wrote:
> 
> Linux supports a number of those archs. Amongst them are 68000 (TAS), arm (SWP
> I think), i386 (XCHG), and FRV (SWAP). I'm also looking at another that only
> has BSET/BCLR.

Don't bother putting i386 in that list.

Quite frankly, you've done it before, and I think it's intellectually 
totally dishonest.

i386 does semaphores with a "lock decl". You CANNOT DO IT FASTER. I dare 
you. Why the hell do you try to make it sound as if x86 would need this 
new thing, when it absolutely does NOT need it.

Yes, x86 _also_ has an xchg instruction, but hey, that's a total 
non-argument. We don't actually use that. 

Of the other architectures you list, only ARM is really important. And no, 
arm doesn't do swap. It does LL/SC (except they call it "ldrex/strex", 
which I assume stands for "load/store with reservation and X just because 
X is cool. Yeah, we're cool" (*)).

68k is dead. Nobody cares. So just say it outright: this is totally just a 
FRV feature, and NOBODY ELSE IS IN THE LEAST INTERESTED.

Ok? Just to inject a little honesty here.

			Linus

(*) Actually, some arm docs I found implies that "ex" stands for 
"exclusive", but that leaves me wondering what the "r" stands for? 
