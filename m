Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318694AbSG0D7J>; Fri, 26 Jul 2002 23:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318695AbSG0D7J>; Fri, 26 Jul 2002 23:59:09 -0400
Received: from admin.nni.com ([216.107.0.51]:41997 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318694AbSG0D7I>;
	Fri, 26 Jul 2002 23:59:08 -0400
Date: Sat, 27 Jul 2002 00:00:05 -0400
From: Andrew Rodland <arodland@noln.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH -ac] Panicking in morse code
Message-Id: <20020727000005.54da5431.arodland@noln.com>
In-Reply-To: <200207270205.g6R253P35635@saturn.cs.uml.edu>
References: <3D41DA4E.B243E55E@paradise.net.nz>
	<200207270205.g6R253P35635@saturn.cs.uml.edu>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2002 22:05:03 -0400 (EDT)
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

> Jens Schmidt writes:
> 
> > I am not a "morse" guy myself, but appreciate this idea.
> 
> Yeah, same here. I have to wonder if morse is the
> best encoding, since many people don't know it.
> The vast majority of us would need a microphone and
> translator program anyway, so a computer-friendly
> encoding makes more sense. Modems don't do morse.

"asciimorse" would be possible, just going through the byte and doing -
for 1 and . for 0... as a matter of fact, it would probably only take
about two lines of code to get that to be an option, too. Does everyone
else think that that's really the situation? (Personally, I can't do
morse in my head. But neither do I have any oops-decoding hardware. >:)

I'll probably code it anyway. It should allow for a faster transmission
rate, anyway, since you don't have to accomodate humans. (Anyone who
can decode "asciimorse" in their head is a REAL freak. Er. no offense.)

> [some stuff on formats]
> I suspect it's false economy to not encode all of ASCII.
> If you have all of ASCII, then the ugly switch() goes away
> and all you need is a foo&0x7f to ensure things don't go
> from bad to worse.
> 

The ugly switch _is_ gone. However, all of the characters that have a
reasonable encoding are between " and Z (with the exception of
lowercase, which can be mapped onto uppercase with one line).

so current tomorse does:

if (c >= 'a' && c <= 'z') {
	c = c - 'a' + 'A'; //This could be a bit-twiddle, but why?
}
if (c >= '"' && c <= 'Z') {
	return morsetable[c - '"'];
} else {
	return 0;
}

I think this is plenty good. :)

As for Farnsworth spacing... someone provide me with proper timings
(ditlen, inter-component space, inter-letter space) for
12wpm+farnsworth and I'll code it in, if it's really that much better.
I think it's OK the way it is, but I'm one of those types who doesn't
know anything more than 'S', 'O', and 'S'. (Well, and 'E' and 'V' and
the numbers. :)

About changing the encoding: I still don't think that anything could
really be better, from a program-flow standpoint, than what we've got
now. Prove me wrong and I'll be happy.

I don't really think the pretty macros gain anything either, unless the
morse code letters are under heavy development. Last I checked, they're
not. :)

--hobbs's $0.02

