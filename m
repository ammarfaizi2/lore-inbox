Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVJaPgW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVJaPgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 10:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbVJaPgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 10:36:22 -0500
Received: from wbm4.pair.net ([209.68.3.85]:61960 "HELO wbm4.pair.net")
	by vger.kernel.org with SMTP id S932172AbVJaPgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 10:36:21 -0500
Message-ID: <1349.192.249.47.11.1130772949.squirrel@webmail4.pair.com>
In-Reply-To: <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
References: <5bdc1c8b0510301828p29ea517ew467a5f6503435314@mail.gmail.com> 
    <50256.192.249.47.11.1130771450.squirrel@webmail2.pair.com>
    <5bdc1c8b0510310726t105f8f8emd1d044f760a8a1eb@mail.gmail.com>
Date: Mon, 31 Oct 2005 09:35:49 -0600 (CST)
Subject: Re: 2.6.14-rt1 - xruns in a certain circumstance
From: "K.R. Foley" <kr@cybsft.com>
To: "Mark Knecht" <markknecht@gmail.com>
Cc: "K.R. Foley" <kr@cybsft.com>, "lkml" <linux-kernel@vger.kernel.org>,
       "Ingo Molnar" <mingo@elte.hu>, "Lee Revell" <rlrevell@joe-job.com>
