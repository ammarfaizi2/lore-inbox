Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbULNX2G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbULNX2G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbULNXYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:24:35 -0500
Received: from alog0357.analogic.com ([208.224.222.133]:24960 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261745AbULNXWd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:22:33 -0500
Date: Tue, 14 Dec 2004 18:18:59 -0500 (EST)
From: linux-os <linux-os@chaos.analogic.com>
Reply-To: linux-os@analogic.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>,
       Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0
In-Reply-To: <1103064432.14699.69.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.61.0412141805240.20391@chaos.analogic.com>
References: <20041124101626.GA31788@elte.hu>  <20041203205807.GA25578@elte.hu>
 <20041207132927.GA4846@elte.hu>  <20041207141123.GA12025@elte.hu>
 <20041214132834.GA32390@elte.hu>  <1103052853.3582.46.camel@localhost.localdomain>
  <1103054908.14699.20.camel@krustophenia.net>  <1103057144.3582.51.camel@localhost.localdomain>
  <20041214211828.GA17216@elte.hu>  <1103062423.14699.48.camel@krustophenia.net>
  <20041214223118.GD22043@elte.hu> <1103064432.14699.69.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Dec 2004, Lee Revell wrote:

> On Tue, 2004-12-14 at 23:31 +0100, Ingo Molnar wrote:
>> * Lee Revell <rlrevell@joe-job.com> wrote:
>>
>>> On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
>>>> the two projects are obviously complementary and i have no intention to
>>>> reinvent the wheel in any way. Best would be to bring hires timers up to
>>>> upstream-mergable state (independently of the -RT patch) and ask Andrew
>>>> to include it in -mm, then i'd port -RT to it automatically.
>>>
>>> Among other things I think Paul Davis mentioned that George's high res
>>> timer patch would make it possible for JACK to send MIDI clock.  This
>>> would be a huge improvement.
>>
>> <clueless question> roughly what latency/accuracy requirements does the
>> MIDI clock have, and why is it an advantage if Linux generates it? What
>> generates it otherwise - external MIDI hardware? Or was the problem
>> mainly not latency/accuracy but that Linux couldnt generate a
>> finegrained enough clock?
>
> Being able to send or receive MIDI clock is a common feature for
> hardware and software samplers, sequencers, etc.  It just allows more
> flexibility in your setup.  I think currently Linux can receive MIDI
> clock better than it can send.
>
> To answer the last question I think the clock was not fine grained
> enough.  But as far as timing requirements I don't actually know the
> details.  Paul?
>
> Lee
>

When I use Cakewalk Home-Studio to record Music from my MIDI piano,
I notice that the clock-resolution shown is several orders of
magnitude better than anything a PC can generate! I haven't got
a clue where this information comes from. It is in seconds, starting
at 1 (not zero, don't know why) and has resolution of microseconds
with no missing codes. This is on a M$ PC.

This generates a highly-accurate "time ruler". One can back-up
through this time and resolve samples that appear synchronous
but can be displaced in time with apparent resolution much
better than the 38,400 baud-rate of MIDI. I don't know how
they do it, but this is the MIDI "sample-clock". It has to
be virtual because there isn't any hardware on a PC that can
duplicate it.

It is likely that they use a software PLL with some periodic
updates from a timer-tick, but it sure looks impressive to
see "real-time" with such resolution on a PC.

I'm pretty sure that if Cakewalk decided to port Home Studio
to Linux, they would be able to do it with no technical hurdles.
Its just that, for Music, most use Apple and cheapskates like
me use PCs running M$.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by John Ashcroft.
                  98.36% of all statistics are fiction.
