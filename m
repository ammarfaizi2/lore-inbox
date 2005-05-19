Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVESKq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVESKq2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 06:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVESKq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 06:46:28 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:13927 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262262AbVESKqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 06:46:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D2oDGlPoTuAkUIlqU6P/ENF+mx5lq6bkgUBeT2ufVKrT/JKo08LI843ca5pnIFXrqz0fDd7oJxbXpWEqSsN1xDQn+9HL4clQOmkjmIF941v+TbdpU2DimFIOsmgGAI36XIW/HwbitwYjSfZ1OCq2klmHMDQlnFs2Ak94c8OpBhI=
Message-ID: <377362e105051903462a4d8949@mail.gmail.com>
Date: Thu, 19 May 2005 19:46:22 +0900
From: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
Reply-To: "Tetsuji \"Maverick\" Rai" <tetsuji.rai@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: HT scheduler: is it really correct? or is it feature of HT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <377362e105051902467cae323e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <377362e10505181142252ec930@mail.gmail.com>
	 <200505190756.16413.kernel@kolivas.org>
	 <377362e1050518235812f1cbbb@mail.gmail.com>
	 <200505191718.55615.kernel@kolivas.org>
	 <377362e105051902467cae323e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done a temporary minor hacking, which tells kernel only the half
value of nice in all processes.  Actually idle percentage was lowered,
but the response of the main application became slower (as a matter of
course.)

I'm not sure which is better..if possible I want to take advantages of
each one :)   Am I expecting too much?

regards,
---------------------my minor hacking--------------
maverick:/usr/src/linux/kernel% diff sched.c sched.c.orig
57d56
< /*
61,68d59
< */
< /*
<  * hacked by Tetsuji Maverick Rai
<  */
< #define NICE_TO_PRIO(nice)    (MAX_RT_PRIO + (nice/2) + 20)
< #define PRIO_TO_NICE(prio)    (((prio) - MAX_RT_PRIO - 20)*2)
< #define TASK_NICE(p)          PRIO_TO_NICE((p)->static_prio)
<
--------------------


On 5/19/05, Tetsuji Maverick Rai <tetsuji.rai@gmail.com> wrote:
> But I would like a kernel to let boinc (the "nice=19" processes) fill
> the idle time as much as possible.  The current kernel scheduler seems
> very sensitive to low-nice (higher priority) processes.
> 
> How can I change this sensitivity?   I'm looking at kernel/sched.c,
> but it's more complicated than a few years ago when I hacked this
> before :) and that I'm using HT (SMP)..  Will you tell me any hint
> where to modify, and/or what to take care of?  or any pointer to
> proper resources on the Internet?
> 
> When I use gnome desktop with a system monitor applet, I see there's
> always some idle part and top also shows the idle time on gnome even
> if I don't run any specific applications besides system daemons and
> gnome background processes.  However without gnome/X window, top shows
> no or very small idle power (as a matter of course.)  So I want the
> kernel to be less sensitive.  Maybe it will utilize more cpu power.
> 
> best regards,
> 
> On 5/19/05, Con Kolivas <kernel@kolivas.org> wrote:
> > On Thu, 19 May 2005 04:58 pm, Tetsuji "Maverick" Rai wrote:
> > > On 5/19/05, Con Kolivas <kernel@kolivas.org> wrote:
> > > > ------------snip---------------
> > > > Hyperthread sibling cpus share cpu power. If you let a nice 19 task run
> > > > full power on the sibling cpu of a nice 0 task it will drain performance
> > > > from the nice 0 task and make it run approximately 40% slower. The only
> > > > way around this is to temporarily make the sibling run idle so that a
> > > > nice 0 task gets the appropriate proportion of cpu resources compared to
> > > > a nice 19 task. It is intentional and quite unique to the linux cpu
> > > > scheduler as far as I can tell. On any other scheduler or OS a nice 19
> > > > "background" task will make your machine run much slower.
> > > >
> > > Thanks.   I understood it's a feature of linux kernel and am satisfied
> > > with it.  Actually on Windows xp my application sometimes slows down
> > > maybe due to inpropoer scheduler.
> >
> > Well I invented it so it's very unlikely that Windows* will have it (?yet) :D
> >
> > Cheers,
> > Con
> >
> 
-- 
Luckiest in the world / Weapon of Mass Distraction
http://maverick6664.bravehost.com/
Aviation Jokes: http://www.geocities.com/tetsuji_rai/
Background: http://maverick.ns1.name/
