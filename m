Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbVIOB36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbVIOB36 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVIOB36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:29:58 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:44416 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030326AbVIOB36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:29:58 -0400
Subject: Re: HZ question
From: Lee Revell <rlrevell@joe-job.com>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: jdow <jdow@earthlink.net>, Mark Hounschell <markh@compro.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509131615450.8516@chaos.analogic.com>
References: <4326CAB3.6020109@compro.net>
	 <Pine.LNX.4.61.0509130919390.29445@chaos.analogic.com>
	 <02e201c5b89f$a3248e80$1925a8c0@Thing>
	 <Pine.LNX.4.61.0509131615450.8516@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 14 Sep 2005 21:29:49 -0400
Message-Id: <1126747789.13893.118.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-13 at 16:38 -0400, linux-os (Dick Johnson) wrote:
> > That means Linux is not a suitable operating system for multimedia
> > applications.
> > MIDI needs to schedule in 1 ms or smaller increments. The userland
> > application
> > should be able to set this. It should be able to determine this. If it
> > cannot
> > then it is useless. (It also explains why MIDI based applications are so
> > absolutely dreadful on Linux.)
> >
> > {^_^}   Joanne Dow said that.
> >
> >
> 
> Well no. MIDI stuff has drivers that interface with precision timers
> in your audio board such as Creative Labs Soundblaster. They have
> a serial connection that, with a simple adapter becomes MIDI I/O.
> These boards, and even the ones built into motherboards can (do)
> generate and receive precision MIDI.

Um, we know how MIDI interfaces work, thanks very much.

Yes, ideally all MIDI would use the soundcard's interval timer for
timing.  The problem is that so many of the soundcard drivers are
reverse engineered and we don't always know how to use it.  Currently
only the emu10k1 and ymfpci ALSA drivers support the soudn cards
hardware timer.  The emu10k1's interval timer was not supported at all
until ALSA 1.0.8 or so (I added the support).  And the ALSA sequencer
still does not use the soundcard timer by default, you have to pass
module options.  By default we have to use itimers because it works
everywhere.

And what if you're playing back a MIDI file from a sequencer into a
softsynth and sending the audio out through your cheap soundcard?  No
MIDI ports or timers available.  For example the intel8x0 doesn't have
an interval timer at all.

Userspace DOES need to know the timer resolution (but as others pointed
out you don't need to know HZ).  If HZ is 100 then the best itimers can
do is ~10ms which is unacceptable for MIDI, so the program uses /dev/rtc
for timing instead.

If you had checked the linux-audio-dev archives before spouting off
you'd find TONS of apps that do just this.

Lee

