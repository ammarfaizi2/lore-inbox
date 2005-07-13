Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262789AbVGMURp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262789AbVGMURp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbVGMURi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:17:38 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:64719 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262738AbVGMURY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:17:24 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Tim Goetze <tim@quitte.de>, Paul Davis <paul@linuxaudiosystems.com>,
       dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>,
       David Lang <david.lang@digitalinsight.com>,
       Bill Davidsen <davidsen@tmr.com>, Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Diego Calleja <diegocg@gmail.com>, azarah@nosferatu.za.org,
       akpm@osdl.org, cw@f00f.org, christoph@lameter.com
In-Reply-To: <341450000.1121283227@flay>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <200507122239.03559.kernel@kolivas.org>
	 <200507122253.03212.kernel@kolivas.org> <42D3E852.5060704@mvista.com>
	 <20050712162740.GA8938@ucw.cz> <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>  <341450000.1121283227@flay>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 16:17:20 -0400
Message-Id: <1121285841.4435.90.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 12:33 -0700, Martin J. Bligh wrote:
> 
> --On Wednesday, July 13, 2005 14:32:02 -0500 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > Hi,
> > 
> > On 7/13/05, Lee Revell <rlrevell@joe-job.com> wrote:
> >> On Wed, 2005-07-13 at 12:10 -0700, Linus Torvalds wrote:
> >> > So we should aim for a HZ value that makes it easy to convert to and from
> >> > the standard user-space interface formats. 100Hz, 250Hz and 1000Hz are all
> >> > good values for that reason. 864 is not.
> >> 
> >> How about 500?  This might be good enough to solve the MIDI problem.
> >> 
> > 
> > I would expect number of laptop users significatly outnumber ones
> > driving MIDI so as a default entry 250 makes more sense IMHO.
> 
> Could someone actually test it, rather than randomly guessing? ;-)
> 

It's not just random guessing, the relationship between HZ and MIDI
clock is well known.  But it's not trivial to give hard numbers because
of the range of hardware possibilities.  Here's another linux-audio-dev
excerpt:

On Thu, 2004-07-01 at 16:32 +0200, Tim Goetze wrote: 
> [Paul Davis]
> 
> >until the high resolution clock timers patch is solid enough to be
> >used by any system, there is no way to schedule MIDI output with this
> >kind of resolution, and if you can't schedule it, then the receiver of
> >your MIDI clock signal will see a lot of jitter and may refuse to lock
> >to it. Even if it locks, its not clear what it will do with the jitter.
> 
> fwiw, i'm achieving quite satisfying results driving MIDI out from a
> 1024 Hz RTC thread, with external hardware locking steadily onto the
> output MIDI clock stream, even at tempi up to 240 bpm.
> 
> MIDI out jitter is about the audio block size at max. DSP load (~1.3
> ms) during audio processing cycles, a fraction of a millisecond for
> the difference between 1024 Hz and the wanted MIDI clock frequency
> otherwise; however this seems to be no problem for the hardware
> attached (a fairly recent synthesizer and infrequently an aging cheap
> drum machine).
> 
> at lower RTC frequencies, the jitter effect on the MIDI h/w becomes
> noticeable (erratic rubato) but it still locks on.
> 

I guess there's a good argument that we should have stuck with the RTC
like in 2.4, but sleep() based timing is a much nicer interface, and it
did work in 2.6.0 - 2.6.12 so the MIDI people have grown used to it.

Lee

