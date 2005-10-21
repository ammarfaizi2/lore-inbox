Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965127AbVJUTp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965127AbVJUTp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 15:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965133AbVJUTp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 15:45:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:29412 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965127AbVJUTp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 15:45:58 -0400
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <5bdc1c8b0510211152m592d95cfte57dc7e9b027f87a@mail.gmail.com>
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
	 <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
	 <1129920323.17709.2.camel@mindpipe>
	 <5bdc1c8b0510211152m592d95cfte57dc7e9b027f87a@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 15:44:42 -0400
Message-Id: <1129923883.17709.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 11:52 -0700, Mark Knecht wrote:
> On 10/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-10-21 at 10:40 -0700, Mark Knecht wrote:
> > > On 10/21/05, Mark Knecht <markknecht@gmail.com> wrote:
> > > > Hi,
> > > >    Maybe I'm catching something here? Maybe not - no xruns as of yet,
> > > > but I've never seen these messages before. Kernel config attached.
> > > >
> > > >    dmesg has filled up with these messages:
> > > >
> >
> > This isn't a real problem.  You enabled CONFIG_RTC_HISTOGRAM.  Don't do
> > that.
> >
> > Lee
> 
> 
> Right, but the 'piggy' messages are a real prblem, aren't they?

No I don't think so.  CONFIG_RTC_HISTOGRAM is a hack, designed to work
with a specific test program that runs SCHED_FIFO and poll()s on the
RTC.  VLC apparently poll()s on the RTC but does not run SCHED_FIFO.  So
of course there will be delays.

Now that the kernel has good soft realtime support and non-root RT
scheduling, these apps really need to adopt a correct soft RT design
like JACK.  AFAICT they don't even bother to try to get SCHED_FIFO for
the time-sensitive rendering threads.  I can't even get totem-xine (the
default "Sound and Movie Player" for Gnome) to keep the audio and video
in sync.  mplayer only plays smoothly if I run it at nice -10.  Etc.

The Linux kernel is pretty good for RT these days but compared to OSX or
even Windows the apps are a joke.

Lee

