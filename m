Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288992AbSAIUDe>; Wed, 9 Jan 2002 15:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288985AbSAIUD2>; Wed, 9 Jan 2002 15:03:28 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:22290 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289004AbSAIUCq>; Wed, 9 Jan 2002 15:02:46 -0500
Message-ID: <3C3CA091.B28D5DFC@zip.com.au>
Date: Wed, 09 Jan 2002 11:57:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Landley <landley@trommello.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16OM59-0001hQ-00@the-village.bc.nu>,
		<E16OM59-0001hQ-00@the-village.bc.nu> <200201091932.g09JW9A27178@snark.thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> 
> On Wednesday 09 January 2002 12:00 pm, Alan Cox wrote:
> > > The high-end audio synth guys claim that two milliseconds is getting
> > > to be too much.  They are generating real-time audio and they do
> > > have more than one round-trip through the software.  It adds up.
> >
> > Most of the stuff I've seen from high end audio people consists of
> > overthreaded, chains of code written without any consideration for the
> > actual cost of execution. There are exceptions - including
> > people dynamically compiling filters to get ideal cache and latency
> > behaviour, but not enough.
> >
> > Alan
> 
> News flash: people are writing sub-optimal apps in user space.

Not only in user=space :)

> Do you want an operating system capable of running real-world code written by
> people who know more about their specific problem domain (audio) than about
> optimal coding in general, or do you want an operating system intended to
> only run well-behaved applications designed and implemented by experts?

The people with whom I dealt (Benno Senoner, Dave Philips, Paul
Barton-Davis) with are deeply clueful about this stuff.  

I'll quote from an email Paul set me a year ago.  I don't think
he'll mind.  This is, of course, a quite specialised application
area:


....

There are two kinds of situations where its needed:

  1) real-time effects ("FX") processing
  2) real-time synthesis influenced by external controllers

In (1), we have an incoming audio signal that is to be processed in
some way (echo/flange/equalization/etc. etc.) and then delivered back
to the output audio stream. If the delay between the input and output
is more than a few msecs, there are several possible
consequences:

        * if the original source was acoustic (non-electronic), and
             the processed material is played back over monitors
             close to the acoustic source, you will get interesting
             filtering effects as the two signals interfere with each
             other. 
             
        * the musician will get confused by material in the 
             processed stream arriving "late"

        * the result may be useless.

In (2), a musician is using, for example, a keyboard that sends MIDI
"note on/note off" messages to the computer which are intended to
cause the synthesis engine to start/stop generating certain sounds. If
the delay between the musician pressing the key and hearing the sound
exceeds about 5msec, the system will feel difficult to play; worse, if
there is actual jitter in the +/- 5msec range, it will feel impossible
to play.

....

Without LL, Linux cannot reasonably be used for professional audio
work that involves real time FX or real time synthesis. The default
kernel has worst-case latencies noticeably worse than Windows, and
most people are reluctant to use that system already, not just because
of instability but latencies also. Its not a matter of it being "a bit
of a problem" - the 100msec worst case latencies visible in the
standard kernel make it totally implausible that you would ever deploy
Linux in a situation where RT FX/synthesis were going to happen.

By contrast, if we get LL in place, then we can potentially use Linux
in "black box"/"embedded" systems designed specifically for audio
users; all the flexibility of Linux, but if they choose to ignore most
of that, they'll still have a black rack-mounted box capable of doing
everything (more mostly everything) currently done by dedicated
hardware. As general purpose CPU performance continues to increase,
this becomes more and more overwhelmingly obvious as the way forward
for audio processing.

....
