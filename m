Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVJFRG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVJFRG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJFRG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:06:59 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:14967 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751150AbVJFRG6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:06:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r1Z8igb0gnqVeOVNsA3jfRP2wi9zMazk3e+NRFYS+63CjSq/CwpdZtTRKJO/R9++YxObmY1IdxRrwJF97aZAGU7kVxfpfmzxrW6NOsSni2IyPp3BX/jmCaMqMfEj7ehEg9SczMINlEYUKlkc6TTynY2Sx5AGYV+7y16J3r/wuk4=
Message-ID: <5bdc1c8b0510061006p5339d5f3ke0079c172e15b04f@mail.gmail.com>
Date: Thu, 6 Oct 2005 10:06:57 -0700
From: Mark Knecht <markknecht@gmail.com>
Reply-To: Mark Knecht <markknecht@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510060930y5648eacdm376178069dcd3958@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
	 <20051006083043.GB21800@elte.hu>
	 <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
	 <1128615988.14584.38.camel@mindpipe>
	 <5bdc1c8b0510060930y5648eacdm376178069dcd3958@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/05, Mark Knecht <markknecht@gmail.com> wrote:
> On 10/6/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Thu, 2005-10-06 at 09:00 -0700, Mark Knecht wrote:
> > > Even with Jack running I don't see the jackd process getting any
> > > special priority. Is this correct, or is that part that gets higher
> > > prioity just not listed here.
> >
> > ps does not show all threads of multithreaded processes by default.
> > Use:
> >
> > ps -Leo pid,pri,rtprio,cmd
> >
> > and you should see that 2 JACK threads get RT priority.
> >
> > Lee
>
> Thanks Lee. That's what I thought might be happening.
>
> 8398  24      - hdspmixer
>  8400  24      - qjackctl
>  8400  49      9 qjackctl
>  8402  20      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
>  8402  20      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
>  8402  23      - /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
>  8402  60     20 /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
>  8402  50     10 /usr/bin/jackd -R -dalsa -dhw:1 -r44100 -p128 -n2
>
> Cheers,
> Mark
>

Hi Ingo,
   OK, after about an hour or moderately heavy usage while running
Jack - I've built a new new kernel, done an emerge sync and am in the
process of an emerge world right now (it's building glibc) along with
playing music and browsing the web - I just had my first xrun:

configuring for 44100Hz, period = 128 frames, buffer = 2 periods
nperiods = 2 for capture
nperiods = 2 for playback
08:51:42.919 Server configuration saved to "/home/mark/.jackdrc".
08:51:42.919 Statistics reset.
08:51:43.037 Client activated.
08:51:43.038 Audio connection change.
08:51:43.042 Audio connection graph change.
09:11:52.063 Audio connection graph change.
09:11:52.122 Audio connection change.
09:11:54.217 Audio connection graph change.
subgraph starting at qjackctl-8400 timed out (subgraph_wait_fd=17,
status = 0, state = Finished)
09:54:17.656 XRUN callback (1).
**** alsa_pcm: xrun of at least 4.351 msecs

So....how do I begin to find out what caused that, or will cause
similar xruns in the future?

Is it that rt priorities are not set up correctly? Or is it something else?

I must say that the kernel has really improved for me over the last
couple of weeks. This is great performance from where I was before I
joined the LKML. I think you guys are making good progress, most
especially for my AMD64 platform.

Thanks!

Cheers,
Mark
