Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbULNXBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbULNXBV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbULNW7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:59:15 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:53895 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261741AbULNW5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:57:45 -0500
Message-Id: <200412142257.iBEMvYPj014838@localhost.localdomain>
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, Steven Rostedt <rostedt@goodmis.org>,
       LKML <linux-kernel@vger.kernel.org>, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       George Anzinger <george@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc3-mm1-V0.7.33-0 
In-reply-to: Your message of "Tue, 14 Dec 2004 17:47:11 EST."
             <1103064432.14699.69.camel@krustophenia.net> 
Date: Tue, 14 Dec 2004 17:57:34 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.151.88.162] at Tue, 14 Dec 2004 16:57:39 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > On Tue, 2004-12-14 at 22:18 +0100, Ingo Molnar wrote:
>> > > the two projects are obviously complementary and i have no intention to
>> > > reinvent the wheel in any way. Best would be to bring hires timers up to
>> > > upstream-mergable state (independently of the -RT patch) and ask Andrew
>> > > to include it in -mm, then i'd port -RT to it automatically.
>> > 
>> > Among other things I think Paul Davis mentioned that George's high res
>> > timer patch would make it possible for JACK to send MIDI clock.  This
>> > would be a huge improvement.
>> 
>> <clueless question> roughly what latency/accuracy requirements does the
>> MIDI clock have, and why is it an advantage if Linux generates it? What
>> generates it otherwise - external MIDI hardware? Or was the problem
>> mainly not latency/accuracy but that Linux couldnt generate a
>> finegrained enough clock?

the latter. to send MIDI Clock or MIDI Timecode requires an interrupt
source that is not locked to jiffie-ish intervals or power-of-2
related intervals. For example, MTC requires sending 2 bytes roughly
every 0.8msec. Sending them every msec isn't good enough, in general.

my understanding of the HRT patch is that it allows the timer to be
reprogrammed to elapse with nanosecond resolution. i don't understand
why linus has been so reluctant to move linux in this direction, other
than it being hard to fit into the existing fixed interval timer
framework.

--p
