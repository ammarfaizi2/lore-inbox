Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318701AbSG0Fyb>; Sat, 27 Jul 2002 01:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318702AbSG0Fyb>; Sat, 27 Jul 2002 01:54:31 -0400
Received: from admin.nni.com ([216.107.0.51]:39185 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318701AbSG0Fya>;
	Sat, 27 Jul 2002 01:54:30 -0400
Date: Sat, 27 Jul 2002 01:57:03 -0400
From: Andrew Rodland <arodland@noln.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Speaker twiddling [was: Re: Panicking in morse code]
Message-Id: <20020727015703.21f47a37.arodland@noln.com>
In-Reply-To: <200207270526.g6R5Qw942780@saturn.cs.uml.edu>
References: <20020727000005.54da5431.arodland@noln.com>
	<200207270526.g6R5Qw942780@saturn.cs.uml.edu>
X-Mailer: Sylpheed version 0.7.8claws55 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jul 2002 01:26:58 -0400 (EDT)
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

> >> The vast majority of us would need a microphone and
> >> translator program anyway, so a computer-friendly
> >> encoding makes more sense. Modems don't do morse.
> >
> > "asciimorse" would be possible, just going through the byte and
> > doing - for 1 and . for 0... as a matter of fact, it would probably
> > only take about two lines of code to get that to be an option, too.
> > Does everyone else think that that's really the situation?
> > (Personally, I can't do morse in my head. But neither do I have any
> > oops-decoding hardware. >:)
> >
> > I'll probably code it anyway. It should allow for a faster
> > transmission rate, anyway, since you don't have to accomodate
> > humans. (Anyone who can decode "asciimorse" in their head is a REAL
> > freak. Er. no offense.)
> 
> Hopefully reasonable idea:
> 
> Start each transmission with 900 HZ for 80 ms.
> Start each line with 1300 HZ for 40 ms.
> Each bit is 10 ms at 1600 HZ or 1900 HZ.
> Transmit the 7 low bits, plus a parity bit.
> End each line with a '\0' and a checksum byte.
> End each transmission with silence for 80 ms.
> 

Reasonable -- it would still fit within the code framework I've got
right now, and within the way that panic_blink() works in general.
Do we use odd-parity, so that we can tell the \0 before the checksum
from a \0 in the input stream?

Does a crappy, battery-powered micro tape recorder have a chance of
recording this accurately?

> That ought to survive telephone transmission.
> If I'm lucky, it might survive MP3 encoding.
> It's about 120 WPM, and doesn't slow down on
> non-English text like an oops report.

Anyway, I like it in general. Could you write the decoder software, or
do we have any other volunteers on the list to do it? I'm not sure that
my /dev/dsp programming is up to snuff. (Actually, it'd probably be
easier operating on a .wav/.au unless you want real-time.)

Some final notes/questions:

* 10ms is just one jiffie on most arches in 2.4. That means that we
won't get perfect timing. (I don't think I want to switch to anything
_other_ than jiffies when we're panicked, but I don't know anything
about any of the higher-res stuff. Keep in mind that we get called
inside an infinite loop, and that it's not so easy to change that)

* Might anything from userland want access to this as a device? This
sounds nice at first blush, but using the same code to work well both
as a 'real' driver and for panic situation doesn't seem too easy.

--hobbs
