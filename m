Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVJUWZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVJUWZU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 18:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVJUWZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 18:25:20 -0400
Received: from xproxy.gmail.com ([66.249.82.200]:45738 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965162AbVJUWZT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 18:25:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uqtkb2Jzx7cufcotqxBsneOEpgKOkoWGfIvYEs29jUTPNH4BJ05U+IRhdI61jzUgBJcclPSdVljsJtDXTSm5Qdxi6/4No+1mClWsZC0w/jtZdRrMWf/7QeWXB7a8+uWq/wlC8CyiTcWV4yyl3nkIs08IPsuwyN5MQZqXb1NVSp4=
Message-ID: <5bdc1c8b0510211525v62212d33j84491cfc687bd200@mail.gmail.com>
Date: Fri, 21 Oct 2005 15:25:18 -0700
From: Mark Knecht <markknecht@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 2.6.14-rc5-rt3 - `IRQ 8'[798] is being piggy
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1129923883.17709.11.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510211003j4e9bf03bhf1ea8e94ffe60153@mail.gmail.com>
	 <5bdc1c8b0510211040s40f3f9bbj7f83e174d7b6d937@mail.gmail.com>
	 <1129920323.17709.2.camel@mindpipe>
	 <5bdc1c8b0510211152m592d95cfte57dc7e9b027f87a@mail.gmail.com>
	 <1129923883.17709.11.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-10-21 at 11:52 -0700, Mark Knecht wrote:
> > On 10/21/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > > On Fri, 2005-10-21 at 10:40 -0700, Mark Knecht wrote:
> > > > On 10/21/05, Mark Knecht <markknecht@gmail.com> wrote:
> > > > > Hi,
> > > > >    Maybe I'm catching something here? Maybe not - no xruns as of yet,
> > > > > but I've never seen these messages before. Kernel config attached.
> > > > >
> > > > >    dmesg has filled up with these messages:
> > > > >
> > >
> > > This isn't a real problem.  You enabled CONFIG_RTC_HISTOGRAM.  Don't do
> > > that.
> > >
> > > Lee
> >
> >
> > Right, but the 'piggy' messages are a real prblem, aren't they?
>
> No I don't think so.  CONFIG_RTC_HISTOGRAM is a hack, designed to work
> with a specific test program that runs SCHED_FIFO and poll()s on the
> RTC.  VLC apparently poll()s on the RTC but does not run SCHED_FIFO.  So
> of course there will be delays.
>
> Now that the kernel has good soft realtime support and non-root RT
> scheduling, these apps really need to adopt a correct soft RT design
> like JACK.  AFAICT they don't even bother to try to get SCHED_FIFO for
> the time-sensitive rendering threads.  I can't even get totem-xine (the
> default "Sound and Movie Player" for Gnome) to keep the audio and video
> in sync.  mplayer only plays smoothly if I run it at nice -10.  Etc.
>
> The Linux kernel is pretty good for RT these days but compared to OSX or
> even Windows the apps are a joke.
>
> Lee

Lee,
   Indeed, you are correct. Apparently under character devices I had
turned on the RTC histogram feature. With that off I am not only
getting the maximum latency values we expect.

   Now I'll have to let it run for hours/days to see if I catch any
info on these xruns, should I get another rash of them. Yesterday they
came only after about 14 hours of work. I had none the previous two
days.

Thanks,
Mark