User-Agent: SquirrelMail/1.4.5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On 10/31/05, K.R. Foley <kr@cybsft.com> wrote:
>>
>> > Hi,
>> >    I've been running 2.6.14-rt1 today. For the most part there seem to
>> > be no changes for me from 2.6.14-rc5-rt3. One place I saw xruns
>> > earlier is still there and I do not understand why this situation
>> > should be able to create xruns.
>> >
>> >    I really think there is something to be learned from this problem.
>> > The way I see it What's going on with Myth is completely separate from
>> > what's going on with Jack, but Myth is causing xruns somehow.
>> >
>> > 1) I have Jack running. It is using sound card #2, my RME HDSP 9652. I
>> > can run for hours and see no xruns.
>> >
>> > 2) I start MythTV using sound card #1. Within MythTV there are
>> > essentially 3 types  of operation:
>> >
>> > a) Basic menus
>> > b) Preview menu
>> > c) Full screen video watching
>> >
>> > What I'm seeing is that when using basic menus, or when watching
>> > videos I get no xruns. However, if I'm in the preview menu I get an
>> > xrun every few minutes. In the following snippet I started Jack and
>> > ran for about 20 minutes with no problems. I was using MythTV and
>> > watching videos. I spent very little time in the preview menu:
>> >
>> > 16:19:26.184 Server configuration saved to "/home/mark/.jackdrc".
>> > 16:19:26.185 Statistics reset.
>> > 16:19:26.411 Client activated.
>> > 16:19:26.412 Audio connection change.
>> > 16:19:26.415 Audio connection graph change.
>> > 16:20:34.918 Audio connection graph change.
>> > 16:20:34.977 Audio connection change.
>> > 16:20:37.842 Audio connection graph change.
>> >
>> > At about 4:45PM I exited the videos and left Myth sitting in a preview
>> > menu. In this mode Myth puts a small video screen in the bottom right
>> > corner where oyu get a low quality picture so you can see what the
>> > start of the program looks like. While sitting in this mode for about
>> > 45  minutes I got 10 xruns:
>> >
>> > 16:45:45.670 XRUN callback (1).
>> > **** alsa_pcm: xrun of at least 0.663 msecs
>> > 16:47:41.697 XRUN callback (2).
>> > **** alsa_pcm: xrun of at least 0.415 msecs
>> > subgraph starting at qjackctl-8363 timed out (subgraph_wait_fd=17,
>> > status = 0, state = Finished)
>> > 17:06:47.023 XRUN callback (3).
>> > **** alsa_pcm: xrun of at least 0.781 msecs
>> > **** alsa_pcm: xrun of at least 4.924 msecs
>> > 17:06:49.003 XRUN callback (1 skipped).
>> > subgraph starting at qjackctl-8363 timed out (subgraph_wait_fd=17,
>> > status = 0, state = Finished)
>> > 17:15:36.697 XRUN callback (5).
>> > **** alsa_pcm: xrun of at least 0.831 msecs
>> > **** alsa_pcm: xrun of at least 2.850 msecs
>> > 17:15:37.707 XRUN callback (1 skipped).
>> > 17:17:38.387 XRUN callback (7).
>> > **** alsa_pcm: xrun of at least 0.617 msecs
>> > subgraph starting at qjackctl-8363 timed out (subgraph_wait_fd=17,
>> > status = 0, state = Finished)
>> > 17:18:52.275 XRUN callback (8).
>> > **** alsa_pcm: xrun of at least 1.654 msecs
>> > 17:20:44.214 XRUN callback (9).
>> > **** alsa_pcm: xrun of at least 0.664 msecs
>> > 17:28:00.610 XRUN callback (10).
>> > **** alsa_pcm: xrun of at least 0.244 msecs
>> > subgraph starting at qjackctl-8363 timed out (subgraph_wait_fd=17,
>> > status = 0, state = Finished)
>> >
>> > At this point I exited the preview menu and went to a higher level
>> > menu and just let the machine sit in Myth for about 20 minutes. No
>> > xruns: At about 5:50PM I went back into the preview menu and got an
>> > xrun within 2 minutes:
>> >
>> > 17:51:59.548 XRUN callback (11).
>> > **** alsa_pcm: xrun of at least 1.156 msecs
>> > 17:52:32.464 XRUN callback (12).
>> > subgraph starting at qjackctl-8363 timed out (subgraph_wait_fd=17,
>> > status = 0, state = Finished)
>> > **** alsa_pcm: xrun of at least 1.326 msecs
>> >
>> >    Note that on this machine I can browse the web, transfer files via
>> > the network, build kernels, do an emerge world, run cpuburn, etc., and
>> > I get no xruns. However, if I run MythTV in the preview menu I get
>> > them consistently.
>> >
>> >    Also note that the MythTV server is actually located over a
>> > wireless connection. There is no wireless on my machine - the
>> > connection is between the router and the machines in another part of
>> > the house. I bring this up in case it indirectly bears upon the
>> > networking, etc.
>> >
>> >    I look forward to hearing what you all think I should look at here.
>> >
>> >    I have not yet turned on the preempt debugging stuff. I'll work on
>> > that after I hear back that I'm not wasting my time.
>> >
>> > Thanks,
>> > Mark
>> > -
>> > To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> > Please read the FAQ at  http://www.tux.org/lkml/
>> >
>> >
>>
>> Mark,
>>
>> If I am not mistaken, aren't you running the ivtv driver for your video
>> card (I think I have seen you on that list also)? Since that driver is
>> being developed outside the mainline kernel, isn't it likely that it
>> hasn't received many of the improvements that the rest of the kernel has
>> (latency and preemption wise)? Just a thought.
>> --
>>
>> kr
>
> Hi,
>    No, the ivtv driver is running on a different machine. Not this
> one. When I was speaking of MythTV here it's a frontend only machine.
>
>    True, I did try putting 2.6.14-rcX-rtY on my MythTV backend server
> but the ivtv driver wouldn't compile so I axed it and left that
> machine running a standard kernel. (Now running 2.6.14-gentoo)
>
>    So, this is a frontend only problem.

Sorry for the speculation.

>
>    I'm going to do as Lee and Ingo suggest, now that I have a test
> that seems to create xruns pretty qickly. Hopefully I'll capture
> something of interest. However I'm questioning exactly what the video
> problem would be since I don't create xruns when watching MythTV full
> screen. Only get them when watching in this preview window. That said
> it is an ATI PCI-Express card but since it's 2.6.14 there is no ATI
> driver support. My kernel is currently trying to load fglrx (the ATI
> driver) and failing since it doesn't support this kernel. I'll clean
> up the video driver setup and retest.
>
>    Anyway, we'll see later today.
>
>    Thanks for all the responses.
>
> Cheers,
> Mark



-- 
K.R. Foley
kr@cybsft.com


