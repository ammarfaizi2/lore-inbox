Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSGLOnQ>; Fri, 12 Jul 2002 10:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316571AbSGLOnQ>; Fri, 12 Jul 2002 10:43:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S316569AbSGLOnO>; Fri, 12 Jul 2002 10:43:14 -0400
Date: Fri, 12 Jul 2002 10:46:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kirk Reiser <kirk@braille.uwo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: Advice saught on math functions
In-Reply-To: <E17T15g-0007mP-00@speech.braille.uwo.ca>
Message-ID: <Pine.LNX.3.95.1020712104137.982A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2002, Kirk Reiser wrote:

> Hi Folks:  What I am striving to do is build a software based speech
> synthesizer into a linux driver.  It is a greatly hacked version of
> rsynth I call tuxtalk.  My problem is that I have the code so far cut
> down to about 66k without the shared library routines.  When I
> staticly build the object comes out to over 512k.  Obviously this is
> to large to want built-in to the kernel.  The majority of the size is
> from libm.a.  There are five functions I need from the library, log(),
> log10(), exp() cos() and sin().
> 
> My questions are:
> Are these functions which are supplied by the FPU?  I've looked
> through the fpu emulation headers and exp() is the only one I can find
> any reference to.
> 
> Is there a better method to provide these functions than to pull them
> out of libm.a?
> 
> I appreciate any suggestions or recommendations people may have on
> these questions.
> 

I think you want to do this in user-mode so you get to use
the FPU on Intel Machines. Actual interface to any hardware,
i.e., the stuff that sends/receives sounds can be done in
a cooperating kernel module.

We do this kind of stuff here at Analogic. We make all kinds
of waveforms using mathematics, then we write the stuff to
hardware memory and end up with really complex waveforms with
periods in the GHz range, while we created them at a leisurely
MHz or less (build waveform, then upload changes).

You really don't want to use 'C' runtime library routines inside
the kernel because some expect to interface to the kernel using
the user-mode API (int 0x80). This is NotGood(tm)!

Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

