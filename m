Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUA0U6y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265950AbUA0U6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:58:53 -0500
Received: from gprs194-55.eurotel.cz ([160.218.194.55]:8834 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265943AbUA0U62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:58:28 -0500
Date: Tue, 27 Jan 2004 21:58:15 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Bart Samwel <bart@samwel.tk>
Cc: Huw Rogers <count0@localnet.com>, linux-kernel@vger.kernel.org,
       linux-laptop@mobilix.org
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems on Uniwill N258SA0
Message-ID: <20040127205815.GA19011@elf.ucw.cz>
References: <20040124233749.5637.COUNT0@localnet.com> <20040127083936.GA18246@elf.ucw.cz> <401685F9.6000904@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401685F9.6000904@samwel.tk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>Anyway, sleep/suspend/standby functionality (important to most laptop
> >>users, need to close the lid and go): This checkin to
> >>kernel/power/main.c seems to disable suspend with SMP (!?):
> >>
> >>--- 1.3/kernel/power/main.c	Sat Jan 24 20:44:47 2004
> >>+++ 1.4/kernel/power/main.c	Sat Jan 24 20:44:47 2004
> >>@@ -172,6 +172,12 @@
> >> 	if (down_trylock(&pm_sem))
> >> 		return -EBUSY;
> >>
> >>+	/* Suspend is hard to get right on SMP. */
> >>+	if (num_online_cpus() != 1) {
> >>+		error = -EPERM;
> >>+		goto Unlock;
> >>+	}
> >>+
> >> 	if ((error = suspend_prepare(state)))
> >> 		goto Unlock;
> >>
> >>... which, given the prevalence of hyperthreaded CPUs on laptops, is
> >>fighting a trend. I backed out the above with a #if 0 then tried echo -n
> >>1>/proc/acpi/sleep again. This time I got:
> >
> >
> > Well, no sleep developers have SMP or HT machines, AFAICT.
> >
> > If you back that out... well you are on your own.
> 
> Just a random thought: if I understand it correctly, CPU hotplugging is 
> intended to be able to take CPUs online and offline one by one, am I 
> right? Well, when that infrastructure's ready, this can probably be made 
> to work for SMP by taking all the other CPUs offline first. They're all 
> going to go offline because of the suspend anyway, so it shouldn't make 
> much difference. :)

That was original plan, but CPU hotplug is unlikely to get into 2.6,
AFAICT. (And Nigel has another solution).

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
