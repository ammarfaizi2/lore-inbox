Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVAKNFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVAKNFY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 08:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbVAKNFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 08:05:24 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:57588 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S262736AbVAKNFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 08:05:15 -0500
Message-Id: <200501111305.j0BD58U2000483@localhost.localdomain>
To: Matt Mackall <mpm@selenic.com>
cc: "Jack O'Quin" <joq@io.com>, Chris Wright <chrisw@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Lee Revell <rlrevell@joe-job.com>, arjanv@redhat.com, mingo@elte.hu,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Mon, 10 Jan 2005 13:20:19 PST."
             <20050110212019.GG2995@waste.org> 
Date: Tue, 11 Jan 2005 08:05:08 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.197.39.54] at Tue, 11 Jan 2005 07:05:11 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Rlimits are neither UID/GID or PAM-specific. They fit well within
>the general model of UNIX security, extending an existing mechanism
>rather than adding a completely new one. That PAM happens to be the
>way rlimits are usually administered may be unfortunate, yes, but it
>doesn't mean that rlimits is the wrong way.

agreed, although i note with interest the flap over RLIMIT_MEMLOCK
being made accessible to unprivileged users by people working on
grsecurity. 

>> Running `nice --20' is still significantly worse than SCHED_FIFO, but
>> not the unmitigated disaster shown in the middle column.  But, this
>> improved performance is still not adequate for audio work.  The worst
>> delay was absurdly long (~1/2 sec).
>
>Let's work on that. It'd be _far_ better to have unprivileged near-RT
>capability everywhere without potential scheduling DoS.

I am not sure what you mean here. I think we've established that
SCHED_OTHER cannot be made adequate for realtime audio work. Its
intended purpose (timesharing the machine in ways that should
generally benefit tasks that don't do a lot and/or are dominated by
user interaction, thus rendering the machine apparently responsive) is
really at odds with what we need.

Con has discussed the idea of a new scheduling class, one that has no
internal priority, runs like SCHED_RR but is subject to cpu
utilization limits, and is accessible to unprivileged users. I think
this makes a lot of sense. It can be controlled using sysctl's and/or
rlimit. 

But please note: in any sane world, adding stuff like this could only
take place in an unstable tree. It seems really odd to me that anyone
can be talking about adding any of these *mechanisms* to 2.6. That was
the whole reason we (well, Jack, Torben and others) worked with LSM:
LSM appeared to be the "blessed" method in 2.6 of allowing changes to
security policy to be made. We are now finding out that even if Linus
"blessed" it by inclusion, there is enough vocal opposition to
actually using it for something useful that something else has to be
done. I wouldn't want to run an important machine on 2.6 if adding,
say SCHED_ISO or even RLIMIT_RT_CPU is part of 2.6's "maintainance".

Meanwhile, as I mentioned before, every realtime audio user of 2.6 is
*still* going to use "realtime" LSM because its really the only
effective way to get the privilege needed to do what they want to get
done. 

--p
