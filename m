Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSGUS4C>; Sun, 21 Jul 2002 14:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSGUS4C>; Sun, 21 Jul 2002 14:56:02 -0400
Received: from hoochie.linux-support.net ([216.207.245.2]:56755 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S312254AbSGUS4C>; Sun, 21 Jul 2002 14:56:02 -0400
Date: Sun, 21 Jul 2002 13:59:06 -0500 (CDT)
From: Mark Spencer <markster@linux-support.net>
To: Daniel Phillips <phillips@arcor.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Zaptel Pseudo TDM Bus
In-Reply-To: <E17W4xi-00033v-00@starship>
Message-ID: <Pine.LNX.4.33.0207211352560.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In my quick tour I was looking for where the saw-off between kernel and
> user space is in the source tree, and I began to get the feeling the
> whole thing is kernel space, is this correct?

Nope, in general the saw-off is that signal processing and protocol
implementations that are beyond a few bits of logic are done in userspace.
The exceptions are echo cancellation (which has to be done very close to
the itnerface) and RBS protocols which are easy and important enough to be
done in the kernel.  DTMF detection and the FSK modems for Caller*ID and
ADSI are done in userspace, as well as the PRI implementation (libpri).

> Anyway, this effort is exciting and ambitious.  I *want* to use this, for
> very practical reasons, never mind that it would well turn into yet another
> vibrant embedded application area for Linux.

:)  Just look at "zaptel" as being the kernel interface and "zapata" as
being the user-level interface.  Biased as I am, of course, I think that
Asterisk is the most interesting application of the technology but not
everyone seems to agree ;-)

A direct link to the whitepaper is:

ftp://ftp.asterisk.org/pub/asterisk/misc/asterisk-whitepaper.pdf

> It strikes me that much of what you're doing qualifies as hard realtime
> programming, particularly where you are doing things like interleaving file
> transmission with realtime voice.  I'm thinking that this may be a good
> chance to give the new Adeos OS-layering technology a test drive, with a view
> to achieving more reliable, lower latency signal processing and equipment
> control.  If things work out, this could qualify as the first genuine
> consumer-oriented hard realtime application for Linux.

Actually, Linux right out of the box on modern PC hardware (400+Mhz) seems
more than fine for the task.  We even have people running this on 200Mhz
cyrix machines (single channels) and I've been able to driver a T1 on a
233 Mhz PII, although I don't think I'd recommend this configuration
officially!  I'd be happy to see what hard-realtime might be able to do in
terms of pushing the hardware requirements even lower, but it seems pretty
exciting just as it is!

One more thing that might be interesting would be seeing how small we
could push the "chunk size".  Right now, we use a chunk size of 8, but
a chunk size of 1 (that is, interrupting for EVERY sample) would put us
at a level indistinguishable from hard TDM.

Mark

